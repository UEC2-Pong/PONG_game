// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  input wire pclk,
  input wire rst,
  
  output wire [10:0] vcount,
  output wire vsync,
  output wire vblnk,
  output wire [10:0] hcount,
  output wire hsync,
  output wire hblnk
  );

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 65 MHz pixel clock per VESA spec.

reg [10:0] hcounter, hcounter_nxt = 0;
  assign hcount = hcounter;
  
  reg [10:0] vcounter, vcounter_nxt = 0;
  assign vcount = vcounter;
  
    // Describe the actual circuit for the assignment.
    // Video timing controller set for 800x600@60fps
    // using a 40 MHz pixel clock per VESA spec.
    
  assign hblnk = (hcounter >= 1024);
  assign vblnk = (vcounter >= 768);
  assign hsync = (hcounter >= 1048 && hcounter <= 1184);
  assign vsync = (vcounter >= 771 && vcounter <= 777);
  
  
  // horizontal  
  always @*
  begin
      if (hcounter == 1343)
      begin
          hcounter_nxt = 0;
      end
            
      else
      begin
          hcounter_nxt = hcounter +1;
      end
  end
  
  
  //vertical
  always @*
  begin
      if (vcounter == 805 && hcounter == 1343)
      begin
          vcounter_nxt = 0;
      end
      
      else if (hcounter == 1343)
      begin
          vcounter_nxt = vcounter +1;
      end
          
      else
      begin
          vcounter_nxt = vcounter;
      end
  end
  
  always @(posedge pclk)
  if(rst)
  begin
    hcounter <= 1'b0;
    vcounter <= 1'b0;
  end
  
  else
  begin
      hcounter <= hcounter_nxt;
      vcounter <= vcounter_nxt;
  end
  
  endmodule
  