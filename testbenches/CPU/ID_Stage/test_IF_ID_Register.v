`timescale 1 ns / 1 ps

module test_IF_ID_Register;

parameter InstrWidth = 16;

reg CLK;
reg RST;
reg Stall;
reg Flush;
reg [InstrWidth-1:0] Instruction_In;
wire [InstrWidth-1:0] Instruction_Out;
reg [InstrWidth-1:0] PC_In;
wire [InstrWidth-1:0] PC_Out;
reg Branch_Taken_In;
wire Branch_Taken_Out;

IF_ID_Register i1 (
	.CLK(CLK),
	.RST(RST),
	.Stall(Stall),
	.Flush(Flush),
	.Instruction_In(Instruction_In),
	.Instruction_Out(Instruction_Out),
	.PC_In(PC_In),
	.PC_Out(PC_Out),
	.Branch_Taken_In(Branch_Taken_In),
	.Branch_Taken_Out(Branch_Taken_Out)
);

initial
begin
	#0 $monitor ("%g ns :: CLK=%b, RST=%b, Stall=%b, Flush=%b, Instruction_In=%b, Instruction_Out=%b, PC_In=%b, PC_Out=%b, Branch_Taken_In=%b, Branch_Taken_Out=%b", $time, CLK, RST, Stall, Flush, Instruction_In, Instruction_Out, PC_In, PC_Out, Branch_Taken_In, Branch_Taken_Out);
	#0 CLK = 0;
	#0 RST = 0;
	#0 Stall = 0;
	#0 Flush = 0;
	#0 Instruction_In = 0;
	#0 PC_In = 0;
	#0 Branch_Taken_In = 0;
	#10 Instruction_In = 36;
	#0 PC_In = 54;
	#0 Branch_Taken_In = 1;
	#10 Stall = 1;
	#0 Instruction_In = 25;
	#0 PC_In = 78;
	#0 Branch_Taken_In = 0;
	#10 Flush = 1;
	#10 $finish;
end

always
begin
	#5 CLK = !CLK;
end

endmodule
