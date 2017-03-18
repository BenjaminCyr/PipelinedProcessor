library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_Register is
	generic (RegWidth : integer := 16;
			 ControlBits : integer := 13;
			 AddrBits : integer := 3);
	port (
    	CLK: in std_logic;
		Flush: in std_logic;
		Control_In: in std_logic_vector(ControlBits-1 downto 0);
		Control_Out: out std_logic_vector(ControlBits-1 downto 0);
		Branch_Taken_In: in std_logic;
		Branch_Taken_Out: out std_logic);
		PC_In: in std_logic_vector(RegWidth-1 downto 0);
		PC_Out: out std_logic_vector(RegWidth-1 downto 0);
		Reg1_In: in std_logic_vector(RegWidth-1 downto 0);
		Reg1_Out: out std_logic_vector(RegWidth-1 downto 0);
		Reg2_In: in std_logic_vector(RegWidth-1 downto 0);
		Reg2_Out: out std_logic_vector(RegWidth-1 downto 0);
		Imm_In: in std_logic_vector(RegWidth-1 downto 0);
		Imm_Out: out std_logic_vector(RegWidth-1 downto 0);
		Rs_In: in std_logic_vector(AddrBits-1 downto 0);
		Rs_Out: out std_logic_vector(AddrBits-1 downto 0);
		Rt_In: in std_logic_vector(AddrBits-1 downto 0);
		Rt_Out: out std_logic_vector(AddrBits-1 downto 0);
		Rd_In: in std_logic_vector(AddrBits-1 downto 0);
		Rd_Out: out std_logic_vector(AddrBits-1 downto 0);
end entity ID_EX_Register;

architecture ID_EX_Register_Behavior of ID_EX_Register is
	signal Control: std_logic_vector(ControlBits-1 downto 0);
	signal Branch_Taken: std_logic;
	signal PC: std_logic_vector(RegWidth-1 downto 0);
	signal Reg1: std_logic_vector(RegWidth-1 downto 0);
	signal Reg2: std_logic_vector(RegWidth-1 downto 0);
	signal Imm: std_logic_vector(RegWidth-1 downto 0);
	signal Rs: std_logic_vector(AddrBits-1 downto 0);
	signal Rt: std_logic_vector(AddrBits-1 downto 0);
	signal Rd: std_logic_vector(AddrBits-1 downto 0);
	begin
		Control_Out <= Control;
		Branch_Taken_Out <= Branch_Taken;
		PC_Out <= PC;
		Reg1_Out <= Reg1;
		Reg2_Out <= Reg2;
		Imm_Out <= Imm;
		Rs_Out <= Rs;
		Rt_Out <= Rt;
		Rd_Out <= Rd;
		process(CLK)
		begin
			if rising_edge(CLK) then
				if Flush = '1' then
					Control <= (others => '0');
					Branch_Taken <= '0';
					PC <= (others => '0');
					Reg1 <= (others => '0');
					Reg2 <= (others => '0');
					Imm <= (others => '0');
					Rs <= (others => '0');
					Rt <= (others => '0');
					Rd <= (others => '0');
				else 
					Control <= Control_In;
					Branch_Taken <= Branch_Taken_In;
					PC <= PC_In;
					Reg1 <= Reg1_In;
					Reg2 <= Reg2_In;
					Imm <= Imm_In;
					Rs <= Rs_In;
					Rt <= Rt_In;
					Rd <= Rd_In;
				end if;
			end if;
		end process;
end architecture ID_EX_Register_Behavior;
