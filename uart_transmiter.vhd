-------------------------------------------------------------------------------
--
-- Title       : transmiter
-- Design      : uart
-- Author      : caputa.wojciech@gmail.com
-- Company     : student
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\UART\uart\src\uart_transmiter.vhd
-- Generated   : Mon Jun  5 22:38:12 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Uart TX module -- frame format: | start bit | 8 data bits | 1 stop bit |
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity uart_transmiter is
	port(
		CLK : in STD_LOGIC; 					--Clock
		RST : in STD_LOGIC;						--Reset
		CE : in STD_LOGIC;						--Clock enable
		LOAD_DATA : in STD_LOGIC;				--Load data to transmiter
		Din : in STD_LOGIC_VECTOR(7 downto 0);	--Data bus
		TX : out STD_LOGIC;						--Transmiter output
		TX_READY : out STD_LOGIC				--Ready to use
		);
end uart_transmiter;

--}} End of automatically maintained section

architecture behavioral of uart_transmiter is   
	type State_type is (Idle, Start,Shifting, Stop);
	signal State:State_type;
	signal data_reg: std_logic_vector(7 downto 0); 
	signal TX_int:std_logic := '1';
	signal cnt: std_logic_vector(3 downto 0);
	
begin
	process(RST, CLK)
		variable sent_bits: integer range 0 to 8;	 
	begin
		if RST = '1' then
			--Reset
			TX_int <= '1';
			State <= idle;
			TX_READY <= '1';
		elsif rising_edge(CLK) then
			if CE = '1' then
				case State is
					when idle =>
						if LOAD_DATA = '1' then
							data_reg <= Din;	--Saving data to send
							TX_READY <= '0';
							sent_bits := 0;
							State <= Start;
							cnt <= (others => '0');
						else
							TX_int <= '1';
							State <= idle;
							TX_READY <= '1';
						end if;	
					
					when Start =>
						if cnt < 15 then
							TX_int <= '0'; 		-- start bit
							cnt <= cnt + 1;
						else 
							cnt <= (others => '0');
							State <= Shifting;
						end if;
					
					when Shifting => 
						if sent_bits < 8 then
							if cnt < 15 then
								cnt <= cnt + 1;
								TX_int <= data_reg(sent_bits);
							else
								cnt <= (others => '0');
								sent_bits := sent_bits + 1;
							end if;
						else
							State <= Stop;
							TX_int <= '1';
							
						end if;
						
					
					when stop =>
						if cnt < 15 then
							cnt <= cnt + 1;
						else
							cnt <= (others => '0');
							TX_READY <= '1';
							TX_int <= '1';
							State <= Idle;
						end if;
					
					when others =>
						State <= Idle;	  
					
				end case;
			end if;
		end if;
	end process;
	TX <= TX_int;
	
end behavioral;
