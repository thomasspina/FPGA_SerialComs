## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets sw_IBUF[0]]


## Switches
set_property PACKAGE_PIN V17 [get_ports {sw}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {led}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led}]

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports RsRx]
	set_property IOSTANDARD LVCMOS33 [get_ports RsRx]
set_property PACKAGE_PIN A18 [get_ports RsTx]
	set_property IOSTANDARD LVCMOS33 [get_ports RsTx]
	
## Configuration options,
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]