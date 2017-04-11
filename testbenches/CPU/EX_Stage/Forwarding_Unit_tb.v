// Testbench Code Goes here
module Forwarding_Unit_tb;

reg EX_MEM_RegWrite, MEM_WB_RegWrite; 
reg[2:0] ID_EX_Rs, ID_EX_Rt, EX_MEM_DestReg, MEM_WB_DestReg;
wire [1:0] ForwardA, ForwardB;

initial begin
  $display ("Time,ID_EX_Rs,ID_EX_Rt,EX_MEM_RegWrite,EX_MEM_DestReg,MEM_WB_RegWrite,MEM_WB_DestReg,ForwardA,ForwardB,");
  $monitor ("%0d,%b,%b,%b,%b,%b,%b,%b,%b,", $time, ID_EX_Rs,ID_EX_Rt,EX_MEM_RegWrite,EX_MEM_DestReg,MEM_WB_RegWrite,
                MEM_WB_DestReg,ForwardA,ForwardB);
  EX_MEM_RegWrite = 0;
  MEM_WB_RegWrite = 0;
  ID_EX_Rs = 0;
  ID_EX_Rt = 0;
  EX_MEM_DestReg = 0;
  MEM_WB_DestReg = 0;
  #5;
  ID_EX_Rs = 1;
  ID_EX_Rt = 7;
  EX_MEM_DestReg = 1;
  MEM_WB_DestReg = 1;
  #5;
  MEM_WB_RegWrite = 1;
  #5;
  EX_MEM_RegWrite = 1;
  #5;
  EX_MEM_DestReg = 7;
  #5;
  MEM_WB_DestReg = 7;
  EX_MEM_RegWrite = 0;
  #5;
  MEM_WB_DestReg = 3;
  #5;
  $finish;
end

Forwarding_Unit U0 (
    .ID_EX_Rs (ID_EX_Rs),
    .ID_EX_Rt (ID_EX_Rt),
	.EX_MEM_RegWrite (EX_MEM_RegWrite), 
	.EX_MEM_DestReg (EX_MEM_DestReg),
	.MEM_WB_RegWrite (MEM_WB_RegWrite),
	.MEM_WB_DestReg (MEM_WB_DestReg), 
    .ForwardA (ForwardA),
    .ForwardB (ForwardB)
);

endmodule