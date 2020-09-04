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
  input wire [10:0] pallete_position,
  output reg vs_out,
  output reg hs_out,
  output reg [11:0] rgb_out
  //output reg [3:0] r,
  //output reg [3:0] g,
  //output reg [3:0] b
  );

  // NOTE!!! 
  // 65MHz pclk clock expected!!! 

  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.

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

  wire [10:0] vcount, hcount;
  wire vsync, hsync;
  wire vblnk, hblnk;
  wire [11:0] rgbwire;

draw_palletes my_draw_palletes (
    .vcount_in(vcwire), .vsync_in(vswire), .vblnk_in(vbwire),
    .hcount_in(hcwire), .hsync_in(hswire), .hblnk_in(hbwire),
    .pallete_position(pallete_position), .pclk(clk_in),
    .vcount_out(vcount), .vsync_out(vsync), .vblnk_out(vblnk),
    .hcount_out(hcount), .hsync_out(hsync), .hblnk_out(hblnk),
    .rgb_out(rgbwire)
);

//output generation block
  
  always @(posedge clk_in)
  begin
    // Just pass these through.
    hs_out <= hsync;
    vs_out <= vsync;
    // During blanking, make it it black.
    if (vblnk || hblnk) rgb_out <= 12'h0_0_0; 
    else
    begin
    rgb_out <= rgbwire;    
    end
  end

endmodule
