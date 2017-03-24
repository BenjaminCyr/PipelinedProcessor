`timescale 1 ns / 1 ps

module test_Instruction_Memory;

parameter DataWidth = 16;
parameter AddrBits = 16;

parameter [AddrBits-1:0] addr1 = 16'b0000000000000001;
parameter [AddrBits-1:0] addr2 = 16'b0000000000000010;

reg [AddrBits-1:0] ReadAddr;
wire [DataWidth-1:0] ReadData;

Instruction_Memory i1 (
	.ReadAddr(ReadAddr),
	.ReadData(ReadData)
);

initial
begin
	#0 $monitor ("%g ns :: ReadAddr=%b, ReadData=%b", $time, ReadAddr, ReadData);
	#0 ReadAddr = 0;
	#5 ReadAddr = addr1;
	#5 ReadAddr = addr2;
	#5 $finish;
end

endmodule
