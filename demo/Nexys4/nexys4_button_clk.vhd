----------------------------------------------
-- File: 		Nexys4_Button_CLK.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 11, 2017	
---------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nexys4_Button_CLK is
	generic ( N : integer := 8;
			 TestFile : string := "../../testbenches/Test_Programs/test_sort_short.txt";
             DataFile : string := "../../testbenches/Test_Programs/test_sort_short_data.txt");
	Port (
			CLK : in std_logic;
			RST : in std_logic;
			button_in : in std_logic;
			CLK_switch : in std_logic;
			inr : in std_logic_vector(2 downto 0); 
			out_value : out std_logic_vector(15 downto 0));
end Nexys4_Button_CLK;

architecture Nexys4_Button_CLK_Behavior of Nexys4_Button_CLK is
	signal button_out : std_logic;
	signal count_out : std_logic_vector(N-1 downto 0);
	signal CLK_select : std_logic;
	begin
	
	    CLK_select <= count_out(N-1) when CLK_switch = '1' else button_out;

		p1 : entity work.Pipelined_Processor
				generic map (Filename => TestFile, DataFileName => DataFile)
				port map (CLK_select, RST, inr, out_value);

		d1 : entity work.Debounce
				generic map (N => N)
				port map (button_in, CLK, button_out);
				
		COUNT1: entity work.universal_reg generic map (N => N)
                port map (CLK => CLK,
                           Din => (others => '0'),
                           RST => RST,
                            CE => CLK_switch,
                            M => "10",
                          Dout => count_out);
	
end Nexys4_Button_CLK_Behavior;
