----------------------------------------------
-- File: 		EX_MEM_Register.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 19, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity EX_MEM_Register is
	generic (RegWidth : integer := 16;
			 ControlBits : integer := 4;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		Control_In: in std_logic_vector(ControlBits-1 downto 0);
		Control_Out: out std_logic_vector(ControlBits-1 downto 0);
		ALUOut_In: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut_Out: out std_logic_vector(RegWidth-1 downto 0);
		MemData_In: in std_logic_vector(RegWidth-1 downto 0);
		MemData_Out: out std_logic_vector(RegWidth-1 downto 0);
		DestReg_In: in std_logic_vector(AddrBits-1 downto 0);
		DestReg_Out: out std_logic_vector(AddrBits-1 downto 0));
end entity EX_MEM_Register;

architecture EX_MEM_Register_Behavior of EX_MEM_Register is
	signal Control: std_logic_vector(ControlBits-1 downto 0);
	signal ALUOut: std_logic_vector(RegWidth-1 downto 0);
	signal MemData: std_logic_vector(RegWidth-1 downto 0);
	signal DestReg: std_logic_vector(AddrBits-1 downto 0);
	begin
		Control_Out <= Control;
		ALUOut_Out <= ALUOut;
		MemData_Out <= MemData;
		DestReg_Out <= DestReg;
		process(CLK)
		begin
			if rising_edge(CLK) then
				Control <= Control_In;
				ALUOut <= ALUOut_In;
				MemData <= MemData_In;
				DestReg <= DestReg_In;
			end if;
		end process;
end architecture EX_MEM_Register_Behavior;
