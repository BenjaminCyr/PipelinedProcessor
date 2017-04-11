`timescale 1 ns / 1 ps

module test_Sign_Extender;

parameter InSize = 6;
parameter OutSize = 16;

reg [InSize-1:0] in;
wire [OutSize-1:0] out;

Sign_Extender s1 (
	.Input(in),
	.Output(out)
);

initial 
begin
	#0 $monitor ("%g ns :: Input=%b, Output=%b", $time, in, out);
	#5 in = 5;
	#5 in = 31;
	#5 in = -20;
	#5 in = -30;
	#5 $finish;
end

endmodule
