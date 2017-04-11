`timescale 1 ns / 1 ps

module test_WriteBack_Mux;

parameter RegWidth = 16;

reg MemtoReg;
reg [RegWidth-1:0] MemOut;
reg [RegWidth-1:0] ALUOut;
wire [RegWidth-1:0] WriteData;

WriteBack_Mux w1 (
	.MemtoReg(MemtoReg),
	.MemOut(MemOut),
	.ALUOut(ALUOut),
	.WriteData(WriteData)
);

initial 
begin
	#0 $monitor ("%g ns :: MemtoReg=%b, MemOut=%b, ALUOut=%b, WriteData=%b", $time, MemtoReg, MemOut, ALUOut, WriteData);
	#0 MemtoReg = 0;
	#0 MemOut = 45;
	#0 ALUOut = -33;
	#10 MemtoReg = 1;
	#0 MemOut = 100;
	#10 $finish;
end

endmodule
