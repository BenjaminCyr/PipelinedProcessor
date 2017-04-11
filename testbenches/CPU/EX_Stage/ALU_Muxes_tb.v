// Testbench Code Goes here
module ALU_Muxes_tb;

reg RegDst, ALUSrc; 
reg[2:0] Rt, Rd;
wire [2:0] DestReg;
reg [1:0] ForwardA, ForwardB;
reg [15:0] Mem_ALUOut, WB_WriteData, ReadData1, ReadData2, Imm;
wire [15:0] Operand1, Operand2;
integer i;

initial begin
  $display ("Time,RegDst,Rt,Rd,DestReg,ALUSrc,ForwardA,ForwardB,Mem_ALUOut,WB_WriteData,ReadData1,ReadData2,Imm,Operand1,Operand2,");
  $monitor ("%0d,%b,%b,%b,%b,%b,%b,%b,%h,%h,%h,%h,%h,%h,%h,", $time, RegDst,Rt,Rd,DestReg,ALUSrc,
                    ForwardA,ForwardB,Mem_ALUOut,WB_WriteData,ReadData1,ReadData2,Imm,Operand1,Operand2);
  RegDst = 0;
  Rt = 1;
  Rd = 2;
  ALUSrc = 0;
  ForwardA = 2'b00;
  ForwardB = 2'b00;
  ReadData1 = 16'h1111;
  ReadData2 = 16'h2222;
  Mem_ALUOut = 16'hAAAA;
  WB_WriteData = 16'hBBBB;
  Imm = 16'hFFFF;
  #5;
  RegDst = 1;
  ALUSrc = 1;
  ForwardB = 2'b01;
  #5;
  ALUSrc = 0;
  ForwardA = 2'b10;
  #5;
  ForwardA = 2'b01;
  ForwardB = 2'b10;
  #5;
  RegDst = 0;
  ForwardA = 2'b00;
  ForwardB = 2'b00;
  #5;
  $finish;
end

ALU_Muxes U0 (
    .RegDst (RegDst),
    .Rt (Rt),
	.Rd (Rd), 
	.DestReg (DestReg),
	.ALUSrc (ALUSrc),
	.ForwardA (ForwardA), 
    .ForwardB (ForwardB),
    .Mem_ALUOut (Mem_ALUOut),
    .WB_WriteData (WB_WriteData),
    .ReadData1 (ReadData1), 
    .ReadData2 (ReadData2),
    .Imm (Imm),
    .Operand1 (Operand1), 
    .Operand2 (Operand2)
);

endmodule