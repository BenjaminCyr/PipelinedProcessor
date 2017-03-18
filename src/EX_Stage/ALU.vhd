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
	Op1 : signed(RegWidth-1 downto 0);
	Op2 : signed(RegWidth-1 downto 0);
	Result : signed(RegWidth-1 downto 0);
	begin
		Op1 <= signed(Operand1);
		Op2 <= signed(Operand2);
		Zero <= '1' when Result = (others => '0') else '0'
		Result <= (others => '0') when ALUOp = "000" else
					Op1 + Op2 when ALUOp = "001" else
					Op1 - Op2	when ALUOp = "010" else
					Op1 and Op2 when ALUOp = "011" else
					Op1 or Op2 when ALUOp = "100" else
					to_unsigned(1, Result'length)) when ALUOp = "101" and Op1 < Op2 else
					(others => '0') when ALUOp = "101" and Op1 >= Op2 else
					shift_left(Op1, natural(Op2)) when ALUOp = "110" else
					shift_right(Op1, natural(Op2)) when ALUOp = "111" else
					(others => 'X') when others;
		ALUOut <= std_logic_vector(Result)
end architecture ALU_Behavior;
