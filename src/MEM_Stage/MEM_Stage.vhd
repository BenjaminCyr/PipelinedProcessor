----------------------------------------------
-- File: 		MEM_Stage.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 2, 2017	
---------------------------------------------

entity MEM_Stage is
	generic (RegWidth : integer := 16;
			 ControlBits_In : integer := 4;
			 ControlBits_Out : integer := 2;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		RST: in std_logic;

		Control_In: in std_logic_vector(ControlBits_In-1 downto 0);
		Control_Out: out std_logic_vector(ControlBits_Out-1 downto 0);
		ALUOut_In: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut_Out: out std_logic_vector(RegWidth-1 downto 0);
		MemData_In: in std_logic_vector(RegWidth-1 downto 0);
		MemData_Out: out std_logic_vector(RegWidth-1 downto 0);
		DestReg_In: in std_logic_vector(AddrBits-1 downto 0);
		DestReg_Out: out std_logic_vector(AddrBits-1 downto 0);

		MemRead out std_logic;
		MemWrite out std_logic;
		RegWrite out std_logic);
end entity MEM_Stage;

architecture MEM_Stage_Behavior of MEM_Stage is 
	signal MemWrite : std_logic;
	signal MemRead : std_logic;
	signal MemData : std_logic_vector (RegWidth-1 downto 0);
	signal Control : std_logic_vector (ControlBits_In-1 downto 0);

	MemWrite <= Control(3);
	MemRead <= Control(2);
	Control_Out <= Control(1 downto 0);
	RegWrite <= Control(1);

	EX_MEM_Reg : entity EX_MEM_Register 
				generic map (RegWidth, ControlBits_In, AddrBits) 
				port map ( CLK, RST, Control_In, Control, 
					ALUOut_In, ALUOut_Out, MemData_In, MemData_Out, 
					DestReg_In, DestReg_Out);

end architecture MEM_Stage_Behavior;
