----------------------------------------------
-- File: 		MEM_WB_Register.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 19, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity MEM_WB_Register is
	generic (RegWidth : integer := 16;
			 ControlBits : integer := 2;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		RST: in std_logic;
		Control_In: in std_logic_vector(ControlBits-1 downto 0);
		Control_Out: out std_logic_vector(ControlBits-1 downto 0);
		MemOut_In: in std_logic_vector(RegWidth-1 downto 0);
		MemOut_Out: out std_logic_vector(RegWidth-1 downto 0);
		ALUOut_In: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut_Out: out std_logic_vector(RegWidth-1 downto 0);
		DestReg_In: in std_logic_vector(AddrBits-1 downto 0);
		DestReg_Out: out std_logic_vector(AddrBits-1 downto 0));
end entity MEM_WB_Register;

architecture MEM_WB_Register_Behavior of MEM_WB_Register is
	signal Control: std_logic_vector(ControlBits-1 downto 0);
	signal MemOut: std_logic_vector(RegWidth-1 downto 0);
	signal ALUOut: std_logic_vector(RegWidth-1 downto 0);
	signal DestReg: std_logic_vector(AddrBits-1 downto 0);
	begin
		Control_Out <= Control;
		MemOut_Out <= MemOut;
		ALUOut_Out <= ALUOut;
		DestReg_Out <= DestReg;
		process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '1' then
					Control <= (others => '0');
					MemOut <= (others => '0');
					ALUOut <= (others => '0');
					DestReg <= (others => '0');
				else
					Control <= Control_In;
					MemOut <= MemOut_In;
					ALUOut <= ALUOut_In;
					DestReg <= DestReg_In;
				end if;
			end if;
		end process;
end architecture MEM_WB_Register_Behavior;
