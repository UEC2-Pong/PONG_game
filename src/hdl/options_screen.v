`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2020 18:38:37
// Design Name: 
// Module Name: options_screen
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


module options_screen(
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [1:0] icon_highlighter,
    input wire [1:0] speed_selector,
    input wire pclk,
    
    //output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    //output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out
    );

localparam SCREEN_WIDTH = 1024;
localparam HALF_SCREEN_WIDTH = 512;
localparam SCREEN_LENGTH = 768;
localparam HALF_SCREEN_LENGTH = 384;
localparam TITLE    = 20;
localparam SUBTITLE = 15;
localparam SQUARE   = 10;
localparam OP_V = 139;
localparam OP_H = 172;
localparam GS_V = 353;
localparam GS_H = 152;
localparam FA_V = 478;
localparam FA_H = 412;
localparam ME_V = 558;
localparam ME_H = 362;
localparam SL_V = 638;
localparam SL_H = 412;

  always @(posedge pclk)
  begin
    //during blanking make it black
    if (vblnk_in || hblnk_in) rgb_out <= 12'h0_0_0;
    else
    begin
      //O
      if     ( (hcount_in >= OP_H) && (hcount_in <= OP_H + TITLE) && (vcount_in >= OP_V + TITLE) && (vcount_in <= OP_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 3*TITLE) && (hcount_in <= OP_H + 4*TITLE) && (vcount_in >= OP_V + TITLE) && (vcount_in <= OP_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + TITLE) && (hcount_in <= OP_H + 3*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + TITLE) && (hcount_in <= OP_H + 3*TITLE) && (vcount_in >= OP_V + 4*TITLE) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      //P
      else if( (hcount_in >= OP_H + 5*TITLE) && (hcount_in <= OP_H + 5*TITLE + 3*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 5*TITLE) && (hcount_in <= OP_H + 5*TITLE + TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 5*TITLE) && (hcount_in <= OP_H + 5*TITLE + 3*TITLE) && (vcount_in >= OP_V + 2*TITLE) && (vcount_in <= OP_V + 3*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 5*TITLE + 3*TITLE) && (hcount_in <= OP_H + 5*TITLE + 4*TITLE) && (vcount_in >= OP_V + TITLE) && (vcount_in <= OP_V + 2*TITLE) ) rgb_out <= 12'hF_F_F;
      //T
      else if( (hcount_in >= OP_H + 10*TITLE) && (hcount_in <= OP_H + 10*TITLE + 5*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 10*TITLE + 2*TITLE) && (hcount_in <= OP_H + 10*TITLE + 3*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      //I  
      else if( (hcount_in >= OP_H + 16*TITLE) && (hcount_in <= OP_H + 16*TITLE + 3*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 16*TITLE + TITLE) && (hcount_in <= OP_H + 16*TITLE + 2*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 16*TITLE) && (hcount_in <= OP_H + 16*TITLE + 3*TITLE) && (vcount_in >= OP_V + 4*TITLE) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      //O
      else if( (hcount_in >= OP_H + 20*TITLE) && (hcount_in <= OP_H + 20*TITLE + TITLE) && (vcount_in >= OP_V + TITLE) && (vcount_in <= OP_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 20*TITLE + 3*TITLE) && (hcount_in <= OP_H + 20*TITLE + 4*TITLE) && (vcount_in >= OP_V + TITLE) && (vcount_in <= OP_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 20*TITLE + TITLE) && (hcount_in <= OP_H + 20*TITLE + 3*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 20*TITLE + TITLE) && (hcount_in <= OP_H + 20*TITLE + 3*TITLE) && (vcount_in >= OP_V + 4*TITLE) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      //N
      else if( (hcount_in >= OP_H + 25*TITLE) && (hcount_in <= OP_H + 25*TITLE + TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 25*TITLE + TITLE) && (hcount_in <= OP_H + 25*TITLE + 2*TITLE) && (vcount_in >= OP_V + TITLE) && (vcount_in <= OP_V + 2*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 25*TITLE + 2*TITLE) && (hcount_in <= OP_H + 25*TITLE + 3*TITLE) && (vcount_in >= OP_V + 2*TITLE) && (vcount_in <= OP_V + 3*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 25*TITLE + 3*TITLE) && (hcount_in <= OP_H + 25*TITLE + 4*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      //S
      else if( (hcount_in >= OP_H + 30*TITLE + TITLE) && (hcount_in <= OP_H + 30*TITLE + 4*TITLE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 30*TITLE) && (hcount_in <= OP_H + 30*TITLE + TITLE) && (vcount_in >= OP_V + TITLE) && (vcount_in <= OP_V + 2*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 30*TITLE + TITLE) && (hcount_in <= OP_H + 30*TITLE + 3*TITLE) && (vcount_in >= OP_V + 2*TITLE) && (vcount_in <= OP_V + 3*TITLE ) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 30*TITLE + 3*TITLE) && (hcount_in <= OP_H + 30*TITLE + 4*TITLE) && (vcount_in >= OP_V + 3*TITLE) && (vcount_in <= OP_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= OP_H + 30*TITLE) && (hcount_in <= OP_H + 30*TITLE + 3*TITLE) && (vcount_in >= OP_V + 4*TITLE) && (vcount_in <= OP_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      //G
      else if( (hcount_in >= GS_H + SUBTITLE) && (hcount_in <= GS_H + 3*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H) && (hcount_in <= GS_H + SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 4*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + SUBTITLE) && (hcount_in <= GS_H + 3*SUBTITLE) && (vcount_in >= GS_V + 4*SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 3*SUBTITLE) && (hcount_in <= GS_H + 4*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 4*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 2*SUBTITLE) && (hcount_in <= GS_H + 3*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 3*SUBTITLE) ) rgb_out <= 12'hF_F_F; 
      //A
      else if( (hcount_in >= GS_H + 5*SUBTITLE + SUBTITLE) && (hcount_in <= GS_H + 5*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 5*SUBTITLE) && (hcount_in <= GS_H + 5*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 5*SUBTITLE + 3*SUBTITLE) && (hcount_in <= GS_H + 5*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 5*SUBTITLE + SUBTITLE) && (hcount_in <= GS_H + 5*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 3*SUBTITLE) && (vcount_in <= GS_V + 4*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //M
      else if( (hcount_in >= GS_H + 10*SUBTITLE) && (hcount_in <= GS_H + 10*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 10*SUBTITLE + 4*SUBTITLE) && (hcount_in <= GS_H + 10*SUBTITLE + 5*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 10*SUBTITLE + SUBTITLE) && (hcount_in <= GS_H + 10*SUBTITLE + 2*SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 2*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 10*SUBTITLE + 2*SUBTITLE) && (hcount_in <= GS_H + 10*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 3*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 10*SUBTITLE + 3*SUBTITLE) && (hcount_in <= GS_H + 10*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 2*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //E
      else if( (hcount_in >= GS_H + 16*SUBTITLE) && (hcount_in <= GS_H + 16*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 16*SUBTITLE) && (hcount_in <= GS_H + 16*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 3*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 16*SUBTITLE) && (hcount_in <= GS_H + 16*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + 4*SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 16*SUBTITLE) && (hcount_in <= GS_H + 16*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      //S
      else if( (hcount_in >= GS_H + 24*SUBTITLE + SUBTITLE) && (hcount_in <= GS_H + 24*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 24*SUBTITLE) && (hcount_in <= GS_H + 24*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 2*SUBTITLE ) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 24*SUBTITLE + SUBTITLE) && (hcount_in <= GS_H + 24*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 3*SUBTITLE ) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 24*SUBTITLE + 3*SUBTITLE) && (hcount_in <= GS_H + 24*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + 3*SUBTITLE) && (vcount_in <= GS_V + 4*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 24*SUBTITLE) && (hcount_in <= GS_H + 24*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 4*SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //P
      else if( (hcount_in >= GS_H + 29*SUBTITLE) && (hcount_in <= GS_H + 29*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 29*SUBTITLE) && (hcount_in <= GS_H + 29*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 29*SUBTITLE) && (hcount_in <= GS_H + 29*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 3*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 29*SUBTITLE + 3*SUBTITLE) && (hcount_in <= GS_H + 29*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 2*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //E
      else if( (hcount_in >= GS_H + 34*SUBTITLE) && (hcount_in <= GS_H + 34*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 34*SUBTITLE) && (hcount_in <= GS_H + 34*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 3*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 34*SUBTITLE) && (hcount_in <= GS_H + 34*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + 4*SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 34*SUBTITLE) && (hcount_in <= GS_H + 34*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //E
      else if( (hcount_in >= GS_H + 39*SUBTITLE) && (hcount_in <= GS_H + 39*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 39*SUBTITLE) && (hcount_in <= GS_H + 39*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 2*SUBTITLE) && (vcount_in <= GS_V + 3*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 39*SUBTITLE) && (hcount_in <= GS_H + 39*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + 4*SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 39*SUBTITLE) && (hcount_in <= GS_H + 39*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //D
      else if( (hcount_in >= GS_H + 44*SUBTITLE) && (hcount_in <= GS_H + 44*SUBTITLE + SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 44*SUBTITLE) && (hcount_in <= GS_H + 44*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V) && (vcount_in <= GS_V + SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 44*SUBTITLE) && (hcount_in <= GS_H + 44*SUBTITLE + 3*SUBTITLE) && (vcount_in >= GS_V + 4*SUBTITLE) && (vcount_in <= GS_V + 5*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= GS_H + 44*SUBTITLE + 3*SUBTITLE) && (hcount_in <= GS_H + 44*SUBTITLE + 4*SUBTITLE) && (vcount_in >= GS_V + SUBTITLE) && (vcount_in <= GS_V + 4*SUBTITLE) ) rgb_out <= 12'hF_F_F;
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      //F
      else if( (hcount_in >= FA_H) && (hcount_in <= FA_H + 4*SQUARE) && (vcount_in >= FA_V) && (vcount_in <= FA_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H) && (hcount_in <= FA_H + 3*SQUARE) && (vcount_in >= FA_V + 2*SQUARE) && (vcount_in <= FA_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H) && (hcount_in <= FA_H + SQUARE) && (vcount_in >= FA_V) && (vcount_in <= FA_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //A
      else if( (hcount_in >= FA_H + 5*SQUARE + SQUARE) && (hcount_in <= FA_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= FA_V) && (vcount_in <= FA_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 5*SQUARE) && (hcount_in <= FA_H + 5*SQUARE + SQUARE) && (vcount_in >= FA_V + SQUARE) && (vcount_in <= FA_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 5*SQUARE + 3*SQUARE) && (hcount_in <= FA_H + 5*SQUARE + 4*SQUARE) && (vcount_in >= FA_V + SQUARE) && (vcount_in <= FA_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 5*SQUARE + SQUARE) && (hcount_in <= FA_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= FA_V + 3*SQUARE) && (vcount_in <= FA_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      //S
      else if( (hcount_in >= FA_H + 10*SQUARE + SQUARE) && (hcount_in <= FA_H + 10*SQUARE + 4*SQUARE) && (vcount_in >= FA_V) && (vcount_in <= FA_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 10*SQUARE) && (hcount_in <= FA_H + 10*SQUARE + SQUARE) && (vcount_in >= FA_V + SQUARE) && (vcount_in <= FA_V + 2*SQUARE ) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 10*SQUARE + SQUARE) && (hcount_in <= FA_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= FA_V + 2*SQUARE) && (vcount_in <= FA_V + 3*SQUARE ) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 10*SQUARE + 3*SQUARE) && (hcount_in <= FA_H + 10*SQUARE + 4*SQUARE) && (vcount_in >= FA_V + 3*SQUARE) && (vcount_in <= FA_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 10*SQUARE) && (hcount_in <= FA_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= FA_V + 4*SQUARE) && (vcount_in <= FA_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //T
      else if( (hcount_in >= FA_H + 15*SQUARE) && (hcount_in <= FA_H + 15*SQUARE + 5*SQUARE) && (vcount_in >= FA_V) && (vcount_in <= FA_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= FA_H + 15*SQUARE + 2*SQUARE) && (hcount_in <= FA_H + 15*SQUARE + 3*SQUARE) && (vcount_in >= FA_V) && (vcount_in <= FA_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      //M
      else if( (hcount_in >= ME_H) && (hcount_in <= ME_H + SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 4*SQUARE) && (hcount_in <= ME_H + 5*SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + SQUARE) && (hcount_in <= ME_H + 2*SQUARE) && (vcount_in >= ME_V + SQUARE) && (vcount_in <= ME_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 2*SQUARE) && (hcount_in <= ME_H + 3*SQUARE) && (vcount_in >= ME_V + 2*SQUARE) && (vcount_in <= ME_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 3*SQUARE) && (hcount_in <= ME_H + 4*SQUARE) && (vcount_in >= ME_V + SQUARE) && (vcount_in <= ME_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      //E
      else if( (hcount_in >= ME_H + 6*SQUARE) && (hcount_in <= ME_H + 6*SQUARE + 4*SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 6*SQUARE) && (hcount_in <= ME_H + 6*SQUARE + 3*SQUARE) && (vcount_in >= ME_V + 2*SQUARE) && (vcount_in <= ME_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 6*SQUARE) && (hcount_in <= ME_H + 6*SQUARE + 4*SQUARE) && (vcount_in >= ME_V + 4*SQUARE) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 6*SQUARE) && (hcount_in <= ME_H + 6*SQUARE + SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //D
      else if( (hcount_in >= ME_H + 11*SQUARE) && (hcount_in <= ME_H + 11*SQUARE + SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 11*SQUARE) && (hcount_in <= ME_H + 11*SQUARE + 3*SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 11*SQUARE) && (hcount_in <= ME_H + 11*SQUARE + 3*SQUARE) && (vcount_in >= ME_V + 4*SQUARE) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 11*SQUARE + 3*SQUARE) && (hcount_in <= ME_H + 11*SQUARE + 4*SQUARE) && (vcount_in >= ME_V + SQUARE) && (vcount_in <= ME_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      //I  
      else if( (hcount_in >= ME_H + 16*SQUARE) && (hcount_in <= ME_H + 16*SQUARE + 3*SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 16*SQUARE + SQUARE) && (hcount_in <= ME_H + 16*SQUARE + 2*SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 16*SQUARE) && (hcount_in <= ME_H + 16*SQUARE + 3*SQUARE) && (vcount_in >= ME_V + 4*SQUARE) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //U
      else if( (hcount_in >= ME_H + 20*SQUARE) && (hcount_in <= ME_H + 20*SQUARE + SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 20*SQUARE + 3*SQUARE) && (hcount_in <= ME_H + 20*SQUARE + 4*SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 20*SQUARE + SQUARE) && (hcount_in <= ME_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= ME_V + 4*SQUARE) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
      //M
      else if( (hcount_in >= ME_H + 25*SQUARE) && (hcount_in <= ME_H + 25*SQUARE + SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 25*SQUARE + 4*SQUARE) && (hcount_in <= ME_H + 25*SQUARE + 5*SQUARE) && (vcount_in >= ME_V) && (vcount_in <= ME_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 25*SQUARE + SQUARE) && (hcount_in <= ME_H + 25*SQUARE + 2*SQUARE) && (vcount_in >= ME_V + SQUARE) && (vcount_in <= ME_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 25*SQUARE + 2*SQUARE) && (hcount_in <= ME_H + 25*SQUARE + 3*SQUARE) && (vcount_in >= ME_V + 2*SQUARE) && (vcount_in <= ME_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= ME_H + 25*SQUARE + 3*SQUARE) && (hcount_in <= ME_H + 25*SQUARE + 4*SQUARE) && (vcount_in >= ME_V + SQUARE) && (vcount_in <= ME_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;      
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      //S
      else if( (hcount_in >= SL_H + SQUARE) && (hcount_in <= SL_H + 4*SQUARE) && (vcount_in >= SL_V) && (vcount_in <= SL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H) && (hcount_in <= SL_H + SQUARE) && (vcount_in >= SL_V + SQUARE) && (vcount_in <= SL_V + 2*SQUARE ) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + SQUARE) && (hcount_in <= SL_H + 3*SQUARE) && (vcount_in >= SL_V + 2*SQUARE) && (vcount_in <= SL_V + 3*SQUARE ) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 3*SQUARE) && (hcount_in <= SL_H + 4*SQUARE) && (vcount_in >= SL_V + 3*SQUARE) && (vcount_in <= SL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H) && (hcount_in <= SL_H + 3*SQUARE) && (vcount_in >= SL_V + 4*SQUARE) && (vcount_in <= SL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //L
      else if( (hcount_in >= SL_H + 5*SQUARE) && (hcount_in <= SL_H + 5*SQUARE + SQUARE) && (vcount_in >= SL_V) && (vcount_in <= SL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
      else if( (hcount_in >= SL_H + 5*SQUARE) && (hcount_in <= SL_H + 5*SQUARE + 4*SQUARE) && (vcount_in >= SL_V + 4*SQUARE) && (vcount_in <= SL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
      //O
      else if( (hcount_in >= SL_H + 10*SQUARE) && (hcount_in <= SL_H + 10*SQUARE + SQUARE) && (vcount_in >= SL_V + SQUARE) && (vcount_in <= SL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 10*SQUARE + 3*SQUARE) && (hcount_in <= SL_H + 10*SQUARE + 4*SQUARE) && (vcount_in >= SL_V + SQUARE) && (vcount_in <= SL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 10*SQUARE + SQUARE) && (hcount_in <= SL_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= SL_V) && (vcount_in <= SL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 10*SQUARE + SQUARE) && (hcount_in <= SL_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= SL_V + 4*SQUARE) && (vcount_in <= SL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //W
      else if( (hcount_in >= SL_H + 15*SQUARE) && (hcount_in <= SL_H + 15*SQUARE + SQUARE) && (vcount_in >= SL_V) && (vcount_in <= SL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 15*SQUARE + 2*SQUARE) && (hcount_in <= SL_H + 15*SQUARE + 3*SQUARE) && (vcount_in >= SL_V) && (vcount_in <= SL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 15*SQUARE + 4*SQUARE) && (hcount_in <= SL_H + 15*SQUARE + 5*SQUARE) && (vcount_in >= SL_V) && (vcount_in <= SL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 15*SQUARE + 1*SQUARE) && (hcount_in <= SL_H + 15*SQUARE + 2*SQUARE) && (vcount_in >= SL_V + 4*SQUARE) && (vcount_in <= SL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (hcount_in >= SL_H + 15*SQUARE + 3*SQUARE) && (hcount_in <= SL_H + 15*SQUARE + 4*SQUARE) && (vcount_in >= SL_V + 4*SQUARE) && (vcount_in <= SL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      //lewa i prawa górna pionowa
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H - 2*SQUARE) && (hcount_in <= FA_H - 1*SQUARE) && (vcount_in >= FA_V - 2*SQUARE) && (vcount_in <= FA_V) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H + 20*SQUARE + SQUARE) && (hcount_in <= FA_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= FA_V - 2*SQUARE) && (vcount_in <= FA_V) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H - 2*SQUARE) && (hcount_in <= ME_H - 1*SQUARE) && (vcount_in >= ME_V - 2*SQUARE) && (vcount_in <= ME_V) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H + 30*SQUARE + SQUARE) && (hcount_in <= ME_H + 30*SQUARE + 2*SQUARE) && (vcount_in >= ME_V - 2*SQUARE) && (vcount_in <= ME_V) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H - 2*SQUARE) && (hcount_in <= SL_H - 1*SQUARE) && (vcount_in >= SL_V - 2*SQUARE) && (vcount_in <= SL_V) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H + 20*SQUARE + SQUARE) && (hcount_in <= SL_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= SL_V - 2*SQUARE) && (vcount_in <= SL_V) ) rgb_out <= 12'hF_F_F;
      
      //lewa i prawa dolna pionowa
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H - 2*SQUARE) && (hcount_in <= FA_H - 1*SQUARE) && (vcount_in >= FA_V + 5*SQUARE) && (vcount_in <= FA_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H + 20*SQUARE + SQUARE) && (hcount_in <= FA_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= FA_V + 5*SQUARE) && (vcount_in <= FA_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H - 2*SQUARE) && (hcount_in <= ME_H - 1*SQUARE) && (vcount_in >= ME_V + 5*SQUARE) && (vcount_in <= ME_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H + 30*SQUARE + SQUARE) && (hcount_in <= ME_H + 30*SQUARE + 2*SQUARE) && (vcount_in >= ME_V + 5*SQUARE) && (vcount_in <= ME_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H - 2*SQUARE) && (hcount_in <= SL_H - 1*SQUARE) && (vcount_in >= SL_V + 5*SQUARE) && (vcount_in <= SL_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H + 20*SQUARE + SQUARE) && (hcount_in <= SL_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= SL_V + 5*SQUARE) && (vcount_in <= SL_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      
      //lewa i prawa górna pozioma
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H - 2*SQUARE) && (hcount_in <= FA_H) && (vcount_in >= FA_V - 2*SQUARE) && (vcount_in <= FA_V - 1*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H + 20*SQUARE) && (hcount_in <= FA_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= FA_V - 2*SQUARE) && (vcount_in <= FA_V - 1*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H - 2*SQUARE) && (hcount_in <= ME_H) && (vcount_in >= ME_V - 2*SQUARE) && (vcount_in <= ME_V - 1*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H + 30*SQUARE) && (hcount_in <= ME_H + 30*SQUARE + 2*SQUARE) && (vcount_in >= ME_V - 2*SQUARE) && (vcount_in <= ME_V - 1*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H - 2*SQUARE) && (hcount_in <= SL_H) && (vcount_in >= SL_V - 2*SQUARE) && (vcount_in <= SL_V - 1*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H + 20*SQUARE) && (hcount_in <= SL_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= SL_V - 2*SQUARE) && (vcount_in <= SL_V - 1*SQUARE) ) rgb_out <= 12'hF_F_F;
      
      //lewa i prawa dolna pozioma
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H - 2*SQUARE) && (hcount_in <= FA_H) && (vcount_in >= FA_V + 5*SQUARE + SQUARE) && (vcount_in <= FA_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b00) && (hcount_in >= FA_H + 20*SQUARE) && (hcount_in <= FA_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= FA_V + 5*SQUARE + SQUARE) && (vcount_in <= FA_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H - 2*SQUARE) && (hcount_in <= ME_H) && (vcount_in >= ME_V + 5*SQUARE + SQUARE) && (vcount_in <= ME_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b01) && (hcount_in >= ME_H + 30*SQUARE) && (hcount_in <= ME_H + 30*SQUARE + 2*SQUARE) && (vcount_in >= ME_V + 5*SQUARE + SQUARE) && (vcount_in <= ME_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H - 2*SQUARE) && (hcount_in <= SL_H) && (vcount_in >= SL_V + 5*SQUARE + SQUARE) && (vcount_in <= SL_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (speed_selector == 2'b10) && (hcount_in >= SL_H + 20*SQUARE) && (hcount_in <= SL_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= SL_V + 5*SQUARE + SQUARE) && (vcount_in <= SL_V + 5*SQUARE + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
                             
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      else if( (icon_highlighter == 2'b00) && (hcount_in >= FA_H - 3*SQUARE) && (hcount_in <= FA_H - 2*SQUARE) && (vcount_in >= FA_V + 2*SQUARE) && (vcount_in <= FA_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (icon_highlighter == 2'b00) && (hcount_in >= FA_H + 20*SQUARE + 2*SQUARE) && (hcount_in <= FA_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= FA_V + 2*SQUARE) && (vcount_in <= FA_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (icon_highlighter == 2'b01) && (hcount_in >= ME_H - 3*SQUARE) && (hcount_in <= ME_H - 2*SQUARE) && (vcount_in >= ME_V + 2*SQUARE) && (vcount_in <= ME_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (icon_highlighter == 2'b01) && (hcount_in >= ME_H + 30*SQUARE + 2*SQUARE) && (hcount_in <= ME_H + 30*SQUARE + 3*SQUARE) && (vcount_in >= ME_V + 2*SQUARE) && (vcount_in <= ME_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (icon_highlighter == 2'b10) && (hcount_in >= SL_H - 3*SQUARE) && (hcount_in <= SL_H - 2*SQUARE) && (vcount_in >= SL_V + 2*SQUARE) && (vcount_in <= SL_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
      else if( (icon_highlighter == 2'b10) && (hcount_in >= SL_H + 20*SQUARE + 2*SQUARE) && (hcount_in <= SL_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= SL_V + 2*SQUARE) && (vcount_in <= SL_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;     
      //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      else rgb_out <= 12'h0_0_0;    
    end
    // Just pass these through.
    hsync_out <= hsync_in;
    vsync_out <= vsync_in;
    hblnk_out <= hblnk_in;
    vblnk_out <= vblnk_in;
    //hcount_out <= hcount_in;
    //vcount_out <= vcount_in;

  end
endmodule
