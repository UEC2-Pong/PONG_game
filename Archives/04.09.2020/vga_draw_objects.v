`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2020 14:04:34
// Design Name: 
// Module Name: vga_draw_objects
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


module vga_draw_objects(
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire pclk,
    input wire rst,
    
    input wire [11:0] rgb_in,
    
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    
    output reg [11:0] rgb_out
    );
    
    localparam WIDTH='d10, HEIGHT='d100, COLOR=12'hf_f_f;
    localparam XPOS='d395, YPOS='d250;
    
    reg [11:0] rgb_out_nxt;
    
    always @(posedge pclk or posedge rst)
        begin
            if (rst)
            begin
                hsync_out <= 1'b0;
                vsync_out <= 1'b0;
                hblnk_out <= 1'b0;
                vblnk_out <= 1'b0;
                
                hcount_out <= 0;
                vcount_out <= 0;
                
                rgb_out <= 12'b0;
            end
            
            else
            begin
              hsync_out <= hsync_in;
              vsync_out <= vsync_in;
              hblnk_out <= hblnk_in;
              vblnk_out <= vblnk_in;
                
              hcount_out <= hcount_in;
              vcount_out <= vcount_in;
            
              rgb_out <= rgb_out_nxt;
            end
        end
        
        always @*
        begin
            if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0;
            else begin
                if (~hblnk_in & ~vblnk_in) begin
                    if (vcount_in <= YPOS+HEIGHT && vcount_in >= YPOS && hcount_in <= XPOS+WIDTH && hcount_in >= XPOS)
                        rgb_out_nxt <= COLOR;
                    else rgb_out_nxt <= rgb_in;
                end
                else
                rgb_out_nxt <= 12'h0_0_0;
            end
        end
endmodule
