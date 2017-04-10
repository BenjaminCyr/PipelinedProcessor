----------------------------------------------
-- File: 		Pipelined_Processor.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 4, 2017	
---------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Pipelined_Processor is
	generic (DataWidth : integer := 16;
			RegAddrBits : integer := 3;
			PredictorAddrBits : integer := 4;
			OpcodeBits : integer := 4;
			ALU_ControlBits : integer := 3;
			ControlBits_EX : integer := 13;
			ControlBits_MEM : integer := 4;
			ControlBits_WB : integer := 2);
	port (
    	CLK: in std_logic;
		RST: in std_logic;

		inr: in std_logic_vector(RegAddrBits-1 downto 0);
		out_value: out std_logic_vector(DataWidth-1 downto 0);

		-- Instruction Memory Connections
		PC: out std_logic_vector(DataWidth-1 downto 0);
		Instruction: in std_logic_vector(DataWidth-1 downto 0);
	
		-- Data Memory Connections
		MemRead : out std_logic;
		MemWrite : out std_logic;
		MemAddr : out std_logic_vector(DataWidth-1 downto 0);
		MemData : out std_logic_vector(DataWidth-1 downto 0);
		MemOutput : in std_logic_vector(DataWidth-1 downto 0));
end entity Pipelined_Processor;

