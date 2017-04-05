----------------------------------------------
-- File: 		Instruction_Memory.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 20, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity Instruction_Memory is
	generic (FileName : string := "instructions.txt";
			 DataWidth : integer := 16;
			 AddrBits : integer := 16);
	port (
		CLK : in std_logic;
		ReadAddr: in std_logic_vector(AddrBits-1 downto 0);
		ReadData: out std_logic_vector(DataWidth-1 downto 0));
end entity Instruction_Memory;

architecture Instruction_Memory_Behavior of Instruction_Memory is
    subtype WORD  is std_logic_vector(DataWidth-1 downto 0);
    type    RAM   is array(0 to  2**AddrBits-1) of WORD;
    
	impure function ocram_ReadMemFile(FileName : STRING) return RAM is
      file FileHandle       : TEXT open READ_MODE is FileName;
      variable CurrentLine  : LINE;
      variable TempWord     : STD_LOGIC_VECTOR(WORD'length-1 downto 0);
      variable Result       : RAM    := (others => (others => '0'));
    begin
      for i in 0 to 2**AddrBits - 1 loop
        exit when endfile(FileHandle);
        readline(FileHandle, CurrentLine);
        hread(CurrentLine, TempWord);
        Result(i)    := TempWord;
      end loop;
      return Result;
    end function;
    
    signal memory : RAM := ocram_ReadMemFile(FileName);
    
	begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			ReadData <= memory(to_integer(unsigned(ReadAddr)));
		end if;
	end process;
end architecture Instruction_Memory_Behavior;
