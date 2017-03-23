----------------------------------------------
-- File: 		Register_File.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 17, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Register_File is
	generic (RegWidth : integer := 16;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		RST: in std_logic;
		WriteEN: in std_logic;
		ReadAddr1: in std_logic_vector(AddrBits-1 downto 0);
		ReadAddr2: in std_logic_vector(AddrBits-1 downto 0);
		ReadData1: out std_logic_vector(RegWidth-1 downto 0);
		ReadData2: out std_logic_vector(RegWidth-1 downto 0);
		WriteAddr: in std_logic_vector(AddrBits-1 downto 0);
		WriteData: in std_logic_vector(RegWidth-1 downto 0);
		inr: in std_logic_vector(AddrBits-1 downto 0);
		out_value: out std_logic_vector(RegWidth-1 downto 0));
end entity Register_File;

architecture Register_File_Behavior of Register_File is
	constant zero_reg : std_logic_vector(AddrBits-1 downto 0) := (others <= '0');
	subtype WORD is std_logic_vector(RegWidth-1 downto 0);
	type MEMORY is array(1 to 2**AddrBits - 1) of WORD;
	signal registers: MEMORY := (others=> (others => '0'));
	begin
		ReadData1 <= (others <= '0') when ReadAddr1 = zero_reg else 
						registers(to_integer(UNSIGNED(ReadAddr1)));
        ReadData2 <= (others <= '0') when ReadAddr2 = zero_reg else 
						registers(to_integer(UNSIGNED(ReadAddr2)));
        out_value <= (others <= '0') when inr = zero_reg else 
						registers(to_integer(UNSIGNED(inr)));
		process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '1' then
					registers <= (others => (others => '0'));
				elsif WriteEN = '1' and not WriteAddr = zero_reg then
					registers(to_integer(UNSIGNED(WriteAddr))) <= WriteData;
				end if;
			end if;
		end process;
end architecture Register_File_Behavior;
