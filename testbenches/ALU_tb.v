// Testbench Code Goes here
module ALU_tb;

reg[2:0] ALUOp;
reg signed [15:0] Operand1, Operand2;
wire signed [15:0] ALUOut;
wire Zero;
integer i;

initial begin
  $display ("Time,ALUOp,Operand1,Operand2,ALUOut,Zero,");
  $monitor ("%0d,%b,%b %3d,%b %3d,%b %3d,%b,", $time, ALUOp,Operand1,Operand1,Operand2,Operand2,ALUOut,ALUOut,Zero);
  Operand1 = 0;
  Operand2 = 0;
  for (i=0; i<8; i=i+1) begin
    ALUOp = i; #5;
  end
  
  Operand1 = 30;
  Operand2 = 3;
  for (i=0; i<8; i=i+1) begin
      ALUOp = i; #5;
  end
  
  Operand1 = -10;
  Operand2 = 2;
  for (i=0; i<8; i=i+1) begin
      ALUOp = i; #5;
  end
  
  Operand1 = 10;
  Operand2 = -4;
  for (i=0; i<8; i=i+1) begin
      ALUOp = i; #5;
  end
  
  Operand1 = -1;
  Operand2 = -9;
  for (i=0; i<8; i=i+1) begin
      ALUOp = i; #5;
  end
  $finish;
end

ALU U0 (
    .ALUOp (ALUOp),
    .Operand1 (Operand1),
	.Operand2 (Operand2), 
	.ALUOut (ALUOut),
	.Zero (Zero)
);

endmodule