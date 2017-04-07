`timescale 1 ns / 1 ps

// ADDI $1, $0, -1
// ADDI $2, $0, 3
// SLT $3, $1, $2
// SLT $4, $2, $1
// SLT $5, $1, $1
// HALT

module test_SLT;

parameter RegAddrBits = 3;
parameter DataWidth = 16;
parameter TotalReg = 8;
parameter TestFile = "../../testbenches/Test_Programs/test_SLT.txt";

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
	#0 $display ("ADDI $1, $0, -1\nADDI $2, $0, 3\nSLT $3, $1, $2\nSLT $4, $2, $1\nSLT $5, $1, $1\nHALT\n");
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
