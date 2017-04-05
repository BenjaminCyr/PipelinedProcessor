`timescale 1 ns / 1 ps

module test_Instruction_Memory;

parameter DataWidth = 16;
parameter AddrBits = 16;

parameter [AddrBits-1:0] addr0 = 16'b0000000000000000;
parameter [AddrBits-1:0] addr1 = 16'b0000000000000001;
parameter [AddrBits-1:0] addr2 = 16'b0000000000000010;
parameter [AddrBits-1:0] addr3 = 16'b0000000000000011;

reg CLK;
reg [AddrBits-1:0] ReadAddr;
wire [DataWidth-1:0] ReadData;

Instruction_Memory i1 (
    .CLK(CLK),
	.ReadAddr(ReadAddr),
	.ReadData(ReadData)
);

initial
begin
	#0 $monitor ("%g ns :: CLK=%b, ReadAddr=%b, ReadData=%b", $time, CLK, ReadAddr, ReadData);
	#0 ReadAddr = 0;
	#0 CLK = 0;
	#10 ReadAddr = addr0;
    #10 ReadAddr = addr1;
	#10 ReadAddr = addr2;
	#10 ReadAddr = addr3;
	#10 $finish;
end

always
begin
	#5 CLK = !CLK;
end

endmodule
