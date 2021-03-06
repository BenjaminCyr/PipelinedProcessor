----------------------------------------------
-- File: 		Branch_Unit.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 18, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Branch_Unit is
	generic (RegWidth : integer := 16);
	port (
		BranchTaken: in std_logic;
		Branch: in std_logic;
		BEQ_BNE: in std_logic;
		Zero: in std_logic;
		PC: in std_logic_vector(RegWidth-1 downto 0);
		JumpReg: in std_logic;
		Imm: in std_logic_vector(RegWidth-1 downto 0);
		RegData: in std_logic_vector(RegWidth-1 downto 0);
		ShouldBranch: out std_logic;
		PredictionMiss: out std_logic;
		BranchTargetAddr: out std_logic_vector(RegWidth-1 downto 0);
		Flush: out std_logic);
end entity Branch_Unit;

architecture Branch_Unit_Behavior of Branch_Unit is
    signal ShouldBranch_Sig : std_logic;
	signal PredictionMiss_Sig : std_logic;
	begin
		ShouldBranch_Sig <= '1' when Branch = '1' and 
						((BEQ_BNE = '0' and Zero = '1') or 
						(BEQ_BNE = '1' and Zero = '0')) else
						'0';
		PredictionMiss_Sig <= ShouldBranch_Sig xor BranchTaken;
		BranchTargetAddr <= RegData when JumpReg = '1' else
							std_logic_vector(unsigned(PC)+unsigned(Imm)) 
							when ShouldBranch_Sig = '1' else 
							PC;
		Flush <= PredictionMiss_Sig or JumpReg;
		ShouldBranch <= ShouldBranch_Sig;
		PredictionMiss <= PredictionMiss_Sig;
end architecture Branch_Unit_Behavior;
