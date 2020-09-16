`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2020 17:07:12
// Design Name: 
// Module Name: menu_screen
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


module menu_screen(
    input wire pclk,
    input wire rst,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [1:0] icon_highlighter,
    
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
localparam HALF_SCREEN_LENGTH = 384;
localparam SQUARE = 10;
localparam LARGE  = 50;
localparam PO_V = 74;
localparam PO_H = 37;
localparam SP_V = 398;
localparam SP_H = 207;
localparam MP_V = 478;
localparam MP_H = 237;
localparam CR_V = 548;
localparam CR_H = 342;
localparam OP_V = 628;
localparam OP_H = 342;

  always @(posedge pclk) 
  begin
    if(rst)
    begin
        hsync_out <= 1'b0;
        vsync_out <= 1'b0;
        hblnk_out <= 1'b0;
        vblnk_out <= 1'b0;
    end
    
    else
    begin
        //during blanking make it black
        if (vblnk_in || hblnk_in) rgb_out <= 12'h0_0_0; 
        else
        begin  
          //P
          if     ( (hcount_in >= PO_H) && (hcount_in <= PO_H + 3*LARGE) && (vcount_in >= PO_V) && (vcount_in <= PO_V + LARGE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= PO_H) && (hcount_in <= PO_H + LARGE) && (vcount_in >= PO_V) && (vcount_in <= PO_V + 5*LARGE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= PO_H) && (hcount_in <= PO_H + 3*LARGE) && (vcount_in >= PO_V + 2*LARGE) && (vcount_in <= PO_V + 3*LARGE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= PO_H + 3*LARGE) && (hcount_in <= PO_H + 4*LARGE) && (vcount_in >= PO_V + LARGE) && (vcount_in <= PO_V + 2*LARGE) ) rgb_out <= 12'hF_F_F;
          //O
          else if( (hcount_in >= PO_H + 5*LARGE) && (hcount_in <= PO_H + 5*LARGE + LARGE) && (vcount_in >= PO_V + LARGE) && (vcount_in <= PO_V + 4*LARGE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PO_H + 5*LARGE + 3*LARGE) && (hcount_in <= PO_H + 5*LARGE + 4*LARGE) && (vcount_in >= PO_V + LARGE) && (vcount_in <= PO_V + 4*LARGE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PO_H + 5*LARGE + LARGE) && (hcount_in <= PO_H + 5*LARGE + 3*LARGE) && (vcount_in >= PO_V) && (vcount_in <= PO_V + LARGE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PO_H + 5*LARGE + LARGE) && (hcount_in <= PO_H + 5*LARGE + 3*LARGE) && (vcount_in >= PO_V + 4*LARGE) && (vcount_in <= PO_V + 5*LARGE) ) rgb_out <= 12'hF_F_F;
          //N
          else if( (hcount_in >= PO_H + 10*LARGE) && (hcount_in <= PO_H + 10*LARGE  + LARGE) && (vcount_in >= PO_V) && (vcount_in <= PO_V + 5*LARGE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= PO_H + 10*LARGE + LARGE) && (hcount_in <= PO_H + 10*LARGE + 2*LARGE) && (vcount_in >= PO_V + LARGE) && (vcount_in <= PO_V + 2*LARGE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= PO_H + 10*LARGE + 2*LARGE) && (hcount_in <= PO_H + 10*LARGE + 3*LARGE) && (vcount_in >= PO_V + 2*LARGE) && (vcount_in <= PO_V + 3*LARGE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= PO_H + 10*LARGE + 3*LARGE) && (hcount_in <= PO_H + 10*LARGE + 4*LARGE) && (vcount_in >= PO_V) && (vcount_in <= PO_V + 5*LARGE) ) rgb_out <= 12'hF_F_F;
          //G
          else if( (hcount_in >= PO_H + 15*LARGE + LARGE) && (hcount_in <= PO_H + 15*LARGE + 3*LARGE) && (vcount_in >= PO_V) && (vcount_in <= PO_V + LARGE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= PO_H + 15*LARGE) && (hcount_in <= PO_H + 15*LARGE + LARGE) && (vcount_in >= PO_V + LARGE) && (vcount_in <= PO_V + 4*LARGE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= PO_H + 15*LARGE + LARGE) && (hcount_in <= PO_H + 15*LARGE + 3*LARGE) && (vcount_in >= PO_V + 4*LARGE) && (vcount_in <= PO_V + 5*LARGE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= PO_H + 15*LARGE + 3*LARGE) && (hcount_in <= PO_H + 15*LARGE + 4*LARGE) && (vcount_in >= PO_V + 2*LARGE) && (vcount_in <= PO_V + 4*LARGE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= PO_H + 15*LARGE + 2*LARGE) && (hcount_in <= PO_H + 15*LARGE + 3*LARGE) && (vcount_in >= PO_V + 2*LARGE) && (vcount_in <= PO_V + 3*LARGE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //S
          else if( (hcount_in >= SP_H + SQUARE) && (hcount_in <= SP_H + 4*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H) && (hcount_in <= SP_H + SQUARE) && (vcount_in >= SP_V + SQUARE) && (vcount_in <= SP_V + 2*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + SQUARE) && (hcount_in <= SP_H + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 3*SQUARE) && (hcount_in <= SP_H + 4*SQUARE) && (vcount_in >= SP_V + 3*SQUARE) && (vcount_in <= SP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H) && (hcount_in <= SP_H + 3*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //I  
          else if( (hcount_in >= SP_H + 5*SQUARE) && (hcount_in <= SP_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 5*SQUARE + SQUARE) && (hcount_in <= SP_H + 5*SQUARE + 2*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 5*SQUARE) && (hcount_in <= SP_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //N
          else if( (hcount_in >= SP_H + 9*SQUARE) && (hcount_in <= SP_H + 9*SQUARE  + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= SP_H + 9*SQUARE + SQUARE) && (hcount_in <= SP_H + 9*SQUARE + 2*SQUARE) && (vcount_in >= SP_V + SQUARE) && (vcount_in <= SP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= SP_H + 9*SQUARE + 2*SQUARE) && (hcount_in <= SP_H + 9*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= SP_H + 9*SQUARE + 3*SQUARE) && (hcount_in <= SP_H + 9*SQUARE + 4*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          //G
          else if( (hcount_in >= SP_H + 14*SQUARE + SQUARE) && (hcount_in <= SP_H + 14*SQUARE + 3*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 14*SQUARE) && (hcount_in <= SP_H + 14*SQUARE + SQUARE) && (vcount_in >= SP_V + SQUARE) && (vcount_in <= SP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= SP_H + 14*SQUARE + SQUARE) && (hcount_in <= SP_H + 14*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= SP_H + 14*SQUARE + 3*SQUARE) && (hcount_in <= SP_H + 14*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 14*SQUARE + 2*SQUARE) && (hcount_in <= SP_H + 14*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F; 
          //L
          else if( (hcount_in >= SP_H + 19*SQUARE) && (hcount_in <= SP_H + 19*SQUARE + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 19*SQUARE) && (hcount_in <= SP_H + 19*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;   
          //E
          else if( (hcount_in >= SP_H + 24*SQUARE) && (hcount_in <= SP_H + 24*SQUARE + 4*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 24*SQUARE) && (hcount_in <= SP_H + 24*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 24*SQUARE) && (hcount_in <= SP_H + 24*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 24*SQUARE) && (hcount_in <= SP_H + 24*SQUARE + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          //P
          else if( (hcount_in >= SP_H + 32*SQUARE) && (hcount_in <= SP_H + 32*SQUARE + 3*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 32*SQUARE) && (hcount_in <= SP_H + 32*SQUARE + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 32*SQUARE) && (hcount_in <= SP_H + 32*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 32*SQUARE + 3*SQUARE) && (hcount_in <= SP_H + 32*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + SQUARE) && (vcount_in <= SP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;  
          //L
          else if( (hcount_in >= SP_H + 37*SQUARE) && (hcount_in <= SP_H + 37*SQUARE + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 37*SQUARE) && (hcount_in <= SP_H + 37*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          //A
          else if( (hcount_in >= SP_H + 42*SQUARE + SQUARE) && (hcount_in <= SP_H + 42*SQUARE + 3*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 42*SQUARE) && (hcount_in <= SP_H + 42*SQUARE + SQUARE) && (vcount_in >= SP_V + SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 42*SQUARE + 3*SQUARE) && (hcount_in <= SP_H + 42*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 42*SQUARE + SQUARE) && (hcount_in <= SP_H + 42*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 3*SQUARE) && (vcount_in <= SP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //Y
          else if( (hcount_in >= SP_H + 47*SQUARE) && (hcount_in <= SP_H + 47*SQUARE + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 47*SQUARE) && (hcount_in <= SP_H + 47*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 47*SQUARE + 3*SQUARE) && (hcount_in <= SP_H + 47*SQUARE + 4*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 47*SQUARE + 2*SQUARE) && (hcount_in <= SP_H + 47*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 3*SQUARE) && (vcount_in <= SP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 47*SQUARE + 1*SQUARE) && (hcount_in <= SP_H + 47*SQUARE + 2*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //E
          else if( (hcount_in >= SP_H + 52*SQUARE) && (hcount_in <= SP_H + 52*SQUARE + 4*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 52*SQUARE) && (hcount_in <= SP_H + 52*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 52*SQUARE) && (hcount_in <= SP_H + 52*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + 4*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= SP_H + 52*SQUARE) && (hcount_in <= SP_H + 52*SQUARE + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //R
          else if( (hcount_in >= SP_H + 57*SQUARE) && (hcount_in <= SP_H + 57*SQUARE + SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 57*SQUARE) && (hcount_in <= SP_H + 57*SQUARE + 3*SQUARE) && (vcount_in >= SP_V) && (vcount_in <= SP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 57*SQUARE) && (hcount_in <= SP_H + 57*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 57*SQUARE + 3*SQUARE) && (hcount_in <= SP_H + 57*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + SQUARE) && (vcount_in <= SP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= SP_H + 57*SQUARE + 3*SQUARE) && (hcount_in <= SP_H + 57*SQUARE + 4*SQUARE) && (vcount_in >= SP_V + 3*SQUARE) && (vcount_in <= SP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //M
          else if( (hcount_in >= MP_H) && (hcount_in <= MP_H + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 4*SQUARE) && (hcount_in <= MP_H + 5*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + SQUARE) && (hcount_in <= MP_H + 2*SQUARE) && (vcount_in >= MP_V + SQUARE) && (vcount_in <= MP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 2*SQUARE) && (hcount_in <= MP_H + 3*SQUARE) && (vcount_in >= MP_V + 2*SQUARE) && (vcount_in <= MP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 3*SQUARE) && (hcount_in <= MP_H + 4*SQUARE) && (vcount_in >= MP_V + SQUARE) && (vcount_in <= MP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          //U
          else if( (hcount_in >= MP_H + 6*SQUARE) && (hcount_in <= MP_H + 6*SQUARE + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 6*SQUARE + 3*SQUARE) && (hcount_in <= MP_H + 6*SQUARE + 4*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 6*SQUARE + SQUARE) && (hcount_in <= MP_H + 6*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 4*SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          //L
          else if( (hcount_in >= MP_H + 11*SQUARE) && (hcount_in <= MP_H + 11*SQUARE + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= MP_H + 11*SQUARE) && (hcount_in <= MP_H + 11*SQUARE + 4*SQUARE) && (vcount_in >= MP_V + 4*SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //T
          else if( (hcount_in >= MP_H + 16*SQUARE) && (hcount_in <= MP_H + 16*SQUARE + 5*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 16*SQUARE + 2*SQUARE) && (hcount_in <= MP_H + 16*SQUARE + 3*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //I  
          else if( (hcount_in >= MP_H + 22*SQUARE) && (hcount_in <= MP_H + 22*SQUARE + 3*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 22*SQUARE + SQUARE) && (hcount_in <= MP_H + 22*SQUARE + 2*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 22*SQUARE) && (hcount_in <= MP_H + 22*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 4*SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //P
          else if( (hcount_in >= MP_H + 26*SQUARE) && (hcount_in <= MP_H + 26*SQUARE + 3*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 26*SQUARE) && (hcount_in <= MP_H + 26*SQUARE + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 26*SQUARE) && (hcount_in <= MP_H + 26*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 2*SQUARE) && (vcount_in <= MP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 26*SQUARE + 3*SQUARE) && (hcount_in <= MP_H + 26*SQUARE + 4*SQUARE) && (vcount_in >= MP_V + SQUARE) && (vcount_in <= MP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;  
          //L
          else if( (hcount_in >= MP_H + 31*SQUARE) && (hcount_in <= MP_H + 31*SQUARE + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 31*SQUARE) && (hcount_in <= MP_H + 31*SQUARE + 4*SQUARE) && (vcount_in >= MP_V + 4*SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          //A
          else if( (hcount_in >= MP_H + 36*SQUARE + SQUARE) && (hcount_in <= MP_H + 36*SQUARE + 3*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 36*SQUARE) && (hcount_in <= MP_H + 36*SQUARE + SQUARE) && (vcount_in >= MP_V + SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 36*SQUARE + 3*SQUARE) && (hcount_in <= MP_H + 36*SQUARE + 4*SQUARE) && (vcount_in >= MP_V + SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 36*SQUARE + SQUARE) && (hcount_in <= MP_H + 36*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 3*SQUARE) && (vcount_in <= MP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //Y
          else if( (hcount_in >= MP_H + 41*SQUARE) && (hcount_in <= MP_H + 41*SQUARE + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 41*SQUARE) && (hcount_in <= MP_H + 41*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 2*SQUARE) && (vcount_in <= MP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 41*SQUARE + 3*SQUARE) && (hcount_in <= MP_H + 41*SQUARE + 4*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 41*SQUARE + 2*SQUARE) && (hcount_in <= MP_H + 41*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 3*SQUARE) && (vcount_in <= MP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 41*SQUARE + 1*SQUARE) && (hcount_in <= MP_H + 41*SQUARE + 2*SQUARE) && (vcount_in >= MP_V + 4*SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //E
          else if( (hcount_in >= MP_H + 46*SQUARE) && (hcount_in <= MP_H + 46*SQUARE + 4*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 46*SQUARE) && (hcount_in <= MP_H + 46*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 2*SQUARE) && (vcount_in <= MP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 46*SQUARE) && (hcount_in <= MP_H + 46*SQUARE + 4*SQUARE) && (vcount_in >= MP_V + 4*SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 46*SQUARE) && (hcount_in <= MP_H + 46*SQUARE + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //R
          else if( (hcount_in >= MP_H + 51*SQUARE) && (hcount_in <= MP_H + 51*SQUARE + SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 51*SQUARE) && (hcount_in <= MP_H + 51*SQUARE + 3*SQUARE) && (vcount_in >= MP_V) && (vcount_in <= MP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 51*SQUARE) && (hcount_in <= MP_H + 51*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 2*SQUARE) && (vcount_in <= MP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 51*SQUARE + 3*SQUARE) && (hcount_in <= MP_H + 51*SQUARE + 4*SQUARE) && (vcount_in >= MP_V + SQUARE) && (vcount_in <= MP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= MP_H + 51*SQUARE + 3*SQUARE) && (hcount_in <= MP_H + 51*SQUARE + 4*SQUARE) && (vcount_in >= MP_V + 3*SQUARE) && (vcount_in <= MP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //O
          else if( (hcount_in >= OP_H) && (hcount_in <= OP_H + SQUARE) && (vcount_in >= OP_V + SQUARE) && (vcount_in <= OP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 3*SQUARE) && (hcount_in <= OP_H + 4*SQUARE) && (vcount_in >= OP_V + SQUARE) && (vcount_in <= OP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + SQUARE) && (hcount_in <= OP_H + 3*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + SQUARE) && (hcount_in <= OP_H + 3*SQUARE) && (vcount_in >= OP_V + 4*SQUARE) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //P
          else if( (hcount_in >= OP_H + 5*SQUARE) && (hcount_in <= OP_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 5*SQUARE) && (hcount_in <= OP_H + 5*SQUARE + SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 5*SQUARE) && (hcount_in <= OP_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= OP_V + 2*SQUARE) && (vcount_in <= OP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 5*SQUARE + 3*SQUARE) && (hcount_in <= OP_H + 5*SQUARE + 4*SQUARE) && (vcount_in >= OP_V + SQUARE) && (vcount_in <= OP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          //T
          else if( (hcount_in >= OP_H + 10*SQUARE) && (hcount_in <= OP_H + 10*SQUARE + 5*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 10*SQUARE + 2*SQUARE) && (hcount_in <= OP_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //I  
          else if( (hcount_in >= OP_H + 16*SQUARE) && (hcount_in <= OP_H + 16*SQUARE + 3*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 16*SQUARE + SQUARE) && (hcount_in <= OP_H + 16*SQUARE + 2*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 16*SQUARE) && (hcount_in <= OP_H + 16*SQUARE + 3*SQUARE) && (vcount_in >= OP_V + 4*SQUARE) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //O
          else if( (hcount_in >= OP_H + 20*SQUARE) && (hcount_in <= OP_H + 20*SQUARE + SQUARE) && (vcount_in >= OP_V + SQUARE) && (vcount_in <= OP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 20*SQUARE + 3*SQUARE) && (hcount_in <= OP_H + 20*SQUARE + 4*SQUARE) && (vcount_in >= OP_V + SQUARE) && (vcount_in <= OP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 20*SQUARE + SQUARE) && (hcount_in <= OP_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 20*SQUARE + SQUARE) && (hcount_in <= OP_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= OP_V + 4*SQUARE) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //N
          else if( (hcount_in >= OP_H + 25*SQUARE) && (hcount_in <= OP_H + 25*SQUARE + SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 25*SQUARE + SQUARE) && (hcount_in <= OP_H + 25*SQUARE + 2*SQUARE) && (vcount_in >= OP_V + SQUARE) && (vcount_in <= OP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 25*SQUARE + 2*SQUARE) && (hcount_in <= OP_H + 25*SQUARE + 3*SQUARE) && (vcount_in >= OP_V + 2*SQUARE) && (vcount_in <= OP_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 25*SQUARE + 3*SQUARE) && (hcount_in <= OP_H + 25*SQUARE + 4*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //S
          else if( (hcount_in >= OP_H + 30*SQUARE + SQUARE) && (hcount_in <= OP_H + 30*SQUARE + 4*SQUARE) && (vcount_in >= OP_V) && (vcount_in <= OP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 30*SQUARE) && (hcount_in <= OP_H + 30*SQUARE + SQUARE) && (vcount_in >= OP_V + SQUARE) && (vcount_in <= OP_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 30*SQUARE + SQUARE) && (hcount_in <= OP_H + 30*SQUARE + 3*SQUARE) && (vcount_in >= OP_V + 2*SQUARE) && (vcount_in <= OP_V + 3*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 30*SQUARE + 3*SQUARE) && (hcount_in <= OP_H + 30*SQUARE + 4*SQUARE) && (vcount_in >= OP_V + 3*SQUARE) && (vcount_in <= OP_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= OP_H + 30*SQUARE) && (hcount_in <= OP_H + 30*SQUARE + 3*SQUARE) && (vcount_in >= OP_V + 4*SQUARE) && (vcount_in <= OP_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //C
          else if( (hcount_in >= CR_H) && (hcount_in <= CR_H + SQUARE) && (vcount_in >= CR_V + SQUARE) && (vcount_in <= CR_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + SQUARE) && (hcount_in <= CR_H + 3*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + SQUARE) && (hcount_in <= CR_H + 3*SQUARE) && (vcount_in >= CR_V + 4*SQUARE) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 3*SQUARE) && (hcount_in <= CR_H + 4*SQUARE) && (vcount_in >= CR_V + SQUARE) && (vcount_in <= CR_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 3*SQUARE) && (hcount_in <= CR_H + 4*SQUARE) && (vcount_in >= CR_V + 3*SQUARE) && (vcount_in <= CR_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //R
          else if( (hcount_in >= CR_H + 5*SQUARE) && (hcount_in <= CR_H + 5*SQUARE + SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*SQUARE) && (hcount_in <= CR_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*SQUARE) && (hcount_in <= CR_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= CR_V + 2*SQUARE) && (vcount_in <= CR_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*SQUARE + 3*SQUARE) && (hcount_in <= CR_H + 5*SQUARE + 4*SQUARE) && (vcount_in >= CR_V + SQUARE) && (vcount_in <= CR_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*SQUARE + 3*SQUARE) && (hcount_in <= CR_H + 5*SQUARE + 4*SQUARE) && (vcount_in >= CR_V + 3*SQUARE) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //E
          else if( (hcount_in >= CR_H + 10*SQUARE) && (hcount_in <= CR_H + 10*SQUARE + 4*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 10*SQUARE) && (hcount_in <= CR_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= CR_V + 2*SQUARE) && (vcount_in <= CR_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 10*SQUARE) && (hcount_in <= CR_H + 10*SQUARE + 4*SQUARE) && (vcount_in >= CR_V + 4*SQUARE) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 10*SQUARE) && (hcount_in <= CR_H + 10*SQUARE + SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //D
          else if( (hcount_in >= CR_H + 15*SQUARE) && (hcount_in <= CR_H + 15*SQUARE + SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 15*SQUARE) && (hcount_in <= CR_H + 15*SQUARE + 3*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 15*SQUARE) && (hcount_in <= CR_H + 15*SQUARE + 3*SQUARE) && (vcount_in >= CR_V + 4*SQUARE) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 15*SQUARE + 3*SQUARE) && (hcount_in <= CR_H + 15*SQUARE + 4*SQUARE) && (vcount_in >= CR_V + SQUARE) && (vcount_in <= CR_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //I  
          else if( (hcount_in >= CR_H + 20*SQUARE) && (hcount_in <= CR_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 20*SQUARE + SQUARE) && (hcount_in <= CR_H + 20*SQUARE + 2*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 20*SQUARE) && (hcount_in <= CR_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= CR_V + 4*SQUARE) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //T
          else if( (hcount_in >= CR_H + 24*SQUARE) && (hcount_in <= CR_H + 24*SQUARE + 5*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 24*SQUARE + 2*SQUARE) && (hcount_in <= CR_H + 24*SQUARE + 3*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //S
          else if( (hcount_in >= CR_H + 30*SQUARE + SQUARE) && (hcount_in <= CR_H + 30*SQUARE + 4*SQUARE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*SQUARE) && (hcount_in <= CR_H + 30*SQUARE + SQUARE) && (vcount_in >= CR_V + SQUARE) && (vcount_in <= CR_V + 2*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*SQUARE + SQUARE) && (hcount_in <= CR_H + 30*SQUARE + 3*SQUARE) && (vcount_in >= CR_V + 2*SQUARE) && (vcount_in <= CR_V + 3*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*SQUARE + 3*SQUARE) && (hcount_in <= CR_H + 30*SQUARE + 4*SQUARE) && (vcount_in >= CR_V + 3*SQUARE) && (vcount_in <= CR_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*SQUARE) && (hcount_in <= CR_H + 30*SQUARE + 3*SQUARE) && (vcount_in >= CR_V + 4*SQUARE) && (vcount_in <= CR_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          else if( (icon_highlighter == 2'b00) && (hcount_in >= SP_H - 3*SQUARE) && (hcount_in <= SP_H - 2*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (icon_highlighter == 2'b00) && (hcount_in >= SP_H + 61*SQUARE + 2*SQUARE) && (hcount_in <= SP_H + 61*SQUARE + 3*SQUARE) && (vcount_in >= SP_V + 2*SQUARE) && (vcount_in <= SP_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (icon_highlighter == 2'b01) && (hcount_in >= MP_H - 3*SQUARE) && (hcount_in <= MP_H - 2*SQUARE) && (vcount_in >= MP_V + 2*SQUARE) && (vcount_in <= MP_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (icon_highlighter == 2'b01) && (hcount_in >= MP_H + 55*SQUARE + 2*SQUARE) && (hcount_in <= MP_H + 55*SQUARE + 3*SQUARE) && (vcount_in >= MP_V + 2*SQUARE) && (vcount_in <= MP_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (icon_highlighter == 2'b11) && (hcount_in >= OP_H - 3*SQUARE) && (hcount_in <= OP_H - 2*SQUARE) && (vcount_in >= OP_V + 2*SQUARE) && (vcount_in <= OP_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (icon_highlighter == 2'b11) && (hcount_in >= OP_H + 34*SQUARE + 2*SQUARE) && (hcount_in <= OP_H + 34*SQUARE + 3*SQUARE) && (vcount_in >= OP_V + 2*SQUARE) && (vcount_in <= OP_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (icon_highlighter == 2'b10) && (hcount_in >= CR_H - 3*SQUARE) && (hcount_in <= CR_H - 2*SQUARE) && (vcount_in >= CR_V + 2*SQUARE) && (vcount_in <= CR_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (icon_highlighter == 2'b10) && (hcount_in >= CR_H + 34*SQUARE + 2*SQUARE) && (hcount_in <= CR_H + 34*SQUARE + 3*SQUARE) && (vcount_in >= CR_V + 2*SQUARE) && (vcount_in <= CR_V +3*SQUARE) ) rgb_out <= 12'hF_F_F;
          
          else rgb_out <= 12'h0_0_0;
            
        end
    
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