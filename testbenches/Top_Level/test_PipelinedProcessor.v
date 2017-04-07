`timescale 1 ns / 1 ps

//	ADDI $2, $0, 4
//	ADDI $3, $0, 1
//L1: SUB $2, $2, $3
//	BNE $2, $3, L1
//	ADD $4, $2, $3
//	OR $5, $4, $3
//	AND $6, $5, $3
//L2: BEQ $5, $0, L3	
//	LSI $5, $5, 4
//	RSI $4, $4, 1
//	J L2
//L3: ADDI $2, $0, 5
//	JL FIB
//  SLT $2, $0, $1
//	HALT
//FIB: ADDI $1, $0, 1
//	ADDI $3, $0, 1
//L4: ADDI $2, $2, -1
//	BEQ $2, $0, L5
//	ADD $4, $3, $1
//	ADD $1, $3, $0
//  ADD $3, $4, $0
//	J L4
//L5: ADD $1, $4, $0
//	JR $7

module test_PipelinedProcessor;

parameter RegAddrBits = 3;
parameter DataWidth = 16;
parameter TotalReg = 8;
parameter TestFile = "../../testbenches/Test_Programs/test_PipelinedProcessor.txt";

integer j;
reg CLK;
reg RST;
reg [RegAddrBits-1:0] inr;
wire [DataWidth-1:0] out_value;

wire MemRead;
wire MemWrite;
wire [DataWidth-1:0] MemAddr; 
wire [DataWidth-1:0] MemData;
reg [DataWidth-1:0] MemOutput;


Pipelined_Processor #(.FileName(TestFile)) p1 (
	.CLK(CLK),
	.RST(RST),
	.inr(inr),
	.out_value(out_value),
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.MemAddr(MemAddr),
	.MemData(MemData),
	.MemOutput(MemOutput)
);

initial
begin
	#0 CLK = 0;
	#0 inr = 0;
	#0 RST = 1;
	#0 MemOutput = 0;
	#0 $display ("	ADDI $2, $0, 4\n  ADDI $3, $0, 1\nL1: SUB $2, $2, $3\n  BNE $2, $3, L1\n  ADD $4, $2, $3\n  OR $5, $4, $3\n  AND $6, $5, $3\nL2: BEQ $5, $0, L3\n  LSI $5, $5, 4\n  RSI $4, $4, 1\n  J L2\nL3: ADDI $2, $0, 5\n  JL FIB\n  SLT $2, $0, $1\n  HALT\nFIB: ADDI $1, $0, 1\n  ADDI $3, $0, 1\nL4: ADDI $2, -1\n  BEQ $2, $0, L5\n  ADD $4, $3, $1\n  ADD $1, $3, $0\n  ADD $3, $4, $0\n  J L4\nL5: ADD $1, $4, $0\n  JR $7\n");
	#0 $display ("Time, inr, out_value,");
	#10 RST = 0;
	#800 $monitor ("%g ns, %x, %x,", $time, inr, out_value);
	for (j=0; j<TotalReg; j=j+1)
	begin
		inr = j;
		#10;
	end
	#0 $finish;	
end

always
begin
	#5 CLK = !CLK;
end

endmodule

