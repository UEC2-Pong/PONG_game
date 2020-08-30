# Constraints for CLK
#set_property PACKAGE_PIN W5 [get_ports clk]
#set_property IOSTANDARD LVCMOS33 [get_ports clk]
#create_clock -name external_clock -period 10.00 [get_ports clk]
      
# USB UART
    set_property PACKAGE_PIN B18 [get_ports {usb_uart_rxd}]
	   set_property IOSTANDARD LVCMOS33 [get_ports {usb_uart_rxd}]
    set_property PACKAGE_PIN A18 [get_ports {usb_uart_txd}]
	   set_property IOSTANDARD LVCMOS33 [get_ports {usb_uart_txd}]