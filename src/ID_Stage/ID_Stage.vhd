----------------------------------------------
-- File: 		ID_Stage.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 3, 2017	
---------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity ID_Stage is
	generic (RegWidth : integer := 16;
			 OpcodeBits : integer := 4;
			 ControlBits_Out : integer := 13;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		RST: in std_logic;

		inr: in std_logic_vector(AddrBits-1 downto 0);
		out_value: out std_logic_vector(RegWidth-1 downto 0);

		Stall_Out: out std_logic;
		Flush: in std_logic;
		Control_Out: out std_logic_vector(ControlBits_Out-1 downto 0);
		BranchTaken_In: in std_logic;
		BranchTaken_Out: out std_logic;

		Instruction_In: in std_logic_vector(RegWidth-1 downto 0);
		PC_In: in std_logic_vector(RegWidth-1 downto 0);
		PC_Out: out std_logic_vector(RegWidth-1 downto 0);
		ReadData1_Out: out std_logic_vector(RegWidth-1 downto 0);
		ReadData2_Out: out std_logic_vector(RegWidth-1 downto 0);
		Imm_Out: out std_logic_vector(RegWidth-1 downto 0);

		Rs_Out: out std_logic_vector(AddrBits-1 downto 0);
		Rt_Out: out std_logic_vector(AddrBits-1 downto 0);
		Rd_Out: out std_logic_vector(AddrBits-1 downto 0);

		EX_Rt : in std_logic_vector(AddrBits-1 downto 0);
		EX_MemRead : in std_logic;

		WB_WriteData: in std_logic_vector(RegWidth-1 downto 0);
		WB_DestReg: in std_logic_vector(AddrBits-1 downto 0);
		WB_RegWrite: in std_logic);
end entity ID_Stage;

architecture ID_Stage_Behavior of ID_Stage is 
	signal Stall : std_logic;
	signal Instruction : std_logic_vector (RegWidth-1 downto 0);

	signal Opcode : std_logic_vector (OpcodeBits-1 downto 0);
	signal Immediate : std_logic_vector (RegWidth-OpcodeBits-2*AddrBits-1 downto 0);
	signal Rs : std_logic_vector(AddrBits-1 downto 0);
	signal Rt : std_logic_vector(AddrBits-1 downto 0);
	signal Rd : std_logic_vector(AddrBits-1 downto 0);

    begin
        Opcode <= Instruction(RegWidth-1 downto RegWidth-OpcodeBits);
        Immediate <= Instruction(RegWidth-OpcodeBits-2*AddrBits-1 downto 0);
    
        Rs <= Instruction(RegWidth-OpcodeBits-1 downto 
                            RegWidth-OpcodeBits-AddrBits);
        Rt <= Instruction(RegWidth-OpcodeBits-AddrBits-1 downto 
                            RegWidth-OpcodeBits-2*AddrBits);
        Rd <= Instruction(RegWidth-OpcodeBits-2*AddrBits-1 downto 
                            RegWidth-OpcodeBits-3*AddrBits);
    
        IF_ID_Reg : entity work.IF_ID_Register 
                    generic map (RegWidth) 
                    port map (CLK, RST, Stall, Flush, Instruction_In, 
                        Instruction, PC_In, PC_Out, BranchTaken_In, 
                        BranchTaken_Out);
        
        Control_Logic : entity work.Control_Logic
                generic map (OpcodeBits, ControlBits_Out)
                port map (Opcode, Control_Out);
    
        Hazard_Detection : entity work.Hazard_Detection
                            generic map (AddrBits)
                            port map (Rs, Rt, EX_Rt, EX_MemRead, Stall);
        
        Reg_File : entity work.Register_File 
                    generic map (RegWidth, AddrBits)
                    port map (not CLK, RST, WB_RegWrite, Rs, Rt, ReadData1_Out,
                        ReadData2_Out, WB_DestReg, WB_WriteData, 
                        inr, out_value);
    
        Sign_Extender : entity work.Sign_Extender
                        generic map (RegWidth-OpcodeBits-2*AddrBits, RegWidth)
                        port map (Immediate, Imm_Out);
    
        Stall_Out <= Stall;
        Rs_Out <= Rs;
        Rt_Out <= Rt;
        Rd_Out <= Rd;
end architecture ID_Stage_Behavior;
