----------------------------------------------
-- File: 		ALU_Muxes.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 18, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_Muxes is
	generic (AddrBits: integer := 3;
			RegWidth : integer := 16);
	port (
		RegDst: in std_logic;
		Rt: in std_logic_vector(AddrBits-1 downto 0);
		Rd: in std_logic_vector(AddrBits-1 downto 0);
		DestReg: out std_logic_vector(AddrBits-1 downto 0);
		ALUSrc: in std_logic;
		ForwardA: in std_logic_vector(1 downto 0);
		ForwardB: in std_logic_vector(1 downto 0);
		Mem_ALUOut: in std_logic_vector(RegWidth-1 downto 0);
		WB_WriteData: in std_logic_vector(RegWidth-1 downto 0);
		ReadData1: in std_logic_vector(RegWidth-1 downto 0);
		ReadData2: in std_logic_vector(RegWidth-1 downto 0);
		Imm: in std_logic_vector(RegWidth-1 downto 0);
		Operand1: out std_logic_vector(RegWidth-1 downto 0);
		Operand2: out std_logic_vector(RegWidth-1 downto 0);
		MemData: out std_logic_vector(RegWidth-1 downto 0));
end entity ALU_Muxes;

architecture ALU_Muxes_Behavior of ALU_Muxes is
	signal Fw_Operand : std_logic_vector(RegWidth-1 downto 0);
	begin
		DestReg <= Rd when RegDst = '1' else Rt;
		Operand1 <= WB_WriteData when ForwardA = "10" else
					Mem_ALUOut when ForwardA = "01" else
					ReadData1;
		Fw_Operand <= WB_WriteData when ForwardB = "10" else
					Mem_ALUOut when ForwardB = "01" else
					ReadData2;
		Operand2 <= Imm when ALUSrc = '1' else 
					Fw_Operand;
		MemData <= Fw_Operand;
end architecture ALU_Muxes_Behavior;
