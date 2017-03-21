----------------------------------------------
-- File: 		Instruction_Memory.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 20, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Instruction_Memory is
	generic (DataWidth : integer := 16;
			 AddrBits : integer := 16);
	port (
		ReadAddr: in std_logic_vector(AddrBits-1 downto 0);
		ReadData: out std_logic_vector(RegWidth-1 downto 0));
end entity Instruction_Memory;

architecture Instruction_Memory_Behavior of Instruction_Memory is
	constant zero_reg : std_logic_vector(AddrBits-1 downto 0) := (others <= '0');
	subtype WORD is std_logic_vector(RegWidth-1 downto 0);
	type MEMORY is array(1 to 2**AddrBits - 1) of WORD;
	signal registers: MEMORY := (others=> (others => '0'));
	begin
		with ReadAddr select ReadData <=
			x"0000" when x"0000",
			x"0000" when x"0001",
			x"0000" when x"0002",
			x"0000" when x"0003",
			x"0000" when x"0004",
			x"0000" when others;
end architecture Instruction_Memory_Behavior;
