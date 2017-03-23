----------------------------------------------
-- File: 		PC_Muxes.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 20, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC_Muxes is
	generic (DataWidth : integer := 16);
	port (
		TakeBranch: in std_logic;
		TakeJump: in std_logic;
		PCOverwrite: in std_logic;
		Halt: in std_logic; --From Jump Logic HALT instruction
		Stall: in std_logic; --From ID Hazard Detection
		PC: in std_logic_vector(DataWidth-1 downto 0);
		BranchTarget: in std_logic_vector(DataWidth-1 downto 0);
		OverwriteAddress: in std_logic_vector(DataWidth-1 downto 0);
		JumpTarget: in std_logic_vector(DataWidth-1 downto 0);
		PCPlusOne: out std_logic_vector(DataWidth-1 downto 0);
		NextPC: out std_logic_vector(DataWidth-1 downto 0));
end entity PC_Muxes;

architecture PC_Muxes_Behavior of PC_Muxes is
    signal PCPlusOne_Sig : std_logic_vector(DataWidth-1 downto 0);
	begin
		PCPlusOne_Sig <= std_logic_vector(unsigned(PC)+1);
		PCPlusOne <= PCPlusOne_Sig;
		NextPC <= OverwriteAddress when PCOverwrite = '1' else
					PC when Halt = '1' or Stall = '1' else
					JumpTarget when TakeJump = '1' else
					BranchTarget when TakeBranch = '1' else
					PCPlusOne_Sig;
end architecture PC_Muxes_Behavior;
