`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2020 20:17:15
// Design Name: 
// Module Name: winner_screen
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


module winner_screen(
    input wire pclk,
    input wire rst,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire player_won,
    
    //output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    //output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out
    );

localparam SCREEN_WIDTH       = 1024;
localparam SCREEN_LENGTH      = 768;
localparam SQUARE             = 16;
localparam GG_H               = SCREEN_WIDTH/2 - 59*SQUARE/2;
localparam GG_V               = SCREEN_LENGTH/2 - 5*SQUARE/2;


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
          if     ( (hcount_in >= GG_H) && (hcount_in <= GG_H + 3*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= GG_H) && (hcount_in <= GG_H + SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= GG_H) && (hcount_in <= GG_H + 3*SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= GG_H + 3*SQUARE) && (hcount_in <= GG_H + 4*SQUARE) && (vcount_in >= GG_V + SQUARE) && (vcount_in <= GG_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;  
          //L
          else if( (hcount_in >= GG_H + 5*SQUARE) && (hcount_in <= GG_H + 5*SQUARE + SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= GG_H + 5*SQUARE) && (hcount_in <= GG_H + 5*SQUARE + 4*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          //A
          else if( (hcount_in >= GG_H + 10*SQUARE + SQUARE) && (hcount_in <= GG_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 10*SQUARE) && (hcount_in <= GG_H + 10*SQUARE + SQUARE) && (vcount_in >= GG_V + SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 10*SQUARE + 3*SQUARE) && (hcount_in <= GG_H + 10*SQUARE + 4*SQUARE) && (vcount_in >= GG_V + SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 10*SQUARE + SQUARE) && (hcount_in <= GG_H + 10*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 3*SQUARE) && (vcount_in <= GG_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          //Y
          else if( (hcount_in >= GG_H + 15*SQUARE) && (hcount_in <= GG_H + 15*SQUARE + SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 15*SQUARE) && (hcount_in <= GG_H + 15*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 15*SQUARE + 3*SQUARE) && (hcount_in <= GG_H + 15*SQUARE + 4*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 15*SQUARE + 2*SQUARE) && (hcount_in <= GG_H + 15*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 3*SQUARE) && (vcount_in <= GG_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 15*SQUARE + 1*SQUARE) && (hcount_in <= GG_H + 15*SQUARE + 2*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //E
          else if( (hcount_in >= GG_H + 20*SQUARE) && (hcount_in <= GG_H + 20*SQUARE + 4*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= GG_H + 20*SQUARE) && (hcount_in <= GG_H + 20*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= GG_H + 20*SQUARE) && (hcount_in <= GG_H + 20*SQUARE + 4*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;  
          else if( (hcount_in >= GG_H + 20*SQUARE) && (hcount_in <= GG_H + 20*SQUARE + SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //R
          else if( (hcount_in >= GG_H + 25*SQUARE) && (hcount_in <= GG_H + 25*SQUARE + SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 25*SQUARE) && (hcount_in <= GG_H + 25*SQUARE + 3*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 25*SQUARE) && (hcount_in <= GG_H + 25*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 25*SQUARE + 3*SQUARE) && (hcount_in <= GG_H + 25*SQUARE + 4*SQUARE) && (vcount_in >= GG_V + SQUARE) && (vcount_in <= GG_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 25*SQUARE + 3*SQUARE) && (hcount_in <= GG_H + 25*SQUARE + 4*SQUARE) && (vcount_in >= GG_V + 3*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //1
          else if( (player_won == 0) && (hcount_in >= GG_H + 33*SQUARE) && (hcount_in <= GG_H + 33*SQUARE + SQUARE) && (vcount_in >= GG_V + SQUARE) && (vcount_in <= GG_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (player_won == 0) && (hcount_in >= GG_H + 33*SQUARE + SQUARE) && (hcount_in <= GG_H + 33*SQUARE + 2*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (player_won == 0) && (hcount_in >= GG_H + 33*SQUARE) && (hcount_in <= GG_H + 33*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //2
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          else if( (player_won == 1) && (hcount_in >= GG_H + 33*SQUARE) && (hcount_in <= GG_H + 33*SQUARE + 3*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (player_won == 1) && (hcount_in >= GG_H + 33*SQUARE + 2*SQUARE) && (hcount_in <= GG_H + 33*SQUARE + 3*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (player_won == 1) && (hcount_in >= GG_H + 33*SQUARE) && (hcount_in <= GG_H + 33*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (player_won == 1) && (hcount_in >= GG_H + 33*SQUARE) && (hcount_in <= GG_H + 33*SQUARE + SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (player_won == 1) && (hcount_in >= GG_H + 33*SQUARE) && (hcount_in <= GG_H + 33*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //W
          else if( (hcount_in >= GG_H + 40*SQUARE) && (hcount_in <= GG_H + 40*SQUARE + SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 40*SQUARE + 2*SQUARE) && (hcount_in <= GG_H + 40*SQUARE + 3*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 40*SQUARE + 4*SQUARE) && (hcount_in <= GG_H + 40*SQUARE + 5*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 40*SQUARE + 1*SQUARE) && (hcount_in <= GG_H + 40*SQUARE + 2*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 40*SQUARE + 3*SQUARE) && (hcount_in <= GG_H + 40*SQUARE + 4*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //I  
          else if( (hcount_in >= GG_H + 46*SQUARE) && (hcount_in <= GG_H + 46*SQUARE + 3*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 46*SQUARE + SQUARE) && (hcount_in <= GG_H + 46*SQUARE + 2*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 46*SQUARE) && (hcount_in <= GG_H + 46*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;
          //N
          else if( (hcount_in >= GG_H + 50*SQUARE) && (hcount_in <= GG_H + 50*SQUARE  + SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= GG_H + 50*SQUARE + SQUARE) && (hcount_in <= GG_H + 50*SQUARE + 2*SQUARE) && (vcount_in >= GG_V + SQUARE) && (vcount_in <= GG_V + 2*SQUARE) ) rgb_out <= 12'hF_F_F;   
          else if( (hcount_in >= GG_H + 50*SQUARE + 2*SQUARE) && (hcount_in <= GG_H + 50*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 3*SQUARE) ) rgb_out <= 12'hF_F_F; 
          else if( (hcount_in >= GG_H + 50*SQUARE + 3*SQUARE) && (hcount_in <= GG_H + 50*SQUARE + 4*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F; 
          //S
          else if( (hcount_in >= GG_H + 55*SQUARE + SQUARE) && (hcount_in <= GG_H + 55*SQUARE + 4*SQUARE) && (vcount_in >= GG_V) && (vcount_in <= GG_V + SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 55*SQUARE) && (hcount_in <= GG_H + 55*SQUARE + SQUARE) && (vcount_in >= GG_V + SQUARE) && (vcount_in <= GG_V + 2*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 55*SQUARE + SQUARE) && (hcount_in <= GG_H + 55*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 2*SQUARE) && (vcount_in <= GG_V + 3*SQUARE ) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 55*SQUARE + 3*SQUARE) && (hcount_in <= GG_H + 55*SQUARE + 4*SQUARE) && (vcount_in >= GG_V + 3*SQUARE) && (vcount_in <= GG_V + 4*SQUARE) ) rgb_out <= 12'hF_F_F;
          else if( (hcount_in >= GG_H + 55*SQUARE) && (hcount_in <= GG_H + 55*SQUARE + 3*SQUARE) && (vcount_in >= GG_V + 4*SQUARE) && (vcount_in <= GG_V + 5*SQUARE) ) rgb_out <= 12'hF_F_F;                  
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
