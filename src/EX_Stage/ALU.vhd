library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
	generic (ControlBits: integer := 3;
			RegWidth : integer := 16);
	port (
		ALUOp: in std_logic_vector(ControlBits-1 downto 0);
		Operand1: in std_logic_vector(RegWidth-1 downto 0);
		Operand2: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut: out std_logic_vector(RegWidth-1 downto 0);
		Zero: out std_logic);
end entity ALU;

architecture ALU_Behavior of ALU is
    constant zeros : signed(RegWidth-1 downto 0) := (others => '0');
	signal Op1 : signed(RegWidth-1 downto 0);
	signal Op2 : signed(RegWidth-1 downto 0);
	signal Result : signed(RegWidth-1 downto 0);
	begin
		Op1 <= signed(Operand1);
		Op2 <= signed(Operand2);
		Result <= zeros when ALUOp = "000" else
					Op1 + Op2 when ALUOp = "001" else
					Op1 - Op2	when ALUOp = "010" else
					Op1 and Op2 when ALUOp = "011" else
					Op1 or Op2 when ALUOp = "100" else
					zeros + 1 when ALUOp = "101" and Op1 < Op2 else
					zeros when ALUOp = "101" and Op1 >= Op2 else
					shift_left(Op1, to_integer(unsigned(Op2))) when ALUOp = "110" else
					shift_right(Op1, to_integer(unsigned(Op2))) when ALUOp = "111" else
					(others => 'X');
		Zero <= '1' when Result = zeros else '0';
		ALUOut <= std_logic_vector(Result);
end architecture ALU_Behavior;
