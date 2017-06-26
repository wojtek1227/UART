SetActiveLib -work
comp -include "$dsn\compile\top_echo.vhd" 
comp -include "$dsn\src\TestBench\top_echo_TB.vhd" 
asim +access +r TESTBENCH_FOR_top_echo 
wave 
wave -noreg CE
wave -noreg CLK
wave -noreg RST
wave -noreg RX
wave -noreg TX	 
run 30 us
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\top_echo_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_top_echo 
