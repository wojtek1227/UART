library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity uart_transmiter_TB is
end uart_transmiter_TB;

architecture TB_ARCHITECTURE of uart_transmiter_TB is
	-- Component declaration of the tested unit
	component uart_transmiter
	port(
	CLK : in std_logic;
	CE	: in std_logic;
	RST : in std_logic;
	LOAD_DATA : in std_logic;
	Din	: in std_logic_vector(7 downto 0);
	TX	: out std_logic;
	TX_READY : out std_logic 
	);
	end component;	 

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK 	: std_logic;
	signal CE	: std_logic;
	signal RST	: std_logic;
	signal LOAD_DATA : std_logic;
	signal Din	: std_logic_vector(7 downto 0);
	
	-- Observed signals - signals mapped to the output ports of tested entity
	signal TX : std_logic;
	signal TX_READY : std_logic;

	--Signal is used to stop clock signal generators
	signal END_SIM: BOOLEAN:=FALSE;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : uart_transmiter
		port map (
		CLK => CLK,
		CE => CE,
		RST => RST,
		LOAD_DATA => LOAD_DATA,
		Din => Din,
		TX => TX,
		TX_READY => TX_READY
		);

	--Below VHDL code is an inserted .\compile\Initial.vhs
	--User can modify it ....

STIMULUS: process
begin  -- of stimulus process
--wait for <time to next event>; -- <current time>
	RST <= '0';
	CE <= '0';
	LOAD_DATA <= '0';
	wait for 12 ns;
	RST <= '1';
	wait for 8 ns;
	RST <= '0';
	wait for 20 ns;
	CE <= '1';
	wait for 20 ns;
	Din <= "11010110";
	wait for 10 ns;
	LOAD_DATA <= '1';
	wait for 40 ns;
	RST <= '1';	
	wait for 3 ns;
	RST <= '0';		
	wait for 10 ns;
	RST <= '1';
	wait for 20 ns;
	RST <= '0';
	wait for 102 ns;
	CE <= '0';
	wait for 15 ns;
	CE <= '1';
	wait for 50 ns;
	CE <= '0';
	wait for 50 ns;
	CE <= '1'; 
	wait for 80 ns;
	LOAD_DATA <= '0';
	wait for 100 ns;
	LOAD_DATA <= '1';
	Din <= "01010101";
	wait for 10 ns;
	Din <= "11001010";
	wait for 100 ns;
	Din <= "01001111";
	
	
    wait for 250 ns;	 
	END_SIM <= TRUE;
--	end of stimulus events
	wait;
end process; -- end of stimulus process
	
CLOCK_CLK : process
begin
	if END_SIM = FALSE then
		CLK <= '0';
		wait for 5 ns; 
	else
		wait;
	end if;
	if END_SIM = FALSE then
		CLK <= '1';
		wait for 5 ns;
	else
		wait;
	end if;
end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_uart_transmiter of uart_transmiter_TB is
	for TB_ARCHITECTURE
		for UUT : uart_transmiter
			use entity work.uart_transmiter(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_uart_transmiter;

