`timescale 1 ns / 1 ps 

module test_Hazard_Detection;

parameter AddrBits = 3;

reg [AddrBits-1:0] IF_ID_Rs;
reg [AddrBits-1:0] IF_ID_Rt;
reg [AddrBits-1:0] ID_EX_Rt;
reg ID_EX_MemRead;

wire Stall;

Hazard_Detection h1 (
	.IF_ID_Rs(IF_ID_Rs),
	.IF_ID_Rt(IF_ID_Rt),
	.ID_EX_Rt(ID_EX_Rt),
	.ID_EX_MemRead(ID_EX_MemRead),
	.Stall(Stall)
);

initial 
begin
	#0 $monitor ("%g ns :: IF_ID_Rs=%b, IF_ID_Rt=%b, ID_EX_Rt=%b, ID_EX_MemRead=%b, Stall=%b", $time, IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, ID_EX_MemRead, Stall);
	#0 IF_ID_Rs = 0;
	#0 IF_ID_Rt = 0;
	#0 ID_EX_Rt = 0;
	#0 ID_EX_MemRead = 0;
	#10 IF_ID_Rs = 2;
	#0 IF_ID_Rt = 3;
	#0 ID_EX_Rt = 4;
	#0 ID_EX_MemRead = 1;
	#10 ID_EX_Rt = 3;
	#10 $finish;
end

endmodule
