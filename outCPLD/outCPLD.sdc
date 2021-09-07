## Generated SDC file "outCPLD.sdc"

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

## DATE    "Mon Sep  6 21:30:21 2021"

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


set_input_delay -clock { pclk_50M } 2 [get_ports {outP[1] outP[2] outP[3] outP[4] outP[5] outP[6] outP[7] outP[8] out[1] out[2] out[3] out[4] out[5] out[6] out[7] out[8] out[9] out[10] out[11] out[12] out[13] out[14] out[15] out[16] out[17] out[18] out[19] out[20] out[21] out[22] out[23] out[24] out[25] out[26] out[27] out[28]}]

#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -clock { pclk_50M } 2 [get_ports {eoutP[1] eoutP[2] eoutP[3] eoutP[4] eoutP[5] eoutP[6] eoutP[7] eoutP[8] eout[1] eout[2] eout[3] eout[4] eout[5] eout[6] eout[7] eout[8] eout[9] eout[10] eout[11] eout[12] eout[13] eout[14] eout[15] eout[16] eout[17] eout[18] eout[19] eout[20] eout[21] eout[22] eout[23] eout[24] eout[25] eout[26] eout[27] eout[28]}]

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

