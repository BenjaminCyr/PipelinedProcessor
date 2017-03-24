`timescale 1 ns / 1 ps

module test_PC_Muxes;

parameter DataWidth = 16;

reg TakeBranch;
reg TakeJump;
reg PCOverwrite;
reg Halt;
reg Stall;

reg [DataWidth-1:0] PC;
reg [DataWidth-1:0] BranchTarget;
reg [DataWidth-1:0] OverwriteAddress;
reg [DataWidth-1:0] JumpTarget;
wire [DataWidth-1:0] PCPlusOne;

wire [DataWidth-1:0] NextPC;

PC_Muxes p1 (
	.TakeBranch(TakeBranch),
	.TakeJump(TakeJump),
	.PCOverwrite(PCOverwrite),
	.Halt(Halt),
	.Stall(Stall),
	.PC(PC),
	.BranchTarget(BranchTarget),
	.OverwriteAddress(OverwriteAddress),
	.JumpTarget(Jump_target),
	.PCPlusOne(PCPlusOne),
	.NextPC(NextPC)
);

initial 
begin
	#0 $monitor ("%g ns :: TakeBranch=%b, TakeJump=%b, PCOverwrite=%b, Halt=%b, PC=%b, BranchTarget=%b, OverwriteAddress=%b, JumpTarget=%b, PCPlusOne=%b, NextPC=%b", $time, TakeBranch,  TakeJump, PCOverwrite, Halt, PC, BranchTarget, OverwriteAddress, JumpTarget, PCPlusOne, NextPC);
	#0 TakeBranch = 0;
	#0 TakeJump = 0;
	#0 PCOverwrite = 0;
	#0 Halt = 0;
	#0 Stall = 0;
	#0 PC = 0;
	#0 BranchTarget = 10;
	#0 OverwriteAddress = 35;
	#0 JumpTarget = 78;
	#5 TakeBranch = 1;
	#5 TakeBranch = 0;
	#0 TakeJump = 1;
	#5 TakeJump = 0;
	#0 PCOverwrite = 1;
	#5 PCOverwrite = 0;
	#0 Stall = 1;
	#5 Stall = 0;
	#0 Halt = 1;
	#5 Halt = 0;
	#5 $finish;
end

endmodule

