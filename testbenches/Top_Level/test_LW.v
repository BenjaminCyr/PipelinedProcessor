`timescale 1 ns / 1 ps

//LW $2, 0($0)
//LW $3, 1($0)
//LW $4, 0($3)
//LW $5, -1($3)
//HALT

//RAM:
//0x0000: AAAA
//0x0001: 0002
//0x0002: 1234

module test_LW;

parameter RegAddrBits = 3;
parameter DataWidth = 16;
parameter TotalReg = 8;
parameter TestFile = "../../testbenches/Test_Programs/test_LW.txt";
parameter DataFile = "../../testbenches/Test_Programs/test_LW_data.txt";


reg CLK;
reg RST;
reg [RegAddrBits-1:0] inr;
wire [DataWidth-1:0] out_value;

Pipelined_Processor #(.FileName(TestFile),.DataFileName(DataFile)) p1 (
	.CLK(CLK),
	.RST(RST),
	.inr(inr),
	.out_value(out_value)
);

initial
begin
	#0 CLK = 0;
	#0 inr = 0;
	#0 RST = 1;
	#0 $display ("LW $2, 0($0)1\nLW $3, 1($0)\nLW $4, 0($3)\nLW $5, -1($3)\nHALT\n\nRAM:\n0x0000: AAAA\n0x0001: 0002\n0x0002: 1234\n");
	#0 $display ("Time, inr, out_value,");
	#10 RST = 0;
	#100 $monitor ("%g ns, %x, %x,", $time, inr, out_value);
	for (integer j=0; j<TotalReg; j=j+1)
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
