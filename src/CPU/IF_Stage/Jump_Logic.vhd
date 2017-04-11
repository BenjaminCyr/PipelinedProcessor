----------------------------------------------
-- File: 		Jump_Logic.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 20, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Jump_Logic is
	generic (RegWidth : integer := 16;
	         OpcodeBits : integer := 4);
	port (
		Instruction: in std_logic_vector(RegWidth-1 downto 0);
		PC_HighBits: in std_logic_vector(OpcodeBits-1 downto 0);
		JumpAddress: out std_logic_vector(RegWidth-1 downto 0);
		TakeJump: out std_logic;
		Halt: out std_logic);
end entity Jump_Logic;

architecture Jump_Logic_Behavior of Jump_Logic is
	signal Opcode : std_logic_vector(3 downto 0);
	signal JumpBits: std_logic_vector(RegWidth-OpcodeBits-1 downto 0);
	begin
		Opcode <= Instruction(RegWidth-1 downto RegWidth-4);
		JumpBits <= Instruction(RegWidth-5 downto 0);
		TakeJump <= '1' when Opcode = "1110" or Opcode = "1101" else '0';
		Halt <= '1' when Opcode = "0000" else '0';
		JumpAddress <= PC_HighBits & JumpBits;
end architecture Jump_Logic_Behavior;

