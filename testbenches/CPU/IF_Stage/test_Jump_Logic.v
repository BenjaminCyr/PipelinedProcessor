`timescale 1 ns / 1 ps

module test_Jump_Logic;

parameter RegWidth = 16;
parameter [RegWidth-1:0] normal_ins = 16'b1001000000010000;
parameter [RegWidth-1:0] jump_ins = 16'b1110001100111010;
parameter [RegWidth-1:0] halt_ins = 16'b0000000000000000;

reg [RegWidth-1:0] Instruction;
reg [RegWidth-1:0] PC;
wire [RegWidth-1:0] JumpAddress;
wire TakeJump;
wire Halt;

Jump_Logic j1 (
	.Instruction(Instruction),
	.PC(PC),
	.JumpAddress(JumpAddress),
	.TakeJump(TakeJump),
	.Halt(Halt)
);

initial
begin
	#0 $monitor ("%g ns :: Instruction=%b, PC=%b, JumpAddress=%b, TakeJump=%b, Halt=%b", $time, Instruction, PC, JumpAddress, TakeJump, Halt);
	#0 Instruction = 0;
	#0 PC = 8;
	#5 Instruction = normal_ins;
	#5 Instruction = jump_ins;
	#5 Instruction = halt_ins;
	#5 Instruction = normal_ins;
	#5 $finish;
end

endmodule
