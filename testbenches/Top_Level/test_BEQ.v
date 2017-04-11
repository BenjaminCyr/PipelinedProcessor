`timescale 1 ns / 1 ps

// ADDI $1, $0, 3
// ADDI $2, $0, 3
// BEQ  $1, $2, +1
// ADDI $3, $0, 1
// BEQ  $1, $0, +1
// ADDI $4, $0, -1
// HALT

module test_BEQ;

parameter RegAddrBits = 3;
parameter DataWidth = 16;
parameter TotalReg = 8;
parameter TestFile = "../../testbenches/Test_Programs/test_BEQ.txt";

reg CLK;
reg RST;
reg [RegAddrBits-1:0] inr;
wire [DataWidth-1:0] out_value;


Pipelined_Processor #(.FileName(TestFile)) p1 (
	.CLK(CLK),
	.RST(RST),
	.inr(inr),
	.out_value(out_value)
);

initial
begin
	#0 CLK = 0;
	#0 inr = 0;
	#0 RST = 1;
	#0 $display ("ADDI $1, $0, 3\nADDI $2, $0, 3\nBEQ  $1, $2, +1\nADDI $3, $0, 1\nBEQ  $1, $0, +1\nADDI $4, $0, -1\nHALT\n");
	#0 $display ("Time, inr, out_value,");
	#10 RST = 0;
	#70 $monitor ("%g ns, %x, %x,", $time, inr, out_value);
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
