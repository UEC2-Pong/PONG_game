//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
//Date        : Sun Aug 30 17:50:35 2020
//Host        : DESKTOP-8JR4U8F running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk_in1,
    gpio2_io_o,
    gpio_io_o,
    reset,
    reset_0,
    usb_uart_rxd,
    usb_uart_txd);
  input clk_in1;
  output [31:0]gpio2_io_o;
  output [31:0]gpio_io_o;
  input reset;
  input reset_0;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire clk_in1;
  wire [31:0]gpio2_io_o;
  wire [31:0]gpio_io_o;
  wire reset;
  wire reset_0;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  design_1 design_1_i
       (.clk_in1(clk_in1),
        .gpio2_io_o(gpio2_io_o),
        .gpio_io_o(gpio_io_o),
        .reset(reset),
        .reset_0(reset_0),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
