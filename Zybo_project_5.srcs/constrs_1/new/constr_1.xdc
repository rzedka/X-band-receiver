set_property PACKAGE_PIN K17 [get_ports sysclk]
set_property PACKAGE_PIN G14 [get_ports PLL_locked_o]
set_property PACKAGE_PIN G15 [get_ports arstn]
set_property PACKAGE_PIN W8 [get_ports data_en_o]
#set_property PACKAGE_PIN Y7 [get_ports peak_det_o]



set_property IOSTANDARD LVCMOS33 [get_ports arstn]
set_property IOSTANDARD LVCMOS33 [get_ports PLL_locked_o]
set_property IOSTANDARD LVCMOS33 [get_ports sysclk]
set_property IOSTANDARD LVCMOS33 [get_ports data_en_o]
set_property IOSTANDARD LVCMOS33 [get_ports data_o]
#set_property IOSTANDARD LVCMOS33 [get_ports peak_det_o]

set_property PACKAGE_PIN V7 [get_ports peak_toggle_o]
set_property IOSTANDARD LVCMOS33 [get_ports peak_toggle_o]

set_property PACKAGE_PIN D18 [get_ports peak_det_LED_o]
set_property IOSTANDARD LVCMOS33 [get_ports peak_det_LED_o]

set_property IOSTANDARD LVCMOS33 [get_ports rd_clk_o]

set_property PACKAGE_PIN V8 [get_ports data_o]
set_property PACKAGE_PIN U7 [get_ports rd_clk_o]
set_property PACKAGE_PIN Y7 [get_ports header_o]
set_property PACKAGE_PIN Y6 [get_ports header_en_o]
set_property IOSTANDARD LVCMOS33 [get_ports header_o]
set_property IOSTANDARD LVCMOS33 [get_ports header_en_o]
set_property PACKAGE_PIN V6 [get_ports header_clk_o]
set_property IOSTANDARD LVCMOS33 [get_ports header_clk_o]
