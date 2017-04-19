----------------------------------------------
-- File: 		Control_Logic.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 17, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Control_Logic is
	generic (OpcodeBits : integer := 4;
			ControlBits : integer := 13);
	port (
		Opcode: in std_logic_vector(OpcodeBits-1 downto 0);
		Control_Signals: out std_logic_vector(ControlBits-1 downto 0));
end entity Control_Logic;

architecture Control_Logic_Behavior of Control_Logic is
	type instructions is (HALT, ADD, SUB, ANDD, ORR, SLT, LSI, RSI, 
							ADDI, LW, SW, BNE, BEQ, JL, J, JR)
	signal current_instruction : instructions := HALT;
	begin
		current_instruction <= Opcode(3 downto 0);
		with current_instruction select
			Control_Signals <= "0000000000000" when HALT,
							"0010100000010" when ADD,
							"0100100000010" when SUB,
							"0110100000010" when ANDD,
							"1000100000010" when ORR,
							"1010100000010" when SLT,
							"1101000000010" when LSI,
							"1111000000010" when RSI,
							"0011000000010" when ADDI,
							"0011000000111" when LW,
							"0011000001000" when SW,
							"0100011000000" when BNE,
							"0100010000000" when BEQ,
							"0000000010010" when JL,
							"0000000000000" when J,
							"0000000100000" when JR,
							"XXXXXXXXXXXXX" when others;
end architecture Control_Logic_Behavior;

