// Testbench Code Goes here
module Branch_Unit_tb;

reg BranchTaken, Branch, BEQ_BNE, Zero, JumpReg; 
reg [15:0] PC, Imm, RegData;
wire ShouldBranch, PredictionMiss, Flush;
wire [15:0] BranchTargetAddr;
integer i;

initial begin
  $display ("Time,BranchTaken,Branch,BEQ_BNE,Zero,JumpReg,PC,Imm,RegData,ShouldBranch,PredictionMiss,Flush,BranchTargetAddr,");
  $monitor ("%0d,%b,%b,%b,%b,%b,%h,%h,%h,%b,%b,%b,%h,", $time, BranchTaken,Branch,BEQ_BNE,Zero,JumpReg,PC,Imm,RegData,
                ShouldBranch,PredictionMiss,Flush,BranchTargetAddr);

  BranchTaken = 0;
  Branch = 0;
  BEQ_BNE = 0;
  Zero = 0;
  JumpReg = 0;
  PC = 'h0001;
  Imm = 'h000F;
  RegData = 'hFFFF;
  #5; 
  Zero = 1;
  #5;
  BEQ_BNE = 1;
  #5;
  Branch = 1;
  BEQ_BNE = 0;
  Zero = 1;
  #5;
  BranchTaken = 1;
  #5;
  BEQ_BNE = 1;
  #5;
  Zero = 0;
  #5;
  JumpReg = 1;
  #5;
  JumpReg = 0;
  Branch = 0;
  BranchTaken = 0;
  BEQ_BNE = 0;
  #5;
  $finish;
end

Branch_Unit U0 (
    .BranchTaken (BranchTaken),
    .Branch (Branch),
	.BEQ_BNE (BEQ_BNE), 
	.Zero (Zero),
	.PC (PC),
	.JumpReg (JumpReg), 
    .Imm (Imm),
    .RegData (RegData),
    .ShouldBranch (ShouldBranch),
    .PredictionMiss (PredictionMiss), 
    .BranchTargetAddr (BranchTargetAddr),
    .Flush (Flush)
);

endmodule