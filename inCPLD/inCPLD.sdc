## Generated SDC file "inCPLD.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Mon Sep  6 21:56:21 2021"

##
## DEVICE  "EPM240T100C5"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {spi_clk} -period 4000.000 -waveform { 0.000 2000.000 } [get_ports {spi_clk}]
create_clock -name {pclk_50M} -period 20.000 -waveform { 0.000 10.000 } [get_ports {pclk_50M}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -clock { pclk_50M } 2 [get_ports {data_in[0] data_in[1] data_in[2] data_in[3] data_in[4] data_in[5] data_in[6] data_in[7] data_in[8] data_in[9] data_in[10] data_in[11] data_in[12] data_in[13] data_in[14] data_in[15] data_in[16] data_in[17] data_in[18] data_in[19] data_in[20] data_in[21] data_in[22] data_in[23] data_in[24] data_in[25] data_in[26] data_in[27] data_in[28] data_in[29] data_in[30] data_in[31] data_in[32] data_in[33] data_in[34] data_in[35] data_in[36] data_in[37] data_in[38] data_in[39] data_in[40] data_in[41] data_in[42] data_in[43] data_in[44] data_in[45] data_in[46] data_in[47] data_in[48] data_in[49] data_in[50] data_in[51] data_in[52] data_in[53] data_in[54] data_in[55] data_in[56] data_in[57] data_in[58] data_in[59] data_in[60] data_in[61] data_in[62] data_in[63] data_in[64] data_in[65] data_in[66] data_in[67] data_in[68] data_in[69] data_in[70] data_in[71] data_in[72] data_in[73] data_in[74] spi_clk spi_cs}]

#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -clock { pclk_50M } 2 [get_ports {miso}]

#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

