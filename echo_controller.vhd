-------------------------------------------------------------------------------
--
-- Title       : echo_controller
-- Design      : uart
-- Author      : Wojciech Caputa
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : E:\UART2\UART\uart\src\echo_controller.vhd
-- Generated   : Fri Jun 23 12:55:27 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {echo_controller} architecture {echo_controller}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity echo_controller is
	port(
		CLK : in STD_LOGIC;
		CE : in STD_LOGIC;
		RST : in STD_LOGIC;
		RX_flag : in STD_LOGIC;
		RX_error : in STD_LOGIC;
		TX_ready : in STD_LOGIC;
		LOAD_DATA : out STD_LOGIC
		);
end echo_controller;

--}} End of automatically maintained section

architecture echo_controller of echo_controller is 
signal prev_RX_flag: std_logic := '0';
signal prev_TX_ready: std_logic := '0';
	--signal received: std_logic;
	signal LOAD: std_logic;
begin
	
	-- enter your statements here --
	process(RST, CLK)
		variable received: std_logic;
	begin
		if RST = '1' then
			LOAD <= '0';
			received := '0';
		elsif rising_edge(CLK) then
			if CE = '1' then
				prev_RX_flag <= RX_flag;
				prev_TX_ready <= TX_ready;
				if prev_RX_flag = '0' and RX_flag = '1' then
					received := '1';
				end if;
				
				if received = '1' then
					if TX_ready = '1' then
						LOAD <= '1';
					elsif prev_TX_ready = '1' and TX_ready = '0' then
						received := '0';
						LOAD <= '0';
					end if;
				end if;
			end if;
			
		end if;
	end process;
	
	LOAD_DATA <= LOAD;	
	
end echo_controller;
