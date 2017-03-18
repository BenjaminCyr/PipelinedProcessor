library IEEE;
use IEEE.std_logic_1164.all;

entity Branch_Unit is
	generic (RegWidth : integer := 16);
	port (
		Branch_Taken: in std_logic;
		Branch: in std_logic;
		BEQ_BNE: in std_logic;
		Zero: in std_logic;
		PC: in std_logic_vector(RegWidth-1 downto 0);
		JumpReg: in std_logic;
		Imm: in std_logic_vector(RegWidth-1 downto 0);
		RegData: in std_logic_vector(RegWidth-1 downto 0);
		Prediction_Miss: out std_logic;
		Branch_Target_Addr: out std_logic_vector(RegWidth-1 downto 0)
		Flush: out std_logic);
end entity Branch_Unit;

architecture Branch_Unit_Behavior of Branch_Unit is
	signal Should_Branch : std_logic;
	begin
		Should_Branch <= '1' when Branch = '1' and 
						((BEQ_BNE = '0' and Zero = '1') or 
						(BEQ_BNE = '1' and Zero = '0')) else
						'0';
		Prediction_Miss <= Should_Branch xor Branch_Taken;
		Branch_Target_Addr <= RegData when JumpReg = '1' else
							std_logic_vector(unsigned(PC)+unsigned(Imm)) 
							when Should_Branch = '1' else 
							PC;
		Flush <= Prediction_Miss or JumpReg;
end architecture Branch_Unit_Behavior;
