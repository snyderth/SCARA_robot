#**************************************************************
# Altera DE1-SoC SDC settings
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -name CLOCK_50 -period 20 [get_ports CLOCK_50]
create_clock -name CLOCK2_50 -period 20 [get_ports CLOCK2_50]
create_clock -name CLOCK3_50 -period 20 [get_ports CLOCK3_50]
create_clock -name CLOCK4_50 -period 20 [get_ports CLOCK4_50]
#create_clock -name MASTERclk -period 40 [get_ports MASTERclk]
create_clock -name FSYNCclkH -period 40 [get_ports GPIO_0[3]]
create_clock -name LSYNCclkH -period 40 [get_ports GPIO_0[5]]
create_clock -name DATAclkH  -period 40 [get_ports GPIO_0[7]]
create_clock -name CLKclkH   -period 40 [get_ports GPIO_0[9]]
create_clock -name CNVTclkH  -period 40 [get_ports GPIO_0[11]]
create_clock -name SYNCclkH  -period 40 [get_ports GPIO_0[13]]

# create virtual clocks so we can use them to set output delay
create_clock -name FSYNCclk -period 40 
create_clock -name LSYNCclk -period 40 
create_clock -name DATAclk  -period 40 
create_clock -name CLKclk   -period 40 
create_clock -name CNVTclk  -period 40 
create_clock -name SYNCclk  -period 40 

# Create virtual clock for input and output delay constraints
#create_clock -name fastclock_virt -period 40.000

#create_clock -period "27 MHz"  -name tv_27m [get_ports TD_CLK27]
#create_clock -period "100 MHz" -name clk_dram [get_ports DRAM_CLK]
## AUDIO : 48kHz 384fs 32-bit data
##create_clock -period "18.432 MHz" -name clk_audxck [get_ports AUD_XCK]
##create_clock -period "1.536 MHz" -name clk_audbck [get_ports AUD_BCLK]
## VGA : 640x480@60Hz
#create_clock -period "25.18 MHz" -name clk_vga [get_ports VGA_CLK]
## VGA : 800x600@60Hz
##create_clock -period "40.0 MHz" -name clk_vga [get_ports VGA_CLK]
## VGA : 1024x768@60Hz
##create_clock -period "65.0 MHz" -name clk_vga [get_ports VGA_CLK]
## VGA : 1280x1024@60Hz
##create_clock -period "108.0 MHz" -name clk_vga [get_ports VGA_CLK]


#**************************************************************
# Create Generated Clock
# Automated derivation of generated clocks on PLL outputs
#**************************************************************
#derive_pll_clocks 
# get auto name of output clock from pll
#  something like
# altpll0|altpll_component|auto_generated|pll1|clk[0]
#  comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk
# comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk
#    create_generated_clock -source {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 3 -duty_cycle 50.00 -name {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}
#    create_generated_clock -source {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin} -divide_by 2 -multiply_by 12 -duty_cycle 50.00 -name {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}
#    create_generated_clock -source {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 12 -duty_cycle 50.00 -name {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}
#
create_generated_clock -source {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 3 -duty_cycle 50.00 -name {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} {The_System|system_pll|sys_pll|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}
create_generated_clock -source {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin} -divide_by 2 -multiply_by 12 -duty_cycle 50.00 -name {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} {comb_83|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}
#create_generated_clock -source {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 12 -duty_cycle 50.00 -name {fastclock_virt} {fastclock_virt}
create_generated_clock -source {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 12 -duty_cycle 50.00 -name {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}

# Line below should work now - we needed to create a new port!!!
#    create_generated_clock -source {comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 12 -duty_cycle 50.00 -name {[get_ports MASTERclk]} {[get_ports MASTERclk]} -add
#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
# Derivation of clock uncertainty
#**************************************************************
#derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************
## Board Delay (Data) + Propagation Delay - Board Delay (Clock)
#set_input_delay -max -clock GPIO_0[1]  2 [get_ports CLOCK_50]
#set_input_delay -max -clock clk_dram -0.048 [get_ports DRAM_DQ*]
#set_input_delay -min -clock clk_dram -0.057 [get_ports DRAM_DQ*]
#
#set_input_delay -max -clock tv_27m 3.692 [get_ports TD_DATA*]
#set_input_delay -min -clock tv_27m 2.492 [get_ports TD_DATA*]
#set_input_delay -max -clock tv_27m 3.654 [get_ports TD_HS]
#set_input_delay -min -clock tv_27m 2.454 [get_ports TD_HS]
#set_input_delay -max -clock tv_27m 3.656 [get_ports TD_VS]
#set_input_delay -min -clock tv_27m 2.456 [get_ports TD_VS]

#**************************************************************
# Set Output Delay
#**************************************************************
## max : Board Delay (Data) - Board Delay (Clock) + tsu (External Device)
## min : Board Delay (Data) - Board Delay (Clock) - th (External Device)

set_output_delay -clock FSYNCclk -max 0  [get_ports GPIO_0[3]]
set_output_delay -clock FSYNCclk -min 0  [get_ports GPIO_0[3]]
set_output_delay -clock LSYNCclk -max 0  [get_ports GPIO_0[5]]
set_output_delay -clock LSYNCclk -min 0  [get_ports GPIO_0[5]]
set_output_delay -clock DATAclk  -max 0  [get_ports GPIO_0[7]]
set_output_delay -clock DATAclk  -min 0  [get_ports GPIO_0[7]]
set_output_delay -clock CLKclk   -max 0  [get_ports GPIO_0[9]]
set_output_delay -clock CLKclk   -min 0  [get_ports GPIO_0[9]]
set_output_delay -clock CNVTclk  -max 0  [get_ports GPIO_0[11]]
set_output_delay -clock CNVTclk  -min 0  [get_ports GPIO_0[11]]
set_output_delay -clock SYNCclk  -max 0  [get_ports GPIO_0[13]]
set_output_delay -clock SYNCclk  -min 0  [get_ports GPIO_0[13]]


#set_output_delay -clock MASTERclk -max 0  [get_ports GPIO_0[3]]
#set_output_delay -clock MASTERclk -min 0  [get_ports GPIO_0[3]]
#set_output_delay -clock MASTERclk -max 0  [get_ports GPIO_0[5]]
#set_output_delay -clock MASTERclk -min 0  [get_ports GPIO_0[5]]
#set_output_delay -clock MASTERclk -max 0  [get_ports GPIO_0[7]]
#set_output_delay -clock MASTERclk -min 0  [get_ports GPIO_0[7]]
#set_output_delay -clock MASTERclk -max 0  [get_ports GPIO_0[9]]
#set_output_delay -clock MASTERclk -min 0  [get_ports GPIO_0[9]]
#set_output_delay -clock MASTERclk -max 0  [get_ports GPIO_0[11]]
#set_output_delay -clock MASTERclk -min 0  [get_ports GPIO_0[11]]
#set_output_delay -clock MASTERclk -max 0  [get_ports GPIO_0[13]]
#set_output_delay -clock MASTERclk -min 0  [get_ports GPIO_0[13]]


#**************************************************************
# Set Clock Groups
#**************************************************************
set_clock_groups -asynchronous -group { comb_83|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk
 FSYNCclk LSYNCclk DATAclk CLKclk CNVTclk SYNCclk }
# set_clock_groups -asynchronous -group {fastclock_virt GPIO_0[3] GPIO_0[5] GPIO_0[7] GPIO_0[9] GPIO_0[11] GPIO_0[13] }
#-group{ fastclock }



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



#**************************************************************
# Set Load
#**************************************************************



