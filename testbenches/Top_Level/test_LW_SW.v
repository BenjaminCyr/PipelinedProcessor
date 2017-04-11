`timescale 1 ns / 1 ps

//ADDI $1, $0, -1
//ADDI $2, $0, 10
//SW $1, 0($2)
//SW $2, -1($2)
//LW $3, 0($2)
//ADD $2, $2, $3
//LW $4, 0($2)
//HALT

module test_LW_SW;

parameter RegAddrBits = 3;
parameter DataWidth = 16;
parameter TotalReg = 8;
parameter TestFile = "../../testbenches/Test_Programs/test_LW_SW.txt";

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
	#0 $display ("ADDI $1, $0, -1\nADDI $2, $0, 10\nSW $1, 0($2)\nSW $2, -1($2)\nLW $3, 0($2)\nADD $2, $2, $3\nLW $4, 0($2)\nHALT\n");
	#0 $display ("Time, inr, out_value,");
	#10 RST = 0;
	#100 $monitor ("%g ns, %x, %x,", $time, inr, out_value);
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
