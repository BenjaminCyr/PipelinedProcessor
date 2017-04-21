----------------------------------------------
-- File: 		Pipelined_Processor.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 4, 2017	
---------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Pipelined_Processor is
	generic (FileName : string := "../instructions.txt";
	        DataFileName : string := "";
			DataWidth : integer := 16;
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
		out_value: out std_logic_vector(DataWidth-1 downto 0));
end entity Pipelined_Processor;

architecture Pipelined_Processor_Behavior of Pipelined_Processor is 
	signal DataMemRead : std_logic;
	signal DataMemWrite : std_logic;
	signal DataMemAddr : std_logic_vector(DataWidth-1 downto 0);
	signal DataMemWriteData : std_logic_vector(DataWidth-1 downto 0);
	signal DataMemReadData : std_logic_vector(DataWidth-1 downto 0);
	signal InstrMemAddr: std_logic_vector(DataWidth-1 downto 0);
	signal InstrMemData: std_logic_vector(DataWidth-1 downto 0);

	signal notCLK : std_logic;

    begin
		notCLK <= not CLK;
    
        CPU : entity work.CPU
                generic map (DataWidth, RegAddrBits, PredictorAddrBits,
					OpcodeBits, ALU_ControlBits, ControlBits_EX, 
					ControlBits_MEM, ControlBits_WB)
                port map (CLK, RST, inr, out_value, InstrMemAddr, 
					InstrMemData, DataMemRead, DataMemWrite, DataMemAddr,
					DataMemWriteData, DataMemReadData);

		InstrMem : entity work.Instruction_Memory
				generic map (FileName, DataWidth, DataWidth)
				port map (notCLK, InstrMemAddr, InstrMemData);

		DataMem : entity work.Data_Memory
				generic map (DataFileName, DataWidth, DataWidth)
				port map (notCLK, DataMemRead, DataMemWrite, DataMemAddr,
					DataMemWriteData, DataMemReadData);
end architecture Pipelined_Processor_Behavior;
