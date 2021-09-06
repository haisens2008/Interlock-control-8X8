#File:outCPLD.sdc
create_clock -period 20.000 -waveform {0.000 10.000} -name pclk_50M [get_ports {clk}]
set_input_delay -clock pclk_50M 1.5 [all_inputs]
set_output_delay -clock pclk_50M 1.5 [all_outputs]
#automatically creates constraints for PLL generated clocks

#set_output_delay -clock { pclk_50M } 1.5 \
#                [get_ports {outP[1] \
#                            outP[2] \
#                            outP[3] \
#                            outP[4] \
#                            outP[5] \
#                            outP[6] \
#                            outP[7] }]