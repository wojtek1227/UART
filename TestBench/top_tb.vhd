library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture tb_arch of top_tb is
	
	component top
		port(
			CE : in STD_LOGIC;
			CLK : in STD_LOGIC;
			LOAD_DATA : in STD_LOGIC;
			RST : in STD_LOGIC;
			Din : in STD_LOGIC_VECTOR(7 downto 0);
			RX_flag : out STD_LOGIC;
			TX_ready : out STD_LOGIC;
			Dout : out STD_LOGIC_VECTOR(7 downto 0)
			);
	end component;
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CE : std_logic;
	signal CLK : std_logic;
	signal LOAD_DATA : std_logic;
	signal RST : std_logic;
	signal Din : std_logic_vector(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity 
	signal TX_ready : std_logic;
	signal Dout : std_logic_vector(7 downto 0);
	
	--Signal is used to stop clock signal generators
	signal END_SIM: BOOLEAN:=FALSE;
	
	-- Add your code here ...
begin
	
	UUT : top
	port map (
		CE => CE,
		CLK => CLK,
		LOAD_DATA => LOAD_DATA,
		RST => RST,
		Din => Din,
		TX_ready => TX_ready,
		Dout => Dout
		); 
	
	STIMULUS: process
	begin  -- of stimulus process
		--wait for <time to next event>; -- <current time>
		RST <= '1';
		wait for 20 ns;
		RST <= '0';
		wait for 10 ns;
		CE <= '1';
		Din <= "10101010";
		wait for 10 ns;
		LOAD_DATA <= '1';
		wait for 10 ns;
		LOAD_DATA <= '0';
		wait for 10 ns;
		Din <= "01010111";
		wait for 20 ns;
		CE <= '0';
		wait for 100 ns;
		CE <= '1';
		wait for 100 ns;
		CE <= '0';
		wait for 20 ns;
		RST <= '1';
		wait for 5 ns;
		RST <= '0';
		wait for 20 ns;
		CE <= '1';
		wait for 290 ns;
		LOAD_DATA <= '1';
		wait for 300 ns;
		Din <= "10110111";
		wait for 340 ns;
		Din <= "11010110";
		wait for 1 us;	 
		END_SIM <= TRUE;
		--	end of stimulus events
		wait;
	end process; -- end of stimulus process
	
	CLOCK_CLK : process
	begin
		if END_SIM = FALSE then
			CLK <= '0';
			wait for 1 ns; 
		else
			wait;
		end if;
		if END_SIM = FALSE then
			CLK <= '1';
			wait for 1 ns;
		else
			wait;
		end if;
	end process;
	
	
end tb_arch;

configuration TESTBENCH of top_tb is
	for tb_arch
		for UUT : top
			use entity work.top(arch);
		end for;
	end for;
end TESTBENCH;		
