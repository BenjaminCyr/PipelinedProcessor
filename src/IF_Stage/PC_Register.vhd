----------------------------------------------
-- File: 		PC_Register.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 20, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity PC_Register is
	generic (RegWidth : integer := 16);
	port (
    	CLK: in std_logic;
		RST: in std_logic;
		PC_In: in std_logic_vector(RegWidth-1 downto 0);
		PC_Out: out std_logic_vector(RegWidth-1 downto 0));
end entity PC_Register;

architecture PC_Register_Behavior of PC_Register is
	signal PC: std_logic_vector(RegWidth-1 downto 0);
	begin
		PC_Out <= PC;
		process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '1' then
					PC <= (others => '0');
				else
					PC <= PC_In;
				end if;
			end if;
		end process;
end architecture PC_Register_Behavior;
