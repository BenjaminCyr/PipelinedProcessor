library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Register_File is
	generic (RegWidth : integer := 16;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		WriteEN: in std_logic;
		ReadAddr1: in std_logic_vector(AddrBits-1 downto 0);
		ReadAddr2: in std_logic_vector(AddrBits-1 downto 0);
		ReadData1: out std_logic_vector(RegWidth-1 downto 0);
		ReadData2: out std_logic_vector(RegWidth-1 downto 0);
		WriteAddr: in std_logic_vector(AddrBits-1 downto 0);
		WriteData: in std_logic_vector(RegWidth-1 downto 0));
end entity Register_File;

architecture Register_File_Behavior of Register_File is
	subtype WORD is std_logic_vector(RegWidth-1 downto 0);
	type MEMORY is array(0 to 2**AddrBits - 1) of WORD;
	signal registers: MEMORY := (others=> (others => '0'));
	begin
		ReadData1 <= registers(to_integer(UNSIGNED(ReadAddr1)));
        ReadData2 <= registers(to_integer(UNSIGNED(ReadAddr2)));
		process(CLK)
		begin
			if rising_edge(CLK) and WriteEN = '1' then
				registers(to_integer(UNSIGNED(WriteAddr))) <= WriteData;
			end if;
		end process;
end architecture Register_File_Behavior;
