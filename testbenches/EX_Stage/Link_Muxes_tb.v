// Testbench Code Goes here
module Link_Muxes_tb;

reg Link; 
reg[2:0] DestReg_In;
reg [15:0] ALUOut_In, PC;
wire [2:0] DestReg_Out;
wire [15:0] ALUOut_Out;

initial begin
  $display ("Time,Link,DestReg_In,DestReg_Out,ALUOut_In,ALUOut_Out,PC,");
  $monitor ("%0d,%b,%b,%b,%h,%h,%h", $time, Link,
                DestReg_In,DestReg_Out,ALUOut_In,ALUOut_Out,PC);
  Link = 0;
  DestReg_In = 0;
  ALUOut_In = 'h0000;
  PC = 'hFFFF;
  #5;
  DestReg_In = 1;
  ALUOut_In = 'h1111;
  #5;
  Link = 1;
  DestReg_In = 2;
  ALUOut_In = 'h2222;
  #5;
  Link = 0;
  DestReg_In = 3;
  ALUOut_In = 'h3333;
  #5;
  $finish;
end

Link_Muxes U0 (
    .Link (Link),
    .DestReg_In (DestReg_In),
	.DestReg_Out (DestReg_Out), 
	.ALUOut_In (ALUOut_In),
	.ALUOut_Out (ALUOut_Out),
	.PC (PC)
);

endmodule