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

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_top_echo of top_echo_tb is
	for TB_ARCHITECTURE
		for UUT : top_echo
			use entity work.top_echo(top_echo);
		end for;
	end for;
end TESTBENCH_FOR_top_echo;

