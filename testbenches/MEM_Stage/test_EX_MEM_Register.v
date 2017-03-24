`timescale 1 ns / 1 ps

module test_EX_MEM_Register;

parameter RegWidth = 16;
parameter AddrBits = 3;
parameter ControlBits = 4;

reg CLK;
reg RST;
reg [ControlBits-1:0] Control_In;
wire [ControlBits-1:0] Control_Out;
reg [RegWidth-1:0] ALUOut_In;
wire [RegWidth-1:0] ALUOut_Out;
reg [RegWidth-1:0] MemData_In;
wire [RegWidth-1:0] MemData_Out;
reg [AddrBits-1:0] DestReg_In;
wire [AddrBits-1:0] DestReg_Out;

EX_MEM_Register e1 (
	.CLK(CLK),
	.RST(RST),
	.Control_In(Control_In),
	.Control_Out(Control_Out),
	.ALUOut_In(ALUOut_In),
	.ALUOut_Out(ALUOut_Out),
	.MemData_In(MemData_In),
	.MemData_Out(MemData_Out),
	.DestReg_In(DestReg_In),
	.DestReg_Out(DestReg_Out)
);

initial 
begin
	#0 $monitor ("%g ns :: CLK=%b, RST=%b, Control_In=%b, Control_Out=%b, ALUOut_In=%b, ALUOut_Out=%b, MemData_In=%b, MemData_Out=%b, DestReg_In=%b, DestReg_Out=%b", $time, CLK, RST, Control_In, Control_Out, ALUOut_In, ALUOut_Out, MemData_In, MemData_Out, DestReg_In, DestReg_Out);
	#0 CLK = 0;
	#0 RST = 0;
	#0 Control_In = 0;
	#0 ALUOut_In = 0;
	#0 MemData_In = 0;
	#0 DestReg_In = 0;
	#10 Control_In = 4;
	#0 ALUOut_In = 35;
	#0 MemData_In = 45;
	#0 DestReg_In = 5;
	#10 RST = 1;
	#10 RST = 0;
	#10 $finish;
end

always
begin
	#5 CLK = !CLK;
end

endmodule
