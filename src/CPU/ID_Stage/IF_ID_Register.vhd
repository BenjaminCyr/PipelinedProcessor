----------------------------------------------
-- File: 		IF_ID_Register.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 17, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID_Register is
	generic (InstrWidth : integer := 16);
	port (
    	CLK: in std_logic;
		RST: in std_logic;
		Stall: in std_logic;
		Flush: in std_logic;
		Instruction_In: in std_logic_vector(InstrWidth-1 downto 0);
		Instruction_Out: out std_logic_vector(InstrWidth-1 downto 0);
		PC_In: in std_logic_vector(InstrWidth-1 downto 0);
		PC_Out: out std_logic_vector(InstrWidth-1 downto 0);
		BranchTaken_In: in std_logic;
		BranchTaken_Out: out std_logic);
end entity IF_ID_Register;

architecture IF_ID_Register_Behavior of IF_ID_Register is
	signal Instruction: std_logic_vector(InstrWidth-1 downto 0);
	signal PC: std_logic_vector(InstrWidth-1 downto 0);
	signal BranchTaken: std_logic;
	begin
		Instruction_Out <= Instruction;
		PC_Out <= PC;
		BranchTaken_Out <= BranchTaken;
		process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '1' or Flush = '1' then
					Instruction <= (others => '0');
					PC <= (others => '0');
					BranchTaken <= '0';
				elsif Stall = '1' then
					Instruction <= Instruction;
					PC <= PC;
					BranchTaken <= BranchTaken;
				else 
					Instruction <= Instruction_In;
					PC <= PC_In;
					BranchTaken <= BranchTaken_In;
				end if;
			end if;
		end process;
end architecture IF_ID_Register_Behavior;
