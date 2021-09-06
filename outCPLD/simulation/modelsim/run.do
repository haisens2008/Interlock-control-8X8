# Compile Design
vsim rtl_work.outCPLD_tb -L altera_mf_ver -L altera_lnsim_ver

add wave sim:/outCPLD_tb/pclk_50M
add wave sim:/outCPLD_tb/outP
add wave sim:/outCPLD_tb/out
add wave sim:/outCPLD_tb/eoutP
add wave sim:/outCPLD_tb/eout

add wave -decimal sim:/outCPLD_tb/DUT/cnt
add wave sim:/outCPLD_tb/DUT/current_state
add wave sim:/outCPLD_tb/DUT/last_outP
add wave sim:/outCPLD_tb/DUT/last_out
add wave sim:/outCPLD_tb/DUT/check


run 21000us

