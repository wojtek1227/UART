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
	type State_type is (Idle, Data);
	signal RX_int : std_logic;
	signal RX_int2 : std_logic;
	signal State : State_type;
	signal data_reg : std_logic_vector(7 downto 0);
	
	
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
			State <= Idle;
			data_reg <= (others => '0');
		elsif rising_edge(CLK) then
			if CE = '1' then
				case State is
					when Idle =>
						if RX_int2 = '0' then
							if cnt > 6 then
								State <= Data;
								cnt := 0;
								received_bits := 0;
								RX_flag <= '0';
							else
								cnt := cnt + 1;
								--State <= Idle;
							end if;
						else
							--State <= Idle;
							cnt := 0;
						end if;	
					
					when Data =>
						if received_bits < 8 then
							if cnt = 15 then 
								data_reg(received_bits) <= RX_int2;
								cnt := 0;
								received_bits := received_bits + 1;
							else 
								cnt := cnt + 1;
							end if;
						else
							if cnt = 16 then
								if RX_int2 = '1' then
									RX_flag <= '1';
									State <= Idle;
									Dout <= data_reg;
								else
									State <= Idle;
								end if;
							else
								cnt := cnt + 1;
							end if;
						end if;		
					
					when others =>
						null;	
					
				end case;
			end if;
		end if;
		
	end process;
	
end behavioral;
