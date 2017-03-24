// Testbench Code Goes here
module ID_EX_Register_tb;

reg CLK, RST, Stall, Flush, Branch_Taken_In; 
reg[12:0] Control_In;
reg[15:0] PC_In, ReadData1_In, ReadData2_In, Imm_In;
reg [2:0] Rs_In, Rt_In, Rd_In;
wire Branch_Taken_Out; 
wire[12:0] Control_Out;
wire[15:0] PC_Out, ReadData1_Out, ReadData2_Out, Imm_Out;
wire [2:0] Rs_Out, Rt_Out, Rd_Out;

initial begin
  $display ("Time,CLK,RST,Stall,Flush,Control_In,Control_Out,Branch_Taken_In,Branch_Taken_Out,PC_In,PC_Out,ReadData1_In,ReadData1_Out,ReadData2_In,ReadData2_Out,Imm_In,Imm_Out,Rs_In,Rs_Out,Rt_In,Rt_Out,Rd_In,Rd_Out");
  $monitor ("%0d,%b,%b,%b,%b,%h,%h,%b,%b,%h,%h,%h,%h,%h,%h,%h,%h,%b,%b,%b,%b,%b,%b,", $time, CLK,RST,Stall,Flush,Control_In,Control_Out,Branch_Taken_In,Branch_Taken_Out,PC_In,PC_Out,ReadData1_In,
                ReadData1_Out,ReadData2_In,ReadData2_Out,Imm_In,Imm_Out,Rs_In,Rs_Out,Rt_In,Rt_Out,Rd_In,Rd_Out);
  CLK = 0;
  RST = 1;
  Stall = 0;
  Flush = 0;
  Branch_Taken_In = 0;
  Control_In = 'h1FFF;
  PC_In = 'hAAAA;
  ReadData1_In = 'h1111;
  ReadData2_In = 'h2222;
  Imm_In = 'hBBBB;
  Rs_In = 1;
  Rt_In = 2;
  Rd_In = 3;
  
  #10;
  RST = 0;
  
  #10;
  Branch_Taken_In = 1;
  Control_In = 'h1000;
  PC_In = 'hCCCC;
  ReadData1_In = 'h3333;
  ReadData2_In = 'h4444;
  Imm_In = 'hDDDD;
  Rs_In = 5;
  Rt_In = 6;
  Rd_In = 7;
  
  #10;
  Stall = 1;
  
  #10;
  Stall = 0;
  Branch_Taken_In = 0;
  Control_In = 'h1FFF;
  PC_In = 'hAAAA;
  ReadData1_In = 'h1111;
  ReadData2_In = 'h2222;
  Imm_In = 'hBBBB;
  Rs_In = 1;
  Rt_In = 2;
  Rd_In = 3;
  
  #10;
  Flush = 1;
  
  #10;
  Flush = 0;
  Branch_Taken_In = 0;
  Control_In = 'h1FFF;
  PC_In = 'hAAAA;
  ReadData1_In = 'h1111;
  ReadData2_In = 'h2222;
  Imm_In = 'hBBBB;
  Rs_In = 1;
  Rt_In = 2;
  Rd_In = 3;
  
  #10;
  RST = 1;
  #10;
  $finish;
end

always begin
  #5 CLK = !CLK;
end

ID_EX_Register U0 (
    .CLK (CLK),
    .RST (RST),
	.Stall (Stall), 
	.Flush (Flush),
	.Control_In (Control_In),
	.Control_Out (Control_Out), 
    .Branch_Taken_In (Branch_Taken_In),
    .Branch_Taken_Out (Branch_Taken_Out),
    .PC_In (PC_In),
    .PC_Out (PC_Out), 
    .ReadData1_In (ReadData1_In),
    .ReadData1_Out (ReadData1_Out),
    .ReadData2_In (ReadData2_In), 
    .ReadData2_Out (ReadData2_Out),
    .Imm_In (Imm_In),
    .Imm_Out (Imm_Out), 
    .Rs_In (Rs_In),
    .Rs_Out (Rs_Out),
    .Rt_In (Rt_In), 
    .Rt_Out (Rt_Out),
    .Rd_In (Rd_In), 
    .Rd_Out (Rd_Out)
);

endmodule