`timescale 1 ns / 1 ps

module test_Register_File;

parameter RegWidth = 16;
parameter AddrBits = 3;

reg CLK;
reg RST;
reg WriteEN;
reg [AddrBits-1:0] ReadAddr1;
reg [AddrBits-1:0] ReadAddr2;

wire [RegWidth-1:0] ReadData1;
wire [RegWidth-1:0] ReadData2;

reg [AddrBits-1:0] WriteAddr;
reg [RegWidth-1:0] WriteData;

reg [AddrBits-1:0] inr;
wire [RegWidth-1:0] out_value;

Register_File r1 (
	.CLK(CLK),
	.RST(RST),
	.WriteEN(WriteEN),
	.ReadAddr1(ReadAddr1),
	.ReadAddr2(ReadAddr2),
	.ReadData1(ReadData1),
	.ReadData2(ReadData2),
	.WriteAddr(WriteAddr),
	.WriteData(WriteData),
	.inr(inr),
	.out_value(out_value)
);

initial
begin
	#0 $monitor ("%g ns :: CLK=%b, RST=%b, WriteEN=%b, ReadAddr1=%b, ReadAddr2=%b, ReadData1=%b, ReadData2=%b, WriteAddr=%b, WriteData=%b, inr=%b, out_value=%b", $time,  CLK, RST, WriteEN, ReadAddr1, ReadAddr2, ReadData1, ReadData2, WriteAddr, WriteData, inr, out_value);
	#0 CLK = 1;
	#0 RST = 0;
	#0 WriteEN = 0;
	#0 ReadAddr1 = 0;
	#0 ReadAddr2 = 0;
	#0 WriteAddr = 0;
	#0 WriteData = 0;
	#0 inr = 0;
	#10 WriteAddr = 1;
	#0 WriteData = 25;
	#0 WriteEN = 1;
	#10 WriteAddr = 2;
	#0 WriteData = 99;
	#10 WriteAddr = 3;
	#0 WriteData = -40;
	#10 WriteEN = 0;
	#0 ReadAddr1 = 1;
	#0 ReadAddr2 = 2;
	#0 inr = 3;
	#10 RST = 1;
	#10 RST = 0;
	#10 $finish;
end

always
begin
	#5 CLK = !CLK;
end

endmodule

