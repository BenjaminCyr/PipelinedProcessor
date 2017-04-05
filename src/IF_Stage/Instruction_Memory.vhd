----------------------------------------------
-- File: 		Instruction_Memory.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 20, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Instruction_Memory is
	generic (FileName : STRING := "instructions.txt";
			 DataWidth : integer := 16;
			 AddrBits : integer := 16);
	port (
		CLK : in std_logic;
		ReadAddr: in std_logic_vector(AddrBits-1 downto 0);
		ReadData: out std_logic_vector(DataWidth-1 downto 0));
end entity Instruction_Memory;

subtype WORD  is std_logic_vector(DataWidth-1 downto 0);
type    RAM   is array(0 to  2**AddrBits-1) of WORD;

architecture Instruction_Memory_Behavior of Instruction_Memory is
	signal ram : RAM := ocram_ReadMemFile(FileName)
	begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			ReadData <= ram(to_unsigned(ReadAddr));
		end if;
	end process;
end architecture Instruction_Memory_Behavior;

impure function ocram_ReadMemFile(FileName : STRING) return ram_t is
  file FileHandle       : TEXT open READ_MODE is FileName;
  variable CurrentLine  : LINE;
  variable TempWord     : STD_LOGIC_VECTOR((div_ceil(WORD'length, 4) * 4) - 1 downto 0);
  variable Result       : RAM    := (others => (others => '0'));

begin
  for i in 0 to 2**AddrBits - 1 loop
    exit when endfile(FileHandle);

    readline(FileHandle, CurrentLine);
    hread(CurrentLine, TempWord);
    Result(i)    := resize(TempWord, WORD'length);
  end loop;

  return Result;
end function;
