`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2020 21:51:22
// Design Name: 
// Module Name: draw_palletes
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


module draw_palletes(
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] pallete_position,
    input wire pclk,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out
    );

localparam PALLETE_LENGTH = 100;
localparam PALLETE_WIDTH = 10;

  always @(posedge pclk)
  begin
    //during blanking make it black
    if (vblnk_in || hblnk_in) rgb_out <= 12'h0_0_0; 
    else
    begin
      if( (vcount_in > pallete_position - PALLETE_LENGTH) && (vcount_in < pallete_position + PALLETE_LENGTH) && (hcount_in < PALLETE_WIDTH) ) rgb_out <= 12'h0_0_0;
      else rgb_out <= 12'hF_F_F;    
    end
    // Just pass these through.
    hsync_out <= hsync_in;
    vsync_out <= vsync_in;
    hblnk_out <= hblnk_in;
    vblnk_out <= vblnk_in;
    hcount_out <= hcount_in;
    vcount_out <= vcount_in;

  end
  
endmodule