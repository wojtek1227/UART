SetActiveLib -work
comp -include "$dsn\src\uart_transmiter.vhd" 
comp -include "$dsn\src\TestBench\uart_transmiter_TB.vhd" 
asim +access +r TESTBENCH_FOR_uart_transmiter 
wave 
wave -noreg CLK
wave -noreg RST
wave -noreg CE
wave -noreg LOAD_DATA
wave -noreg Din
wave -noreg TX
wave -noreg TX_READY 
wave -noreg /uart_transmiter_TB/UUT/State

run 1500.00 ns
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\tutorvhdl_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_tutorvhdl 
