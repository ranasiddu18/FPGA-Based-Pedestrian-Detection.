 ## CLOCK
set_property -dict { PACKAGE_PIN N11 IOSTANDARD LVCMOS33 } [get_ports clk];
create_clock -period 10.000 [get_ports clk];

## LED
set_property -dict { PACKAGE_PIN J3 IOSTANDARD LVCMOS33 } [get_ports detected];

## SCCB
set_property -dict { PACKAGE_PIN M16 IOSTANDARD LVCMOS33 } [get_ports ov7670_sioc];
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports ov7670_siod];

set_property PULLUP true [get_ports ov7670_siod]
set_property PULLUP true [get_ports ov7670_sioc]

## SYNC
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports ov7670_vsync];
set_property -dict { PACKAGE_PIN P16 IOSTANDARD LVCMOS33 } [get_ports ov7670_href];

## PCLK (NO CLOCK CONSTRAINT HERE)
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports ov7670_pclk];

## XCLK
set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports ov7670_xclk];

## DATA
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[7]}];
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[6]}];
set_property -dict { PACKAGE_PIN N13 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[5]}];
set_property -dict { PACKAGE_PIN P13 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[4]}];
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[3]}];
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[2]}];
set_property -dict { PACKAGE_PIN P10 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[1]}];
set_property -dict { PACKAGE_PIN P11 IOSTANDARD LVCMOS33 } [get_ports {ov7670_data[0]}];

## CONTROL
set_property -dict { PACKAGE_PIN R12 IOSTANDARD LVCMOS33 } [get_ports ov7670_reset];
set_property -dict { PACKAGE_PIN T12 IOSTANDARD LVCMOS33 } [get_ports ov7670_pwdn];
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ov7670_pclk_IBUF]