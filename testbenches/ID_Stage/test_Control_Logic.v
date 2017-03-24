`timescale 1 ns / 1 ps 

module test_Control_Logic;

reg [3:0] Opcode;
wire [12:0] Control_Signals;

parameter [3:0] HALT = 4'b0000;
parameter [3:0] ADD  = 4'b0001;
parameter [3:0] SUB  = 4'b0010;
parameter [3:0] AND  = 4'b0011;
parameter [3:0] OR   = 4'b0100;
parameter [3:0] SLT  = 4'b0101;
parameter [3:0] LSI  = 4'b0110;
parameter [3:0] RSI  = 4'b0111;
parameter [3:0] ADDI = 4'b1000;
parameter [3:0] LW   = 4'b1001;
parameter [3:0] SW   = 4'b1010;
parameter [3:0] BNE  = 4'b1011;
parameter [3:0] BEQ  = 4'b1100;
parameter [3:0] JL   = 4'b1101;
parameter [3:0] J    = 4'b1110;
parameter [3:0] JR   = 4'b1111;

Control_Logic c1 (
	.Opcode(Opcode),
	.Control_Signals(Control_Signals)
);

initial
begin
	#0 $monitor ("%g ns :: Opcode=%b, Control_Signals=%b", $time, Opcode, Control_Signals);
	#0 Opcode = HALT;
	#10 Opcode = ADD;
	#10 Opcode = SUB;
	#10 Opcode = AND;
	#10 Opcode = OR;
	#10 Opcode = SLT;
	#10 Opcode = LSI;
	#10 Opcode = RSI;
	#10 Opcode = ADDI;
	#10 Opcode = LW;
	#10 Opcode = SW;
	#10 Opcode = BNE;
	#10 Opcode = BEQ;
	#10 Opcode = JL;
	#10 Opcode = J;
	#10 Opcode = JR;
	#10 $finish;
end

endmodule
