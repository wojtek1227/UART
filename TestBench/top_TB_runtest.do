SetActiveLib -work
comp -include "$dsn\src\top.bde" 
comp -include "$dsn\src\TestBench\top_tb.vhd" 
asim +access +r TESTBENCH 
wave 
wave -noreg CLK
wave -noreg CLK16
wave -noreg RST
wave -noreg CE
wave -noreg LOAD_DATA
wave -noreg Din
wave -noreg RX_error
wave -noreg RX_flag
wave -noreg TX_ready
wave -noreg Dout

run 1500.00 ns
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\tutorvhdl_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_tutorvhdl 
