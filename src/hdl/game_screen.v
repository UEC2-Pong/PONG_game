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


module game_screen(
    input wire pclk,
    input wire rst,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] left_palette_pos,
    input wire [10:0] right_palette_pos,
    input wire [10:0] ball_xpos,
    input wire [10:0] ball_ypos,
    input wire [7:0]  score,
    
    //output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    //output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out
    );

wire [3:0] left_score, right_score;
assign left_score = score[7:4];
assign right_score = score[3:0];

localparam SCREEN_WIDTH      = 1024;
localparam HALF_SCREEN_WIDTH = 512;
localparam SQUARE            = 10;
localparam SCORE_LINE        = 6*SQUARE;
localparam LP_H              = SCREEN_WIDTH/4 - SCORE_LINE/2;
localparam LP_V              = 5*SQUARE;
localparam RP_H              = 3*SCREEN_WIDTH/4 - SCORE_LINE/2;
localparam RP_V              = 5*SQUARE;
localparam SCORE_MID_BAR     = 5*SQUARE;
localparam SCORE_BOT_BAR     = 10*SQUARE;
localparam SCORE_RIG_BAR     = 5*SQUARE;
localparam PALETTE_LENGTH    = 100;
localparam PALETTE_WIDTH     = 10;
localparam BALL_SIZE         = 5;

  always @(posedge pclk)
  begin
    if(rst)
    begin
        hsync_out <= 1'b0;
        hblnk_out <= 1'b0;
        vsync_out <= 1'b0;
        vblnk_out <= 1'b0;
    end
    
    else
    begin
        //during blanking make it black
        if (vblnk_in || hblnk_in) rgb_out <= 12'h0_0_0; 
        else
        begin
          if     ( (vcount_in > left_palette_pos - PALETTE_LENGTH) && (vcount_in < left_palette_pos + PALETTE_LENGTH) && (hcount_in < PALETTE_WIDTH) ) rgb_out <= 12'hF_F_F;
          else if( (vcount_in > right_palette_pos - PALETTE_LENGTH) && (vcount_in < right_palette_pos + PALETTE_LENGTH) && (hcount_in > SCREEN_WIDTH - PALETTE_WIDTH) ) rgb_out <= 12'hF_F_F;
          else if( (vcount_in >= ball_ypos - BALL_SIZE) && (vcount_in <= ball_ypos + BALL_SIZE) && (hcount_in >= ball_xpos - BALL_SIZE) && (hcount_in <= ball_xpos + BALL_SIZE) ) rgb_out <= 12'hF_F_F;  
          
          else if( ((left_score == 0) || (left_score == 1) || (left_score == 2) || (left_score == 3) || (left_score == 4) || (left_score == 7) || (left_score == 8) || (left_score == 9)) 
                    && (hcount_in >= LP_H + SCORE_RIG_BAR) && (hcount_in <= LP_H + SCORE_LINE) && (vcount_in >= LP_V) && (vcount_in <= LP_V + SCORE_MID_BAR + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( ((left_score == 0) || (left_score == 1) || (left_score == 3) || (left_score == 4) || (left_score == 5) ||( left_score == 6) || (left_score == 7) || (left_score == 8) || (left_score == 9)) 
                    && (hcount_in >= LP_H + SCORE_RIG_BAR) && (hcount_in <= LP_H + SCORE_LINE) && (vcount_in >= LP_V + SCORE_MID_BAR) && (vcount_in <= LP_V + SCORE_MID_BAR + SCORE_LINE) ) rgb_out <= 12'hF_F_F;
          else if( ((left_score == 0) || (left_score == 2) || (left_score == 3) || (left_score == 5) ||( left_score == 6) || (left_score == 8) || (left_score == 9)) 
                    && (hcount_in >= LP_H) && (hcount_in <= LP_H + SCORE_LINE) && (vcount_in >= LP_V + SCORE_BOT_BAR) && (vcount_in <= LP_V + SCORE_BOT_BAR + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( ((left_score == 0) || (left_score == 2) || ( left_score == 6) || (left_score == 8)) 
                    && (hcount_in >= LP_H) && (hcount_in <= LP_H + SQUARE) && (vcount_in >= LP_V + SCORE_MID_BAR) && (vcount_in <= LP_V + SCORE_MID_BAR + SCORE_LINE) ) rgb_out <= 12'hF_F_F;
          else if( ((left_score == 0) || (left_score == 4) || (left_score == 5) || (left_score == 6) || (left_score == 8) ||( left_score == 9)) 
                    && (hcount_in >= LP_H) && (hcount_in <= LP_H + SQUARE) && (vcount_in >= LP_V) && (vcount_in <= LP_V + SCORE_LINE) ) rgb_out <= 12'hF_F_F;
          else if( ((left_score == 0) || (left_score == 2) || (left_score == 3) || (left_score == 5) ||( left_score == 6) || (left_score == 7) || (left_score == 8) || (left_score == 9)) 
                    && (hcount_in >= LP_H) && (hcount_in <= LP_H + SCORE_LINE) && (vcount_in >= LP_V) && (vcount_in <= LP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( ((left_score == 2) || (left_score == 3) || (left_score == 4) || (left_score == 5) || (left_score == 6) ||( left_score == 8) || (left_score == 9)) 
                    && (hcount_in >= LP_H) && (hcount_in <= LP_H + SCORE_LINE) && (vcount_in >= LP_V + SCORE_MID_BAR) && (vcount_in <= LP_V + SCORE_MID_BAR + SQUARE) ) rgb_out <= 12'hF_F_F;
    
          else if( ((right_score == 0) || (right_score == 1) || (right_score == 2) || (right_score == 3) || (right_score == 4) || (right_score == 7) || (right_score == 8) || (right_score == 9)) 
                    && (hcount_in >= RP_H + SCORE_RIG_BAR) && (hcount_in <= RP_H + SCORE_LINE) && (vcount_in >= RP_V) && (vcount_in <= RP_V + SCORE_MID_BAR + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( ((right_score == 0) || (right_score == 1) || (right_score == 3) || (right_score == 4) || (right_score == 5) ||( right_score == 6) || (right_score == 7) || (right_score == 8) || (right_score == 9)) 
                    && (hcount_in >= RP_H + SCORE_RIG_BAR) && (hcount_in <= RP_H + SCORE_LINE) && (vcount_in >= RP_V + SCORE_MID_BAR) && (vcount_in <= LP_V + SCORE_MID_BAR + SCORE_LINE) ) rgb_out <= 12'hF_F_F;
          else if( ((right_score == 0) || (right_score == 2) || (right_score == 3) || (right_score == 5) ||( right_score == 6) || (right_score == 8) || (right_score == 9)) 
                    && (hcount_in >= RP_H) && (hcount_in <= RP_H + SCORE_LINE) && (vcount_in >= RP_V + SCORE_BOT_BAR) && (vcount_in <= RP_V + SCORE_BOT_BAR + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( ((right_score == 0) || (right_score == 2) || ( right_score == 6) || (right_score == 8)) 
                    && (hcount_in >= RP_H) && (hcount_in <= RP_H + SQUARE) && (vcount_in >= RP_V + SCORE_MID_BAR) && (vcount_in <= RP_V + SCORE_MID_BAR + SCORE_LINE) ) rgb_out <= 12'hF_F_F;
          else if( ((right_score == 0) || (right_score == 4) || (right_score == 5) || (right_score == 6) || (right_score == 8) ||( right_score == 9)) 
                    && (hcount_in >= RP_H) && (hcount_in <= RP_H + SQUARE) && (vcount_in >= RP_V) && (vcount_in <= RP_V + SCORE_LINE) ) rgb_out <= 12'hF_F_F;
          else if( ((right_score == 0) || (right_score == 2) || (right_score == 3) || (right_score == 5) ||( right_score == 6) || (right_score == 7) || (right_score == 8) || (right_score == 9)) 
                    && (hcount_in >= RP_H) && (hcount_in <= RP_H + SCORE_LINE) && (vcount_in >= RP_V) && (vcount_in <= RP_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( ((right_score == 2) || (right_score == 3) || (right_score == 4) || (right_score == 5) || (right_score == 6) ||( right_score == 8) || (right_score == 9)) 
                    && (hcount_in >= RP_H) && (hcount_in <= RP_H + SCORE_LINE) && (vcount_in >= RP_V + SCORE_MID_BAR) && (vcount_in <= RP_V + SCORE_MID_BAR + SQUARE) ) rgb_out <= 12'hF_F_F;
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