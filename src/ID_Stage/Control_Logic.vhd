library IEEE;
use IEEE.std_logic_1164.all;

entity Control_Logic is
	port (
		Opcode: in std_logic_vector(3 downto 0);
		Control_Signals: out std_logic_vector(12 downto 0));
end entity Control_Logic;

architecture Control_Logic_Behavior of Control_Logic is
	begin
		with Opcode select
			Control_Signals <= "0000000000000" when "0000",
							"0010100000010" when "0001",
							"0100100000010" when "0010",
							"0110100000010" when "0011",
							"1000100000010" when "0100",
							"1010100000010" when "0101",
							"1101000000010" when "0110",
							"1111000000010" when "0111",
							"0011000000010" when "1000",
							"0011000001000" when "1001",
							"0011000000111" when "1010",
							"0100011000000" when "1011",
							"0100010000000" when "1100",
							"0000000010010" when "1101",
							"0000000000000" when "1110",
							"0000000100000" when "1111",
							"XXXXXXXXXXXXX" when others;
end architecture Control_Logic_Behavior;

