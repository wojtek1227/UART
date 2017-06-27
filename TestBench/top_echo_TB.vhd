library ieee;
use ieee.STD_LOGIC_SIGNED.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- Add your library and packages declaration here ...

entity top_echo_tb is
end top_echo_tb;

architecture TB_ARCHITECTURE of top_echo_tb is
	-- Component declaration of the tested unit
	component top_echo
		port(
			CE : in STD_LOGIC;
			CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			RX : in STD_LOGIC;
			TX : out STD_LOGIC );
	end component;
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CE : STD_LOGIC;
	signal CLK : STD_LOGIC;
	signal RST : STD_LOGIC;
	signal RX : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal TX : STD_LOGIC;
	--Signal is used to stop clock signal generators
	signal END_SIM: BOOLEAN:=FALSE;
	-- Add your code here ...
	
begin
	
	-- Unit Under Test port map
	UUT : top_echo
	port map (
		CE => CE,
		CLK => CLK,
		RST => RST,
		RX => RX,
		TX => TX
		);
	
	-- Add your stimulus here ...
	STIMULUS: process
	begin
		RST <= '1';
		RX <= '1'; 
		CE <= '0';
		wait for 20 ns;
		RST <= '0';
		wait for 20 ns;
		CE <= '1';
		wait for 10 ns;
		RX <= '0';		  -- start bit
		wait for 512 ns; 
		RX <= '1';		  -- bit 0
		wait for 512 ns; 
		RX <= '0';		  -- bit 1
		wait for 512 ns;
		RX <= '1';		  -- bit 2
		wait for 512 ns;
		RX <= '0';		  -- bit 3
		wait for 512 ns;
		RX <= '1';		  -- bit 4
		wait for 512 ns; 
		RX <= '0';		  -- bit 5
		wait for 512 ns;
		RX <= '1';		  -- bit 6
		wait for 512 ns;
		RX <= '0';		  -- bit 7
		wait for 512 ns;
		RX <= '1';		  -- stop bit
		wait for 10 ns;
		CE <= '0';
		wait for 20 ns;
		RST <= '1';
		wait for 20 ns;
		RST <= '0';
		wait for 500 ns;
		CE <= '1';
		wait for 512 ns;
		RX <= '0';		  -- start bit
		wait for 512 ns; 
		RX <= '0';		  -- bit 0
		wait for 512 ns; 
		RX <= '0';		  -- bit 1
		wait for 512 ns;
		RX <= '1';		  -- bit 2
		wait for 512 ns;
		RX <= '0';		  -- bit 3
		wait for 512 ns;
		RX <= '1';		  -- bit 4
		wait for 512 ns; 
		RX <= '1';		  -- bit 5
		wait for 512 ns;
		RX <= '1';		  -- bit 6
		wait for 512 ns;
		RX <= '0';		  -- bit 7
		wait for 512 ns;
		RX <= '1';		  -- stop bit
		wait for 512 ns;
		RX <= '0';		  -- start bit
		wait for 512 ns; 
		RX <= '1';		  -- bit 0
		wait for 512 ns; 
		RX <= '1';		  -- bit 1
		wait for 512 ns;
		RX <= '1';		  -- bit 2
		wait for 512 ns;
		RX <= '0';		  -- bit 3
		wait for 512 ns;
		RX <= '1';		  -- bit 4
		wait for 512 ns; 
		RX <= '0';		  -- bit 5
		wait for 512 ns;
		RX <= '1';		  -- bit 6
		wait for 512 ns;
		RX <= '1';		  -- bit 7
		wait for 512 ns;
		RX <= '1';		  -- stop bit
		wait for 10 us;	 
		END_SIM <= TRUE;
		wait;	
	end process;
	
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
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_top_echo of top_echo_tb is
	for TB_ARCHITECTURE
		for UUT : top_echo
			use entity work.top_echo(top_echo);
		end for;
	end for;
end TESTBENCH_FOR_top_echo;

