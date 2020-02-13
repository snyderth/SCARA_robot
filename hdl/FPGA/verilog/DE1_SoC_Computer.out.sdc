## Generated SDC file "DE1_SoC_Computer.out.sdc"

## Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus Prime License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 16.0.0 Build 211 04/27/2016 SJ Lite Edition"

## DATE    "Wed Aug 30 13:03:24 2017"

##
## DEVICE  "5CSEMA5F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]
create_clock -name {CLOCK2_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK2_50}]
create_clock -name {CLOCK3_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK3_50}]
create_clock -name {CLOCK4_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK4_50}]
## ad these clocks so the GPIO ports have an attachment to a defined clock
#create_clock -name {FSYNCclkH} -period 17.250 -waveform { 0.000 8.62 } [get_ports {GPIO_0[3]}]
#create_clock -name {LSYNCclkH} -period 17.250 -waveform { 0.000 8.62 } [get_ports {GPIO_0[5]}]
#create_clock -name {DATAclkH}  -period 17.250 -waveform { 0.000 8.62 } [get_ports {GPIO_0[7]}]
#create_clock -name {CLKclkH}   -period 17.250 -waveform { 0.000 8.62 } [get_ports {GPIO_0[9]}]
#create_clock -name {CNVTclkH}  -period 17.250 -waveform { 0.000 8.62 } [get_ports {GPIO_0[11]}]
#create_clock -name {SYNCclkH}  -period 17.250 -waveform { 0.000 8.62 } [get_ports {GPIO_0[13]}]
##  add these virtual clocks to use them to set constraints and groups
#create_clock -name {FSYNCclk}  -period 17.250 -waveform { 0.000 8.62 } 
#create_clock -name {LSYNCclk}  -period 17.250 -waveform { 0.000 8.62 } 
#create_clock -name {DATAclk}   -period 17.250 -waveform { 0.000 8.62 } 
#create_clock -name {CLKclk}    -period 17.250 -waveform { 0.000 8.62 } 
#create_clock -name {CNVTclk}   -period 17.250 -waveform { 0.000 8.62 } 
#create_clock -name {SYNCclk}   -period 17.250 -waveform { 0.000 8.62 } 


#**************************************************************
# Create Generated Clock
#**************************************************************
# I turned derive_pll_clocks off just to get the automatic names, but now it can be turned back on
derive_pll_clocks
#create_generated_clock -name {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 3 -master_clock {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 
#create_generated_clock -name {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 12 -divide_by 2 -master_clock {CLOCK_50} [get_pins {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
#create_generated_clock -name {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 12 -master_clock {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {CLOCK_50}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {CLOCK_50}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {CLOCK_50}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {CLOCK_50}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}] -hold 0.060  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {SYNCclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {SYNCclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {CNVTclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {CNVTclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {CLKclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {CLKclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {DATAclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {DATAclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {LSYNCclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {LSYNCclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {FSYNCclk}]  0.170  
#set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {FSYNCclk}]  0.170  
set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.280  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {SYNCclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {SYNCclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {CNVTclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {CNVTclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {CLKclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {CLKclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {DATAclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {DATAclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {LSYNCclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {LSYNCclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {FSYNCclk}]  0.170  
#set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {FSYNCclk}]  0.170  
set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.280  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************
# we need to use virtual clocks in the '-clock' feild here - on set_output_delay this sets the latching clock
# on set_input_delay the '-clock' feild sets the launching clock
# our timing is generated for output so we only need to set the output delay
#set_output_delay -add_delay  -clock [get_clocks {FSYNCclk}]  0.000 [get_ports {GPIO_0[3]}]
#set_output_delay -add_delay  -clock [get_clocks {LSYNCclk}]  0.000 [get_ports {GPIO_0[5]}]
#set_output_delay -add_delay  -clock [get_clocks {DATAclk}]  0.000 [get_ports {GPIO_0[7]}]
#set_output_delay -add_delay  -clock [get_clocks {CLKclk}]  0.000 [get_ports {GPIO_0[9]}]
#set_output_delay -add_delay  -clock [get_clocks {CNVTclk}]  0.000 [get_ports {GPIO_0[11]}]
#set_output_delay -add_delay  -clock [get_clocks {SYNCclk}]  0.000 [get_ports {GPIO_0[13]}]


#**************************************************************
# Set Clock Groups
#**************************************************************
# set up a group so the timing lines are associated with each other but not other FPGA clocks
#set_clock_groups -asynchronous -group [get_clocks { comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk
# FSYNCclk LSYNCclk DATAclk CLKclk CNVTclk SYNCclk }] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************
# need this to ensure the launch and latch clocks are staggered
#set_multicycle_path -setup -to FSYNCclk 2
#set_multicycle_path -setup -to LSYNCclk 2
#set_multicycle_path -setup -to DATAclk 2
#set_multicycle_path -setup -to CLKclk 2
#set_multicycle_path -setup -to CNVTclk 2
#set_multicycle_path -setup -to SYNCclk 2



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

