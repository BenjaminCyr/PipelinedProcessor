----------------------------------------------
-- File: 		Forwarding_Unit.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 18, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Forwarding_Unit is
	generic (AddrBits : integer := 3);
	port (
		ID_EX_Rs: in std_logic_vector(AddrBits-1 downto 0);
		ID_EX_Rt: in std_logic_vector(AddrBits-1 downto 0);
		EX_MEM_RegWrite: in std_logic;
		EX_MEM_DestReg: in std_logic_vector(AddrBits-1 downto 0);
		MEM_WB_RegWrite: in std_logic;
		MEM_WB_DestReg: in std_logic_vector(AddrBits-1 downto 0);
		ForwardA: out std_logic_vector(1 downto 0);
		ForwardB: out std_logic_vector(1 downto 0));
end entity Forwarding_Unit;

architecture Forwarding_Unit_Behavior of Forwarding_Unit is
	begin
		ForwardA <= "01" when EX_MEM_RegWrite = '1' 
							and EX_MEM_DestReg = ID_EX_Rs else
					"10" when MEM_WB_RegWrite = '1' 
							and MEM_WB_DestReg = ID_EX_Rs else
					"00";
		ForwardB <= "01" when EX_MEM_RegWrite = '1' 
							and EX_MEM_DestReg = ID_EX_Rt else
					"10" when MEM_WB_RegWrite = '1' 
							and MEM_WB_DestReg = ID_EX_Rt else
					"00";
end architecture Forwarding_Unit_Behavior;
