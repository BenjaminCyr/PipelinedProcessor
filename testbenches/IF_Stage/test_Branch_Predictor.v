`timescale 1 ns / 1 ps

module test_Branch_Predictor;

parameter DataWidth = 16;
parameter AddrBits = 16;

reg CLK;
reg RST;
reg PredictionMiss;
reg [DataWidth-1:0] Instruction;
reg [DataWidth-1:0] PCPlusOne;
reg ShouldBranch;
reg [AddrBits-1:0] BranchSourceAddress;
reg [AddrBits-1:0] BranchTargetAddress;

wire [AddrBits-1:0] PredictedAddress;
wire TakeBranch;

Branch_Predictor b1 (
	.CLK(CLK),
	.RST(RST),
	.PredictionMiss(PredictionMiss),
	.Instruction(Instruction),
	.PCPlusOne(PCPlusOne),
	.ShouldBranch(ShouldBranch),
	.BranchSourceAddress(BranchSourceAddress),
	.BranchTargetAddress(BranchTargetAddress),
	.PredictedAddress(PredictedAddress),
	.TakeBranch(TakeBranch)
);

initial
begin
	#0 $monitor ("%g ns :: CLK=%b, RST=%b, PredictionMiss=%b, Instruction=%b, PCPlusOne=%b, ShouldBranch=%b, BranchSourceAddress=%b, BranchTargetAddress=%b, PredictedAddress=%b, TakeBranch=%b", $time, CLK, RST, PredictionMiss, Instruction, PCPlusOne, ShouldBranch, BranchSourceAddress, BranchTargetAddress, PredictedAddress, TakeBranch); 
	#0 CLK = 0;

end

always
begin
	#5 CLK = !CLK;
end

endmodule
