library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sign_Extender is
	generic (InSize : integer := 6;
			 OutSize : integer := 16);
	port (
		Input: in std_logic_vector(InSize-1 downto 0);
		Output: out std_logic_vector(OutSize-1 downto 0));
end entity Sign_Extender;

architecture Sign_Extender_Behavior of Sign_Extender is
	begin
		Output <= std_logic_vector(resize(SIGNED(Input), Output'length));
end architecture Sign_Extender_Behavior;
