----------------------------------------------
-- File: 		Branch_Predictor.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 20, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Branch_Predictor is
	generic (DataWidth : integer := 16
			AddrBits : integer := 4); -- 2**AddrBits table entries
	port (
    	CLK: in std_logic;
		RST: in std_logic; 
		PredictionMiss: in std_logic;
		Instruction: in std_logic_vector(DataWidth-1 downto 0);
		PCPlusOne: in std_logic_vector(DataWidth-1 downto 0);
		BranchTargetAddress: in std_logic_vector(DataWidth-1 downto 0);
		BranchSourceAddress: in std_logic_vector(DataWidth-1 downto 0);
		PredictedAddress: out std_logic_vector(DataWidth-1 downto 0);
		TakeBranch: out std_logic);
end entity Branch_Predictor;

architecture Branch_Predictor_Behavior of Branch_Predictor is
	subtype ENTRY is record 
		HistoryBit : std_logic;
		SourceAddr : std_logic_vector(DataWidth-1 downto 0);
		TargetAddr : std_logic_vector(DataWidth-1 downto 0);
	end record ENTRY;

	constant ENTRY_INIT : ENTRY := (HistoryBit <= '0',
									SourceAddr <= (others => '0'),
									TargetAddr <= (others => '0'));

	type TABLE is array(0 to 2**AddrBits - 1) of ENTRY;
	signal History : TABLE := (others=> ENTRY_INIT);
	signal ReadIndex : unsigned(AddrBits-1 downto 0);
	signal WriteIndex : unsigned(AddrBits-1 downto 0);
	begin
		Index <= unsigned(PCPlusOne(AddrBits-1 downto 0));
		TakeBranch <= '1' 
			when PCPlusOne = History(to_integer(Index)).SourceAddr and
			 	 History(to_integer(Index)).HistoryBit = '1' else
			'0';
		PredictedAddress <= History(to_integer(Index)).TargetAddr;
		
		process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '1' then
					History <= (others => ENTRY_INIT);
				elsif PredictionMiss = '1' then
					History(to_integer(unsigned(BranchSourceAddress(AddrBits-1 downto 0)))) <= (HistoryBit <= not History(to_integer(unsigned(BranchSourceAddress(AddrBits-1 downto 0)))).HistoryBit,
					SourceAddr <= BranchSourceAddress,
					TargetAddr <= BranchTargetAddress);
			end if;
		end process;
end architecture Branch_Predictor_Behavior;
