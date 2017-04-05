----------------------------------------------
-- File: 		IF_Stage.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 4, 2017	
---------------------------------------------

entity IF_Stage is
	generic (RegWidth : integer := 16;
			PredictorAddrBits : integer := 4);
	port (
    	CLK: in std_logic;
		RST: in std_logic;
		Stall: in std_logic;
	
		PCOverwrite: in std_logic;
		PredictionMiss: in std_logic;
		ShouldBranch: in std_logic;
		BranchSourceAddr: in std_logic_vector(RegWidth-1 downto 0);
		BranchTargetAddr: in std_logic_vector(RegWidth-1 downto 0);

		BranchTaken: out std_logic;
		PC_Out: out std_logic_vector(RegWidth-1 downto 0);
		Instruction_Out: out std_logic_vector(RegWidth-1 downto 0));
end entity IF_Stage;

architecture IF_Stage_Behavior of IF_Stage is 
	signal NextPC : std_logic_vector (RegWidth-1 downto 0);
	signal CurrentPC : std_logic_vector (RegWidth-1 downto 0);
	signal PCPlusOne : std_logic_vector (RegWidth-1 downto 0);

	signal TakeBranch : std_logic;
	signal PredictedBranchAddr : std_logic_vector(RegWidth-1 downto 0);

	signal TakeJump : std_logic;
	signal JumpTarget : std_logic_vector(RegWidth-1 downto 0);

	signal Halt : std_logic;

	signal Instruction : std_logic_vector(RegWidth-1 downto 0);

	PC_Reg : entity PC_Register 
				generic map (RegWidth) 
				port map (CLK, RST, NextPC, CurrentPC);

	Instr_Mem : entity Instruction_Memory
				generic map (RegWidth, RegWidth)
				port map (CurrentPC, Instruction);

	Jump_Logic : entity Jump_Logic
					generic map (RegWidth)
					port map (Instruction, CurrentPC, JumpTarget, 
						TakeJump, Halt);

	Branch_Pred : entity Branch_Predictor
					generic map (RegWidth, PredictorAddrBits)
					port map (CLK, RST, PredictionMiss, Instruction,
						PCPlusOne, ShouldBranch, BranchTargetAddr, 
						BranchSourceAddr, PredictedBranchAddr, 
						TakeBranch);
	
	PC_Muxes : entity PC_Muxes
				generic map (RegWidth)
				port map (TakeBranch, TakeJump, PCOverwrite, Halt, Stall,
					PC_Out, PredictedBranchAddr, BranchTargetAddr,
					JumpTarget, PCPlusOne, NextPC);

	PC_Out <= PCPlusOne;
	BranchTaken <= TakeBranch;
	Instruction_Out <= Instruction;
end architecture IF_Stage_Behavior;
