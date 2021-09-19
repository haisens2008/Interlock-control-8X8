transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/ite367/Documents/Interlock-control-8X8-main/outCPLD {/home/ite367/Documents/Interlock-control-8X8-main/outCPLD/outCPLD.sv}

vlog -sv -work work +incdir+/home/ite367/Documents/Interlock-control-8X8-main/outCPLD {/home/ite367/Documents/Interlock-control-8X8-main/outCPLD/outCPLD_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L maxii_ver -L rtl_work -L work -voptargs="+acc"  outCPLD_tb

add wave *
view structure
view signals
run -all
