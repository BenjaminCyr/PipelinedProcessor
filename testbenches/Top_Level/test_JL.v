`timescale 1 ns / 1 ps

// ADDI $1, $0, 1
// JL HALT
// ADDI $1, $1, 1
// HALT

module test_JL;

parameter RegAddrBits = 3;
parameter DataWidth = 16;
parameter TotalReg = 8;
parameter TestFile = "../../testbenches/Test_Programs/test_JL.txt";

reg CLK;
reg RST;
reg [RegAddrBits-1:0] inr;
wire [DataWidth-1:0] out_value;

wire MemRead;
wire MemWrite;
wire [DataWidth-1:0] MemAddr; 
wire [DataWidth-1:0] MemData;
reg [DataWidth-1:0] MemOutput;


Pipelined_Processor #(.FileName(TestFile)) p1 (
	.CLK(CLK),
	.RST(RST),
	.inr(inr),
	.out_value(out_value),
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.MemAddr(MemAddr),
	.MemData(MemData),
	.MemOutput(MemOutput)
);

initial
begin
	#0 CLK = 0;
	#0 inr = 0;
	#0 RST = 1;
	#0 MemOutput = 0;
	#0 $display ("ADDI $1, $0, 1\nJL HALT\nADDI $1, $1, 1\nHALT\n");
	#0 $display ("Time, inr, out_value,");
	#10 RST = 0;
	#50 $monitor ("%g ns, %x, %x,", $time, inr, out_value);
	for (integer j=0; j<TotalReg; j=j+1)
	begin
		inr = j;
		#10;
	end
	#0 $finish;	
end

always
begin
	#5 CLK = !CLK;
end

endmodule