architecture Pipelined_Processor_Behavior of Pipelined_Processor is 
	signal IF_ID_BranchTaken: std_logic;
	signal IF_ID_PC_Out : std_logic_vector(DataWidth-1 downto 0);
	signal IF_ID_Instruction_Out : std_logic_vector(DataWidth-1 downto 0);

	signal ID_IF_EX_Stall : std_logic;
	signal ID_EX_BranchTaken : std_logic;
	signal ID_EX_Control_Out : std_logic_vector(ControlBits_EX-1 downto 0);
	signal ID_EX_PC_Out : std_logic_vector(DataWidth-1 downto 0);
	signal ID_EX_ReadData1_Out : std_logic_vector(DataWidth-1 downto 0);
	signal ID_EX_ReadData2_Out : std_logic_vector(DataWidth-1 downto 0);
	signal ID_EX_Imm_Out : std_logic_vector(DataWidth-1 downto 0);
	signal ID_EX_Rs_Out : std_logic_vector(RegAddrBits-1 downto 0);
	signal ID_EX_Rt_Out : std_logic_vector(RegAddrBits-1 downto 0);
	signal ID_EX_Rd_Out : std_logic_vector(RegAddrBits-1 downto 0);

	signal EX_IF_ID_PCOverwrite_Flush : std_logic;
	signal EX_IF_ShouldBranch : std_logic;
	signal EX_IF_BranchSourceAddr : std_logic_vector(DataWidth-1 downto 0);
	signal EX_IF_BranchTargetAddr : std_logic_vector(DataWidth-1 downto 0);
	signal EX_IF_PredictionMiss : std_logic;
	signal EX_MEM_Control_Out : std_logic_vector(ControlBits_MEM-1 downto 0);
	signal EX_MEM_ALU_Out : std_logic_vector(DataWidth-1 downto 0);
	signal EX_MEM_MemData : std_logic_vector(DataWidth-1 downto 0);
	signal EX_MEM_DestReg : std_logic_vector(RegAddrBits-1 downto 0);
	signal EX_ID_Rt : std_logic_vector(RegAddrBits-1 downto 0);
	signal EX_ID_MemRead : std_logic;

	signal MEM_WB_ControlOut : std_logic_vector(ControlBits_WB-1 downto 0);
	signal MEM_EX_WB_ALUOut : std_logic_vector(DataWidth-1 downto 0);
	signal MEM_EX_WB_DestReg : std_logic_vector(RegAddrBits-1 downto 0);
	signal MEM_EX_WB_RegWrite : std_logic;
	
	signal WB_ID_EX_WriteData : std_logic_vector(DataWidth-1 downto 0);
	signal WB_ID_EX_DestReg : std_logic_vector(RegAddrBits-1 downto 0);
	signal WB_ID_EX_RegWrite : std_logic;

    begin
    
        IF_Stage : entity work.IF_Stage
                generic map (DataWidth, PredictorAddrBits) 
                port map (CLK, RST, ID_IF_EX_Stall, 
                    EX_IF_ID_PCOverwrite_Flush,
                    EX_IF_PredictionMiss, EX_IF_ShouldBranch,
                    EX_IF_BranchSourceAddr, EX_IF_BranchTargetAddr,
					CurrentPC, Instruction, IF_ID_BranchTaken, 
					IF_ID_PC_Out, IF_ID_Instruction_Out);
    
        ID_Stage : entity work.ID_Stage	
                generic map (DataWidth, OpcodeBits, ControlBits_EX, 
                    RegAddrBits)
                port map(CLK, RST, inr, out_value, ID_IF_EX_Stall, 
                    EX_IF_ID_PCOverwrite_Flush, ID_EX_Control_Out, 
                    IF_ID_BranchTaken, ID_EX_BranchTaken, 
                    IF_ID_Instruction_Out, IF_ID_PC_Out, ID_EX_PC_Out,
                    ID_EX_ReadData1_Out, ID_EX_ReadData2_Out, ID_EX_Imm_Out,
                    ID_EX_Rs_Out, ID_EX_Rt_Out, ID_EX_Rd_Out, EX_ID_Rt,
                    EX_ID_MemRead, WB_ID_EX_WriteData, WB_ID_EX_DestReg, 
                    WB_ID_EX_RegWrite);
        
        EX_Stage : entity work.EX_Stage
                generic map (DataWidth, ControlBits_EX, ControlBits_MEM,
                    ALU_ControlBits, RegAddrBits)
                port map (CLK, RST, ID_IF_EX_Stall, ID_EX_Control_Out, 
                    EX_MEM_Control_Out, ID_EX_BranchTaken, 
                    EX_IF_ID_PCOverwrite_Flush, EX_IF_ShouldBranch, 
                    EX_IF_BranchSourceAddr, EX_IF_BranchTargetAddr, 
                    EX_IF_PredictionMiss, ID_EX_PC_Out, ID_EX_ReadData1_Out,
                    ID_EX_ReadData2_Out, ID_EX_Imm_Out, EX_MEM_ALU_Out,
                    EX_MEM_MemData, ID_EX_Rs_Out, ID_EX_Rt_Out, ID_EX_Rd_Out,
                    EX_MEM_DestReg, EX_ID_Rt, EX_ID_MemRead, 
                    MEM_EX_WB_ALUOut, MEM_EX_WB_DestReg, MEM_EX_WB_RegWrite, 
                    WB_ID_EX_WriteData, WB_ID_EX_DestReg, WB_ID_EX_RegWrite);
        
        MEM_Stage : entity work.MEM_Stage
                generic map (DataWidth, ControlBits_MEM, ControlBits_WB, 
                    RegAddrBits)
                port map (CLK, RST, EX_MEM_Control_Out, MEM_WB_ControlOut,
                    EX_MEM_ALU_Out, MEM_EX_WB_ALUOut, EX_MEM_MemData, MemData,
                    EX_MEM_DestReg, MEM_EX_WB_DestReg, MemRead, MemWrite,
                    MEM_EX_WB_RegWrite);
        
        WB_Stage : entity work.WB_Stage
                generic map (DataWidth, ControlBits_WB, RegAddrBits)
                port map (CLK, RST, MEM_WB_ControlOut, MemOutput, 
                    MEM_EX_WB_ALUOut, MEM_EX_WB_DestReg, WB_ID_EX_WriteData, 
                    WB_ID_EX_DestReg, WB_ID_EX_RegWrite);
        
        MemAddr <= MEM_EX_WB_ALUOut;

end architecture Pipelined_Processor_Behavior;
