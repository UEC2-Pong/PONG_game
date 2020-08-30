// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_example (
  input wire clk_in,
  input wire [10:0] left_palette_pos,
  input wire [10:0] right_palette_pos,
  input wire [10:0] ball_xpos,
  input wire [10:0] ball_ypos,
  input wire [1:0]  screen_mode,
  input wire [1:0]  icon_highlighter,
  input wire [1:0]  speed_selector,
  
  output reg vs_out,
  output reg hs_out,
  output reg [11:0] rgb_out
  );

  // NOTE!!! 
  // 65MHz pclk clock expected!!! 
  // Such clock is needed in every module used here

wire [10:0] vcwire, hcwire;
wire vswire, vbwire, hswire, hbwire;

  vga_timing my_timing (
    .vcount(vcwire),
    .vsync(vswire),
    .vblnk(vbwire),
    .hcount(hcwire),
    .hsync(hswire),
    .hblnk(hbwire),
    .pclk(clk_in)
  );

  //wire [10:0] vc_game, hc_game;
  wire vs_game, hs_game;
  wire vb_game, hb_game;
  wire [11:0] rgb_game;

game_screen my_game_screen (
    .vcount_in(vcwire), .vsync_in(vswire), .vblnk_in(vbwire),
    .hcount_in(hcwire), .hsync_in(hswire), .hblnk_in(hbwire),
    .left_palette_pos(left_palette_pos), .right_palette_pos(right_palette_pos), 
    .ball_xpos(ball_xpos), .ball_ypos(ball_ypos),
    .pclk(clk_in),
    .vsync_out(vs_game), .vblnk_out(vb_game),
    .hsync_out(hs_game), .hblnk_out(hb_game),
    .rgb_out(rgb_game)
);

  //wire [10:0] vc_menu, hc_menu;
  wire vs_menu, hs_menu;
  wire vb_menu, hb_menu;
  wire [11:0] rgb_menu;
  
menu_screen my_menu_screen (
    .vcount_in(vcwire), .vsync_in(vswire), .vblnk_in(vbwire),
    .hcount_in(hcwire), .hsync_in(hswire), .hblnk_in(hbwire),
    .icon_highlighter(icon_highlighter), .pclk(clk_in),
    .vsync_out(vs_menu), .vblnk_out(vb_menu),
    .hsync_out(hs_menu), .hblnk_out(hb_menu),
    .rgb_out(rgb_menu)
);

  //wire [10:0] vc_options, hc_options;
  wire vs_options, hs_options;
  wire vb_options, hb_options;
  wire [11:0] rgb_options;
  
options_screen my_options_screen (
    .vcount_in(vcwire), .vsync_in(vswire), .vblnk_in(vbwire),
    .hcount_in(hcwire), .hsync_in(hswire), .hblnk_in(hbwire),
    .icon_highlighter(icon_highlighter), .speed_selector(speed_selector), .pclk(clk_in),
    .vsync_out(vs_options), .vblnk_out(vb_options),
    .hsync_out(hs_options), .hblnk_out(hb_options),
    .rgb_out(rgb_options)
);

  //wire [10:0] vc_credits, hc_credits;
  wire vs_credits, hs_credits;
  wire vb_credits, hb_credits;
  wire [11:0] rgb_credits;
  
credits_screen my_credits_screen (
    .vcount_in(vcwire), .vsync_in(vswire), .vblnk_in(vbwire),
    .hcount_in(hcwire), .hsync_in(hswire), .hblnk_in(hbwire),
    .pclk(clk_in),
    .vsync_out(vs_credits), .vblnk_out(vb_credits),
    .hsync_out(hs_credits), .hblnk_out(hb_credits),
    .rgb_out(rgb_credits)
);

//output selection
  
always @(posedge clk_in) begin
    case( screen_mode )
        2'b00: begin  //MENU
            hs_out <= hs_menu;
            vs_out <= vs_menu;
            if (vb_menu || hb_menu) rgb_out <= 12'h0_0_0; 
            else begin
                rgb_out <= rgb_menu;    
            end
        end
        2'b01: begin  //GAME
            hs_out <= hs_game;
            vs_out <= vs_game;
            if (vb_game || hb_game) rgb_out <= 12'h0_0_0; 
            else begin
                rgb_out <= rgb_game;    
            end
        end
        2'b11: begin  //OPTIONS
            hs_out <= hs_options;
            vs_out <= vs_options;
            if (vb_options || hb_options) rgb_out <= 12'h0_0_0; 
            else begin
                rgb_out <= rgb_options;    
            end
        end
        2'b10: begin  //CREDITS
            hs_out <= hs_credits;
            vs_out <= vs_credits;
            if (vb_credits || hb_credits) rgb_out <= 12'h0_0_0; 
            else begin
                rgb_out <= rgb_credits;    
            end
        end
        default: begin  //MENU is default
            hs_out <= hs_menu;
            vs_out <= vs_menu;
            if (vb_menu || hb_menu) rgb_out <= 12'h0_0_0; 
            else begin
                rgb_out <= rgb_menu;    
            end
        end
    endcase
  end

endmodule
