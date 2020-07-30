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
    input wire [3:0] button,
    output wire [15:0] led,
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b,
    output wire hs,
    output wire vs
    );

wire [15:0] ledwire;
wire [10:0] pallete_position_wire;
wire [11:0] rgbwire;
wire vsync, hsync;

wire pclk, clk100mhz, locked;  

clk_wiz_0 my_clk (
.clk(clk), .reset(1'b0),
.clk_out_100MHz(clk100mhz), .clk_out_65MHz(pclk), .locked(locked)
);

vga_example my_vga_example (
.clk_in(pclk), .pallete_position(pallete_position_wire),
.vs_out(vsync), .hs_out(hsync), .rgb_out(rgbwire)
);

design_1_wrapper my_design_wrapper (
.clk_in1(clk100mhz), .gpio_io_i(button), .reset(1'b0),
.gpio2_io_o({ledwire, pallete_position_wire})
);

assign led = ledwire;
assign {hs, vs} = {hsync, vsync};
assign {r,g,b} = rgbwire;

endmodule
