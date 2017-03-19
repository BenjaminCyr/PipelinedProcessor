----------------------------------------------
-- File: 		WriteBack_Mux.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 19, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity WriteBack_Mux is
	generic (RegWidth : integer := 16);
	port (
		MemtoReg: in std_logic;
		MemOut: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut: in std_logic_vector(RegWidth-1 downto 0);
		WriteData: out std_logic_vector(RegWidth-1 downto 0));
end entity WriteBack_Mux;

architecture WriteBack_Mux_Behavior of WriteBack_Mux is
	begin
		WriteData <= MemOut when MemtoReg = '1' else ALUOut;
end architecture WriteBack_Mux_Behavior;
