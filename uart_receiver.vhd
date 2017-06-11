-------------------------------------------------------------------------------
--
-- Title       : receiver
-- Design      : uart
-- Author      : caputa.wojciech@gmail.com
-- Company     : student
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\UART\uart\src\uart_receiver.vhd
-- Generated   : Tue Jun  6 02:09:11 2017
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
--{entity {uart_receiver} architecture {behavioral}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity uart_receiver is	
	port(
		CLK : in std_logic;
		RST : in std_logic;
		CE : in std_logic;
		RX : in std_logic;
		Dout : out std_logic_vector(7 downto 0);
		RX_flag	: out std_logic
		);
end uart_receiver;

--}} End of automatically maintained section

architecture behavioral of uart_receiver is	   
	type State_type is (Idle, Receive);
	signal RX_int : std_logic;
	signal RX_int2 : std_logic;
	signal State : State_type;
	
	
begin
	process(CLK)
	begin
		RX_int <= RX;
		RX_int2 <= RX_int;
	end process	;
	
	process(RST, CLK)
	variable cnt: integer range 0 to 16;
	variable received_bits : integer range 0 to 8;
	begin
		if RST='1' then
			Dout <= (others => '0');
			RX_flag <= '0';
		elsif rising_edge(CLK) then
			if CE = '1' then
				case State is
					when Idle =>
						if (RX_int2 = 0) and (cnt = 0) then
							cnt = cnt + 1;	
						elsif (RX_int2 = 0) and (cnt =8) then
							cnt := 0;
							received_bits := 0;
							State <= Receive;
						elsif (RX_int2 = 1) then
							cnt := 0;
							State <= Idle;
						else
							cnt := cnt + 1;
						end if;
					
					when Receive =>
					if received_bits < 8 then
						if cnt = 16 then 
							Dout(received_bits) <= RX_int2;
							cnt :=
					when others =>
						null;	
					
				end case;
			end if;
		end if;
		
	end process;
	
end behavioral;
