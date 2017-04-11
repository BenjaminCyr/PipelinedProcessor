----------------------------------------------
-- File: 		Data_Memory.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 10, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity Data_Memory is
	generic (DataWidth : integer := 16;
			 AddrBits : integer := 16);
	port (
		CLK : in std_logic;
		MemRead : in std_logic;
		MemWrite : in std_logic;
		Address: in std_logic_vector(AddrBits-1 downto 0);
		WriteData: in std_logic_vector(DataWidth-1 downto 0);
		ReadData: out std_logic_vector(DataWidth-1 downto 0));
end entity Data_Memory;

architecture Data_Memory_Behavior of Data_Memory is
    subtype WORD  is std_logic_vector(DataWidth-1 downto 0);
    type    RAM   is array(0 to  2**AddrBits-1) of WORD;
    
    signal memory : RAM := (others => (others => '0'));
    
	begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if MemRead = '1' then
				ReadData <= memory(to_integer(unsigned(Address)));
			elsif MemWrite = '1' then
				memory(to_integer(unsigned(Address))) <= WriteData;
			end if;
		end if;
	end process;
end architecture Data_Memory_Behavior;
