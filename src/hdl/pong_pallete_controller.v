`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2020 19:25:31
// Design Name: 
// Module Name: pong_pallete_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pong_pallete_controller(
    input wire clk,
    input wire rst,
    input wire usb_uart_rxd,
    
    output wire usb_uart_txd,
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b,
    output wire hs,
    output wire vs
    );

wire [1:0]  game_speed_wire;
wire [2:0]  screen_mode_wire;
wire [7:0]  score_wire;
wire [1:0]  icon_highlighter_wire;
wire [10:0] left_palette_pos_wire;
wire [10:0] right_palette_pos_wire;
wire [10:0] ball_xpos_wire;
wire [10:0] ball_ypos_wire;
wire [11:0] rgbwire;
wire vsync, hsync;

wire pclk, clk100mhz, locked;  

clk_wiz_0 my_clk (
.clk(clk), .reset(rst),
.clk_out_100MHz(clk100mhz), .clk_out_65MHz(pclk), .locked(locked)
);

vga_example my_vga_example (
.clk_in(pclk), .rst(rst), .screen_mode(screen_mode_wire), .icon_highlighter(icon_highlighter_wire),
.speed_selector(game_speed_wire),
.left_palette_pos(left_palette_pos_wire), .right_palette_pos(right_palette_pos_wire),
.ball_xpos(ball_xpos_wire), .ball_ypos(ball_ypos_wire), .score(score_wire),
.vs_out(vsync), .hs_out(hsync), .rgb_out(rgbwire)
);

design_1_wrapper my_design_wrapper (
.clk_in1(clk100mhz), .gpio_io_o({screen_mode_wire, icon_highlighter_wire, game_speed_wire, 3'b000, ball_ypos_wire, ball_xpos_wire}), .reset(rst),
.gpio2_io_o({2'b00, score_wire, left_palette_pos_wire, right_palette_pos_wire}),
.usb_uart_rxd(usb_uart_rxd), .usb_uart_txd(usb_uart_txd)
);

assign {hs, vs} = {hsync, vsync};
assign {r,g,b} = rgbwire;

endmodule
