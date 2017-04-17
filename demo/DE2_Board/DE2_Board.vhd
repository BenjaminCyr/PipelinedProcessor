----------------------------------------------
-- File: 		Nexys4_Button_CLK.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 11, 2017	
---------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DE2_Board is
	Port (
			CLK : in std_logic;
			RST : in std_logic;
			inr : in std_logic_vector(2 downto 0); 
			out_value : out std_logic_vector(15 downto 0));
end DE2_Board;

architecture DE2_Board_Behavior of DE2_Board is
	signal InstrMemAddr : std_logic_vector(15 downto 0);
	signal InstrMemData : std_logic_vector(15 downto 0);
	
	signal DataMemRead : std_logic;
	signal DataMemWrite : std_logic;
	signal DataMemAddr : std_logic_vector(15 downto 0);
	signal DataMemWriteData : std_logic_vector(15 downto 0);
	signal DataMemReadData : std_logic_vector(15 downto 0);
	
	signal not_CLK : std_logic;
	begin
	
		not_CLK <= not CLK;

		p1 : entity work.CPU
					port map(
						CLK => CLK,
						RST => RST,

						inr => inr,
						out_value => out_value,

						-- Instruction Memory Connections
						PC => InstrMemAddr,
						Instruction => InstrMemData,
					
						-- Data Memory Connections
						MemRead => DataMemRead,
						MemWrite => DataMemWrite,
						MemAddr => DataMemAddr,
						MemData => DataMemWriteData,
						MemOutput => DataMemReadData);
						
		i1 : entity work.MF_Instruction_Memory
					port map(
						address => InstrMemAddr(12 downto 0),
						clock => not_CLK,
						data => (others => '0'),
						wren => '0',
						q => InstrMemData);
						
		d1 : entity work.MF_Data_Memory
					port map(
						address => DataMemAddr(10 downto 0),
						clock => not_CLK,
						data => DataMemWriteData,
						wren => DataMemWrite,
						q => DataMemReadData);
	
end DE2_Board_Behavior;
