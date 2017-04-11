----------------------------------------------
-- File: 		WB_Stage.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		April 1, 2017	
---------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity WB_Stage is
	generic (RegWidth : integer := 16;
			 ControlBits : integer := 2;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		RST: in std_logic;

		Control_In: in std_logic_vector(ControlBits-1 downto 0);
		MemOut_In: in std_logic_vector(RegWidth-1 downto 0);
		ALUOut_In: in std_logic_vector(RegWidth-1 downto 0);
		DestReg_In: in std_logic_vector(AddrBits-1 downto 0);

		WriteData: out std_logic_vector(RegWidth-1 downto 0);
		DestReg_Out: out std_logic_vector(AddrBits-1 downto 0);
		RegWrite: out std_logic);
end entity WB_Stage;

architecture WB_Stage_Behavior of WB_Stage is 
	signal Control_Out : std_logic_vector(ControlBits-1 downto 0);
	signal MemOut_Out : std_logic_vector(RegWidth-1 downto 0);
	signal ALUOut_Out : std_logic_vector(RegWidth-1 downto 0);
	signal MemToReg : std_logic;

    begin
    
        MemToReg <= Control_Out(0);
        RegWrite <= Control_Out(1);
    
        MEM_WB_Reg : entity work.MEM_WB_Register 
                    generic map (RegWidth, ControlBits, AddrBits) 
                    port map ( CLK, RST, Control_In, Control_Out, 
                        MemOut_In, MemOut_Out, ALUOut_In, ALUOut_Out,
                        DestReg_In, DestReg_Out);
        
        WB_Mux : entity work.WriteBack_Mux 
                    generic map (RegWidth)
                    port map (MemToReg, MemOut_Out,
                        ALUOut_Out, WriteData);
	
end architecture WB_Stage_Behavior;
