----------------------------------------------
-- File: 		Link_Muxes.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 18, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Link_Muxes is
	generic (AddrBits: integer := 3;
			RegWidth : integer := 16);
	port (
		Link: in std_logic;
		DestReg_In: in std_logic_vector(AddrBits-1 downto 0);
		DestReg_Out: out std_logic_vector(AddrBits-1 downto 0);
		ALUOut_In: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut_Out: out std_logic_vector(RegWidth-1 downto 0);
		PC: in std_logic_vector(RegWidth-1 downto 0));
end entity Link_Muxes;

architecture Link_Muxes_Behavior of Link_Muxes is
	begin
		ALUOut_Out <= PC when Link = '1' else ALUOut_In;
		DestReg_Out <= (others => '1') when Link = '1' else DestReg_In;
end architecture Link_Muxes_Behavior;
