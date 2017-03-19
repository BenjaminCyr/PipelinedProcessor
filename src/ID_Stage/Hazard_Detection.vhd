----------------------------------------------
-- File: 		Hazard_Detection.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 17, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Hazard_Detection is
	generic (AddrBits : integer := 3);
	port (
		IF_ID_Rs: in std_logic_vector(AddrBits-1 downto 0);
		IF_ID_Rt: in std_logic_vector(AddrBits-1 downto 0);
		ID_EX_Rt: in std_logic_vector(AddrBits-1 downto 0);
		ID_EX_MemRead: in std_logic;
		Stall: out std_logic);
end entity Hazard_Detection;

architecture Hazard_Detection_Behavior of Hazard_Detection is
	begin
		Stall <= '1' when (ID_EX_MemRead = '1') and ((ID_EX_Rt = IF_ID_Rt) 
				or (ID_EX_Rt = IF_ID_Rs)) else
				'0';
end architecture Hazard_Detection_Behavior;
