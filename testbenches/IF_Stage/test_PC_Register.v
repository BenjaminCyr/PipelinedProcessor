`timescale 1 ns / 1 ps

module test_PC_Register;

parameter RegWidth = 16;

reg CLK;
reg RST;
reg [RegWidth-1:0] PC_In;

wire [RegWidth-1:0] PC_Out;

PC_Register p1 (
	.CLK(CLK),
	.RST(RST),
	.PC_In(PC_In),
	.PC_Out(PC_Out)
);

initial
begin
	#0 $monitor ("%g ns :: CLK=%b, RST=%b, PC_In=%b,PC_Out=%b", $time, CLK, RST, PC_In, PC_Out);
	#0 CLK = 0;
	#0 RST = 0;
	#0 PC_In = 0;
	#10 PC_In = 59;
	#10 RST = 1;
	#10 RST = 0;
	#0 PC_In = 93;
	#10 RST = 1;
	#10 $finish;
end

always
begin
	#5 CLK = !CLK;
end

endmodule
