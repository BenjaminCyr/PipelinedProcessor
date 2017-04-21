library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity universal_reg is
	generic (N : integer := 8);
	port (
		CLK: in std_logic;
		Din: in std_logic_vector(N-1 downto 0);
		RST: in std_logic;
		CE: in std_logic;
		M: in std_logic_vector(1 downto 0);
		Dout: out std_logic_vector(N-1 downto 0));
end entity universal_reg; 

architecture behavior of universal_reg is
	signal D: std_logic_vector(N-1 downto 0);
	begin
		Dout <= D;
		process(CLK)
		begin
			if rising_edge(CLK) then
				if RST = '1' then D <= (others => '0');
				elsif CE = '1' then
					case M is
						when "00" => D <= D;
						when "01" => D <= Din(N-1) & D(N-1 downto 1);
						when "10" => D <= D+1;
						when "11" => D <= Din;
						when others => D <= (others => 'X');
					end case;
				end if;
			end if;
		end process;
end architecture behavior;
				
