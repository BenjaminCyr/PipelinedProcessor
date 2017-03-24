----------------------------------------------
-- File: 		ID_EX_Register.vhd
-- Created By: 	Benjamin Cyr
-- Date: 		March 18, 2017	
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_Register is
	generic (RegWidth : integer := 16;
			 ControlBits : integer := 13;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		RST: in std_logic;
		Stall: in std_logic;
		Flush: in std_logic;
		Control_In: in std_logic_vector(ControlBits-1 downto 0);
		Control_Out: out std_logic_vector(ControlBits-1 downto 0);
		Branch_Taken_In: in std_logic;
		Branch_Taken_Out: out std_logic;
		PC_In: in std_logic_vector(RegWidth-1 downto 0);
		PC_Out: out std_logic_vector(RegWidth-1 downto 0);
		ReadData1_In: in std_logic_vector(RegWidth-1 downto 0);
		ReadData1_Out: out std_logic_vector(RegWidth-1 downto 0);
		ReadData2_In: in std_logic_vector(RegWidth-1 downto 0);
		ReadData2_Out: out std_logic_vector(RegWidth-1 downto 0);
		Imm_In: in std_logic_vector(RegWidth-1 downto 0);
		Imm_Out: out std_logic_vector(RegWidth-1 downto 0);
		Rs_In: in std_logic_vector(AddrBits-1 downto 0);
		Rs_Out: out std_logic_vector(AddrBits-1 downto 0);
		Rt_In: in std_logic_vector(AddrBits-1 downto 0);
		Rt_Out: out std_logic_vector(AddrBits-1 downto 0);
		Rd_In: in std_logic_vector(AddrBits-1 downto 0);
		Rd_Out: out std_logic_vector(AddrBits-1 downto 0));
end entity ID_EX_Register;

architecture ID_EX_Register_Behavior of ID_EX_Register is
	signal Control: std_logic_vector(ControlBits-1 downto 0);
	signal Branch_Taken: std_logic;
	signal PC: std_logic_vector(RegWidth-1 downto 0);
	signal ReadData1: std_logic_vector(RegWidth-1 downto 0);
	signal ReadData2: std_logic_vector(RegWidth-1 downto 0);
	signal Imm: std_logic_vector(RegWidth-1 downto 0);
	signal Rs: std_logic_vector(AddrBits-1 downto 0);
	signal Rt: std_logic_vector(AddrBits-1 downto 0);
	signal Rd: std_logic_vector(AddrBits-1 downto 0);
	begin
		Control_Out <= Control;
		Branch_Taken_Out <= Branch_Taken;
		PC_Out <= PC;
		ReadData1_Out <= ReadData1;
		ReadData2_Out <= ReadData2;
		Imm_Out <= Imm;
		Rs_Out <= Rs;
		Rt_Out <= Rt;
		Rd_Out <= Rd;
		process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '1' or Flush = '1' or Stall = '1' then
					Control <= (others => '0');
					Branch_Taken <= '0';
					PC <= (others => '0');
					ReadData1 <= (others => '0');
					ReadData2 <= (others => '0');
					Imm <= (others => '0');
					Rs <= (others => '0');
					Rt <= (others => '0');
					Rd <= (others => '0');
				else 
					Control <= Control_In;
					Branch_Taken <= Branch_Taken_In;
					PC <= PC_In;
					ReadData1 <= ReadData1_In;
					ReadData2 <= ReadData2_In;
					Imm <= Imm_In;
					Rs <= Rs_In;
					Rt <= Rt_In;
					Rd <= Rd_In;
				end if;
			end if;
		end process;
end architecture ID_EX_Register_Behavior;
