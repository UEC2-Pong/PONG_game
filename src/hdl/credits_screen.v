`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2020 18:43:13
// Design Name: 
// Module Name: credits_screen
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


module credits_screen(
    input wire pclk,
    input wire rst,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    
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
localparam TITLE  = 20;
localparam SQUARE = 10;
localparam CR_V = 187;
localparam CR_H = 172;
localparam TB_V = 478;
localparam TB_H = 217;
localparam PL_V = 548;
localparam PL_H = 222;

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
          //C
          if     ( (hcount_in >= CR_H) && (hcount_in <= CR_H + TITLE) && (vcount_in >= CR_V + TITLE) && (vcount_in <= CR_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + TITLE) && (hcount_in <= CR_H + 3*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + TITLE) && (hcount_in <= CR_H + 3*TITLE) && (vcount_in >= CR_V + 4*TITLE) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 3*TITLE) && (hcount_in <= CR_H + 4*TITLE) && (vcount_in >= CR_V + TITLE) && (vcount_in <= CR_V + 2*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 3*TITLE) && (hcount_in <= CR_H + 4*TITLE) && (vcount_in >= CR_V + 3*TITLE) && (vcount_in <= CR_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
          //R
          else if( (hcount_in >= CR_H + 5*TITLE) && (hcount_in <= CR_H + 5*TITLE + TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*TITLE) && (hcount_in <= CR_H + 5*TITLE + 3*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*TITLE) && (hcount_in <= CR_H + 5*TITLE + 3*TITLE) && (vcount_in >= CR_V + 2*TITLE) && (vcount_in <= CR_V + 3*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*TITLE + 3*TITLE) && (hcount_in <= CR_H + 5*TITLE + 4*TITLE) && (vcount_in >= CR_V + TITLE) && (vcount_in <= CR_V + 2*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 5*TITLE + 3*TITLE) && (hcount_in <= CR_H + 5*TITLE + 4*TITLE) && (vcount_in >= CR_V + 3*TITLE) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          //E
          else if( (hcount_in >= CR_H + 10*TITLE) && (hcount_in <= CR_H + 10*TITLE + 4*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 10*TITLE) && (hcount_in <= CR_H + 10*TITLE + 3*TITLE) && (vcount_in >= CR_V + 2*TITLE) && (vcount_in <= CR_V + 3*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 10*TITLE) && (hcount_in <= CR_H + 10*TITLE + 4*TITLE) && (vcount_in >= CR_V + 4*TITLE) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 10*TITLE) && (hcount_in <= CR_H + 10*TITLE + TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          //D
          else if( (hcount_in >= CR_H + 15*TITLE) && (hcount_in <= CR_H + 15*TITLE + TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 15*TITLE) && (hcount_in <= CR_H + 15*TITLE + 3*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 15*TITLE) && (hcount_in <= CR_H + 15*TITLE + 3*TITLE) && (vcount_in >= CR_V + 4*TITLE) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 15*TITLE + 3*TITLE) && (hcount_in <= CR_H + 15*TITLE + 4*TITLE) && (vcount_in >= CR_V + TITLE) && (vcount_in <= CR_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
          //I  
          else if( (hcount_in >= CR_H + 20*TITLE) && (hcount_in <= CR_H + 20*TITLE + 3*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 20*TITLE + TITLE) && (hcount_in <= CR_H + 20*TITLE + 2*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 20*TITLE) && (hcount_in <= CR_H + 20*TITLE + 3*TITLE) && (vcount_in >= CR_V + 4*TITLE) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          //T
          else if( (hcount_in >= CR_H + 24*TITLE) && (hcount_in <= CR_H + 24*TITLE + 5*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 24*TITLE + 2*TITLE) && (hcount_in <= CR_H + 24*TITLE + 3*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          //S
          else if( (hcount_in >= CR_H + 30*TITLE + TITLE) && (hcount_in <= CR_H + 30*TITLE + 4*TITLE) && (vcount_in >= CR_V) && (vcount_in <= CR_V + TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*TITLE) && (hcount_in <= CR_H + 30*TITLE + TITLE) && (vcount_in >= CR_V + TITLE) && (vcount_in <= CR_V + 2*TITLE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*TITLE + TITLE) && (hcount_in <= CR_H + 30*TITLE + 3*TITLE) && (vcount_in >= CR_V + 2*TITLE) && (vcount_in <= CR_V + 3*TITLE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*TITLE + 3*TITLE) && (hcount_in <= CR_H + 30*TITLE + 4*TITLE) && (vcount_in >= CR_V + 3*TITLE) && (vcount_in <= CR_V + 4*TITLE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= CR_H + 30*TITLE) && (hcount_in <= CR_H + 30*TITLE + 3*TITLE) && (vcount_in >= CR_V + 4*TITLE) && (vcount_in <= CR_V + 5*TITLE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //T
          else if( (hcount_in >= TB_H) && (hcount_in <= TB_H + 5*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 2*SQUARE) && (hcount_in <= TB_H + 3*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //O
          else if( (hcount_in >= TB_H + 6*SQUARE) && (hcount_in <= TB_H + 6*SQUARE + SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 6*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 6*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 6*SQUARE + SQUARE) && (hcount_in <= TB_H + 6*SQUARE + 3*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 6*SQUARE + SQUARE) && (hcount_in <= TB_H + 6*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 4*SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //M
          else if( (hcount_in >= TB_H + 11*SQUARE) && (hcount_in <= TB_H + 11*SQUARE + SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 11*SQUARE + 4*SQUARE) && (hcount_in <= TB_H + 11*SQUARE + 5*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 11*SQUARE + SQUARE) && (hcount_in <= TB_H + 11*SQUARE + 2*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 11*SQUARE + 2*SQUARE) && (hcount_in <= TB_H + 11*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 2*SQUARE) && (vcount_in <= TB_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 11*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 11*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          //A
          else if( (hcount_in >= TB_H + 17*SQUARE + SQUARE) && (hcount_in <= TB_H + 17*SQUARE + 3*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 17*SQUARE) && (hcount_in <= TB_H + 17*SQUARE + SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 17*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 17*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 17*SQUARE + SQUARE) && (hcount_in <= TB_H + 17*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 3*SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //S
          else if( (hcount_in >= TB_H + 22*SQUARE + SQUARE) && (hcount_in <= TB_H + 22*SQUARE + 4*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 22*SQUARE) && (hcount_in <= TB_H + 22*SQUARE + SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 2*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 22*SQUARE + SQUARE) && (hcount_in <= TB_H + 22*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 2*SQUARE) && (vcount_in <= TB_V + 3*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 22*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 22*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + 3*SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 22*SQUARE) && (hcount_in <= TB_H + 22*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 4*SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //Z
          else if( (hcount_in >= TB_H + 27*SQUARE) && (hcount_in <= TB_H + 27*SQUARE + 4*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 27*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 27*SQUARE + 4*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 27*SQUARE + SQUARE) && (hcount_in <= TB_H + 27*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 2*SQUARE) && (vcount_in <= TB_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 27*SQUARE) && (hcount_in <= TB_H + 27*SQUARE + SQUARE) && (vcount_in >= TB_V + 3*SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 27*SQUARE) && (hcount_in <= TB_H + 27*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + 4*SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //B
          else if( (hcount_in >= TB_H + 35*SQUARE) && (hcount_in <= TB_H + 35*SQUARE + 3*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 35*SQUARE) && (hcount_in <= TB_H + 35*SQUARE + SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 35*SQUARE) && (hcount_in <= TB_H + 35*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 2*SQUARE) && (vcount_in <= TB_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 35*SQUARE) && (hcount_in <= TB_H + 35*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 4*SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 35*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 35*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 35*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 35*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + 3*SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //A
          else if( (hcount_in >= TB_H + 40*SQUARE + SQUARE) && (hcount_in <= TB_H + 40*SQUARE + 3*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 40*SQUARE) && (hcount_in <= TB_H + 40*SQUARE + SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 40*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 40*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 40*SQUARE + SQUARE) && (hcount_in <= TB_H + 40*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 3*SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //L
          else if( (hcount_in >= TB_H + 45*SQUARE) && (hcount_in <= TB_H + 45*SQUARE + SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= TB_H + 45*SQUARE) && (hcount_in <= TB_H + 45*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + 4*SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;   
          //O
          else if( (hcount_in >= TB_H + 50*SQUARE) && (hcount_in <= TB_H + 50*SQUARE + SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 50*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 50*SQUARE + 4*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 50*SQUARE + SQUARE) && (hcount_in <= TB_H + 50*SQUARE + 3*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= TB_H + 50*SQUARE + SQUARE) && (hcount_in <= TB_H + 50*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 4*SQUARE) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //N
          else if( (hcount_in >= TB_H + 55*SQUARE) && (hcount_in <= TB_H + 55*SQUARE  + SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= TB_H + 55*SQUARE + SQUARE) && (hcount_in <= TB_H + 55*SQUARE + 2*SQUARE) && (vcount_in >= TB_V + SQUARE) && (vcount_in <= TB_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= TB_H + 55*SQUARE + 2*SQUARE) && (hcount_in <= TB_H + 55*SQUARE + 3*SQUARE) && (vcount_in >= TB_V + 2*SQUARE) && (vcount_in <= TB_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= TB_H + 55*SQUARE + 3*SQUARE) && (hcount_in <= TB_H + 55*SQUARE + 4*SQUARE) && (vcount_in >= TB_V) && (vcount_in <= TB_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //P
          else if( (hcount_in >= PL_H) && (hcount_in <= PL_H + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H) && (hcount_in <= PL_H + SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H) && (hcount_in <= PL_H + 3*SQUARE) && (vcount_in >= PL_V + 2*SQUARE) && (vcount_in <= PL_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 3*SQUARE) && (hcount_in <= PL_H + 4*SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          //I  
          else if( (hcount_in >= PL_H + 5*SQUARE) && (hcount_in <= PL_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 5*SQUARE + SQUARE) && (hcount_in <= PL_H + 5*SQUARE + 2*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 5*SQUARE) && (hcount_in <= PL_H + 5*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 4*SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //O
          else if( (hcount_in >= PL_H + 9*SQUARE) && (hcount_in <= PL_H + 9*SQUARE + SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 9*SQUARE + 3*SQUARE) && (hcount_in <= PL_H + 9*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 9*SQUARE + SQUARE) && (hcount_in <= PL_H + 9*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 9*SQUARE + SQUARE) && (hcount_in <= PL_H + 9*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 4*SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //T
          else if( (hcount_in >= PL_H + 14*SQUARE) && (hcount_in <= PL_H + 14*SQUARE + 5*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 14*SQUARE + 2*SQUARE) && (hcount_in <= PL_H + 14*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //R
          else if( (hcount_in >= PL_H + 20*SQUARE) && (hcount_in <= PL_H + 20*SQUARE + SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 20*SQUARE) && (hcount_in <= PL_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 20*SQUARE) && (hcount_in <= PL_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 2*SQUARE) && (vcount_in <= PL_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 20*SQUARE + 3*SQUARE) && (hcount_in <= PL_H + 20*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 20*SQUARE + 3*SQUARE) && (hcount_in <= PL_H + 20*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + 3*SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //£
          else if( (hcount_in >= PL_H + 28*SQUARE) && (hcount_in <= PL_H + 28*SQUARE + SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= PL_H + 28*SQUARE) && (hcount_in <= PL_H + 28*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + 4*SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 28*SQUARE) && (hcount_in <= PL_H + 28*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 2*SQUARE) && (vcount_in <= PL_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;   
          //O
          else if( (hcount_in >= PL_H + 33*SQUARE) && (hcount_in <= PL_H + 33*SQUARE + SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 33*SQUARE + 3*SQUARE) && (hcount_in <= PL_H + 33*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 33*SQUARE + SQUARE) && (hcount_in <= PL_H + 33*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 33*SQUARE + SQUARE) && (hcount_in <= PL_H + 33*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 4*SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //P
          else if( (hcount_in >= PL_H + 38*SQUARE) && (hcount_in <= PL_H + 38*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 38*SQUARE) && (hcount_in <= PL_H + 38*SQUARE + SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 38*SQUARE) && (hcount_in <= PL_H + 38*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 2*SQUARE) && (vcount_in <= PL_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 38*SQUARE + 3*SQUARE) && (hcount_in <= PL_H + 38*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          //A
          else if( (hcount_in >= PL_H + 43*SQUARE + SQUARE) && (hcount_in <= PL_H + 43*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 43*SQUARE) && (hcount_in <= PL_H + 43*SQUARE + SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 43*SQUARE + 3*SQUARE) && (hcount_in <= PL_H + 43*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 43*SQUARE + SQUARE) && (hcount_in <= PL_H + 43*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 3*SQUARE) && (vcount_in <= PL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //T
          else if( (hcount_in >= PL_H + 48*SQUARE) && (hcount_in <= PL_H + 48*SQUARE + 5*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 48*SQUARE + 2*SQUARE) && (hcount_in <= PL_H + 48*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //A
          else if( (hcount_in >= PL_H + 54*SQUARE + SQUARE) && (hcount_in <= PL_H + 54*SQUARE + 3*SQUARE) && (vcount_in >= PL_V) && (vcount_in <= PL_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 54*SQUARE) && (hcount_in <= PL_H + 54*SQUARE + SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= PL_H + 54*SQUARE + 3*SQUARE) && (hcount_in <= PL_H + 54*SQUARE + 4*SQUARE) && (vcount_in >= PL_V + SQUARE) && (vcount_in <= PL_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;               
          else if( (hcount_in >= PL_H + 54*SQUARE + SQUARE) && (hcount_in <= PL_H + 54*SQUARE + 3*SQUARE) && (vcount_in >= PL_V + 3*SQUARE) && (vcount_in <= PL_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
