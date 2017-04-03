----------------------------------------------
-- File: 		EX_Stage.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 3, 2017	
---------------------------------------------

entity EX_Stage is
	generic (RegWidth : integer := 16;
			 ControlBits_In : integer := 13;
			 ControlBits_Out : integer := 4;
			 ALU_ControlBits : integer := 3;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		RST: in std_logic;
		Stall: in std_logic;
		Control_In: in std_logic_vector(ControlBits_In-1 downto 0);
		Control_Out: out std_logic_vector(ControlBits_Out-1 downto 0);
		BranchTaken_In: in std_logic;

		Flush: out std_logic;
		ShouldBranch: out std_logic;
		BranchSourceAddr: out std_logic_vector(RegWidth-1 downto 0);
		BranchTargetAddr: out std_logic_vector(RegWidth-1 downto 0);
		PredictionMiss: out std_logic;

		PC_In: in std_logic_vector(RegWidth-1 downto 0);
		ReadData1_In: in std_logic_vector(RegWidth-1 downto 0);
		ReadData2_In: in std_logic_vector(RegWidth-1 downto 0);
		Imm_In: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut out std_logic_vector(RegWidth-1 downto 0);
		MemData out std_logic_vector(RegWidth-1 downto 0);

		Rs_In: in std_logic_vector(AddrBits-1 downto 0);
		Rt_In: in std_logic_vector(AddrBits-1 downto 0);
		Rd_In: in std_logic_vector(AddrBits-1 downto 0);
		DestReg_Out: out std_logic_vector(AddrBits-1 downto 0);

		Rt_Out: out std_logic_vector(AddrBits-1 downto 0);
		MemRead: out std_logic;

		MEM_ALUOut: in std_logic_vector(RegWidth-1 downto 0);
		MEM_DestReg: in std_logic_vector(AddrBits-1 downto 0);
		MEM_RegWrite: in std_logic;

		WB_WriteData: in std_logic_vector(RegWidth-1 downto 0);
		WB_DestReg: in std_logic_vector(AddrBits-1 downto 0);
		WB_RegWrite: in std_logic;
		);
end entity EX_Stage;

architecture EX_Stage_Behavior of EX_Stage is 
	signal Control : std_logic_vector (ControlBits_In-1 downto 0);
	signal BranchTaken : std_logic;
	signal PC : std_logic_vector (RegWidth-1 downto 0);
	signal ReadData1 : std_logic_vector (RegWidth-1 downto 0);
	signal ReadData2 : std_logic_vector (RegWidth-1 downto 0);
	signal Imm : std_logic_vector (RegWidth-1 downto 0);
	signal Rs : std_logic_vector (AddrBits-1 downto 0);
	signal Rt : std_logic_vector (AddrBits-1 downto 0);
	signal Rd : std_logic_vector (AddrBits-1 downto 0);
	signal DestReg: std_logic_vector(AddrBits-1 downto 0);

	signal ALUOp : std_logic_vector(ALU_ControlBits-1 downto 0);
	signal ALUSrc : std_logic;
	signal RegDst : std_logic;
	signal Branch : std_logic;
	signal BEQ_BNE : std_logic;
	signal JumpReg : std_logic;
	signal Link : std_logic;

	signal Operand1 : std_logic_vector (RegWidth-1 downto 0);
	signal Operand2 : std_logic_vector (RegWidth-1 downto 0);

	signal Link_Mux_In : std_logic_vector (RegWidth-1 downto 0);
	signal Zero : std_logic_vector (RegWidth-1 downto 0);

	signal ForwardA : std_logic_vector (1 downto 0);
	signal ForwardB : std_logic_vector (1 downto 0);

	ALUOp <= Control(12 downto 10);
	ALUSrc <= Control(9);
	RegDst <= Control(8);
	Branch <= Control(7);
	BEQ_BNE <= Control(6);
	JumpReg <= Control(5);
	Link <= Control(4);
	MemRead <= Control(2);
	Control_Out <= Control(3 downto 0);

	EX_MEM_Reg : entity EX_MEM_Register 
				generic map (RegWidth, ControlBits_In, AddrBits) 
				port map ( CLK, RST, Stall, Flush, Control_In, Control, 
					BranchTaken_In, BranchTaken, PC_In, PC, 
					ReadData1_In, ReadData1, ReadData2_In, ReadData2, 
					Imm_In, Imm, Rs_In, Rs, Rt_In, Rt, Rd_In, Rd);
	
	ALU_Muxes : entity ALU_Muxes
				generic map (AddrBits, RegWidth)
				port map (RegDst, Rt, Rd, DestReg, 
					ALUSrc, ForwardA, ForwardB, MEM_ALUOut,
					WB_WriteData, ReadData1, ReadData2, Imm, 
					Operand1, Operand2, MemData);

	Forwarding_Unit : entity Forwarding_Unit
						generic map (AddrBits)
						port map (Rs, Rt, MEM_RegWrite, MEM_DestReg,
							WB_RegWrite, WB_DestReg, ForwardA, ForwardB);

	ALU : entity ALU
			generic map (ALU_ControlBits, RegWidth)
			port map (ALUOp, Operand1, Operand2,
				Link_Mux_In, Zero);
	
	Link_Muxes : entity Link_Muxes
					generic map (AddrBits, RegWidth)
					port map (Link, DestReg, DestReg_Out, Link_Mux_In, 
						ALUOut, PC);

	Branch_Unit : entity Branch_Unit
					generic map (RegWidth)
					port map (BranchTaken, Branch, BEQ_BNE, Zero, PC, 
						JumpReg, Imm, Operand1, ShouldBranch, 
						PredictionMiss, BranchTargetAddr, Flush);
	
	BranchSourceAddr <= PC;
	Rt_Out <= Rt;
end architecture EX_Stage_Behavior;
