-------------------------------------------------------------------------------
--
-- Title       : echo_controller
-- Design      : uart
-- Author      : 
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
begin

	-- enter your statements here --
	process(RST, CLK)
	begin
		if RST = 1 then
			LOAD_DATA <= '0';
		elsif rising_edge(CLK) then
			if CE = '1' then
				if RX_flag = '1' and TX_ready = '1' then
					LOAD_DATA <= '1';
				
			end if;
		end if;
		
			
		
		
	end process;
	

end echo_controller;
