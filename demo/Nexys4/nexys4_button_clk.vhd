----------------------------------------------
-- File: 		Nexys4_Button_CLK.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 11, 2017	
---------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nexys4_Button_CLK is
	generic ( N : integer := 8
			 TestFile : string := "../../instructions.txt");
	Port (
			CLK : in std_logic;
			RST : in std_logic;
			button_in : in std_logic;
			inr : in std_logic; 
			out_value : out std_logic_vector(15 downto 0));
end Nexys4_Button_CLK;

architecture Nexys4_Button_CLK_Behavior of Nexys4_Button_CLK is
	signal button_out : std_logic;
	begin

		p1 : entity work.Pipelined_Processor
				generic map (Filename <= TestFile)
				port map (button_out, RST, inr, out_value);

		d1 : entity work.Debounce
				generic map (N <= N)
				port map (button_in, CLK, button_out);
	
end Nexys4_Button_CLK_Behavior;
