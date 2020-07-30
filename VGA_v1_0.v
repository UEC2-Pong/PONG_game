
`timescale 1 ns / 1 ps

	module VGA_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface VGA
		parameter integer C_VGA_ID_WIDTH	= 1,
		parameter integer C_VGA_DATA_WIDTH	= 32,
		parameter integer C_VGA_ADDR_WIDTH	= 6,
		parameter integer C_VGA_AWUSER_WIDTH	= 0,
		parameter integer C_VGA_ARUSER_WIDTH	= 0,
		parameter integer C_VGA_WUSER_WIDTH	= 0,
		parameter integer C_VGA_RUSER_WIDTH	= 0,
		parameter integer C_VGA_BUSER_WIDTH	= 0
	)
	(
		// Users to add ports here  
        output wire [3:0] r,
        output wire [3:0] g,
        output wire [3:0] b,
        output wire vs,
        output wire hs,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface VGA
		input wire  vga_aclk,
		input wire  vga_aresetn,
		input wire [C_VGA_ID_WIDTH-1 : 0] vga_awid,
		input wire [C_VGA_ADDR_WIDTH-1 : 0] vga_awaddr,
		input wire [7 : 0] vga_awlen,
		input wire [2 : 0] vga_awsize,
		input wire [1 : 0] vga_awburst,
		input wire  vga_awlock,
		input wire [3 : 0] vga_awcache,
		input wire [2 : 0] vga_awprot,
		input wire [3 : 0] vga_awqos,
		input wire [3 : 0] vga_awregion,
		input wire [C_VGA_AWUSER_WIDTH-1 : 0] vga_awuser,
		input wire  vga_awvalid,
		output wire  vga_awready,
		input wire [C_VGA_DATA_WIDTH-1 : 0] vga_wdata,
		input wire [(C_VGA_DATA_WIDTH/8)-1 : 0] vga_wstrb,
		input wire  vga_wlast,
		input wire [C_VGA_WUSER_WIDTH-1 : 0] vga_wuser,
		input wire  vga_wvalid,
		output wire  vga_wready,
		output wire [C_VGA_ID_WIDTH-1 : 0] vga_bid,
		output wire [1 : 0] vga_bresp,
		output wire [C_VGA_BUSER_WIDTH-1 : 0] vga_buser,
		output wire  vga_bvalid,
		input wire  vga_bready,
		input wire [C_VGA_ID_WIDTH-1 : 0] vga_arid,
		input wire [C_VGA_ADDR_WIDTH-1 : 0] vga_araddr,
		input wire [7 : 0] vga_arlen,
		input wire [2 : 0] vga_arsize,
		input wire [1 : 0] vga_arburst,
		input wire  vga_arlock,
		input wire [3 : 0] vga_arcache,
		input wire [2 : 0] vga_arprot,
		input wire [3 : 0] vga_arqos,
		input wire [3 : 0] vga_arregion,
		input wire [C_VGA_ARUSER_WIDTH-1 : 0] vga_aruser,
		input wire  vga_arvalid,
		output wire  vga_arready,
		output wire [C_VGA_ID_WIDTH-1 : 0] vga_rid,
		output wire [C_VGA_DATA_WIDTH-1 : 0] vga_rdata,
		output wire [1 : 0] vga_rresp,
		output wire  vga_rlast,
		output wire [C_VGA_RUSER_WIDTH-1 : 0] vga_ruser,
		output wire  vga_rvalid,
		input wire  vga_rready
	);
	
	    wire [10:0] vcount, hcount, vcount_in, hcount_in, vcount_out, hcount_out, vcount_out_bg, hcount_out_bg, vcount_out_obj, hcount_out_obj;
        wire vsync, hsync, vsync_in, hsync_in, vsync_out, hsync_out, vsync_out_bg, hsync_out_bg, vsync_out_obj, hsync_out_obj;
        wire vblnk, hblnk, vblnk_in, hblnk_in, vblnk_out, hblnk_out, vblnk_out_bg, hblnk_out_bg, vblnk_out_obj, hblnk_out_obj;
        wire [11:0] rgb_in, rgb_out, rgb_out_bg, rgb_out_obj;
	
// Instantiation of Axi Bus Interface VGA
	VGA_v1_0_VGA # ( 
		.C_S_AXI_ID_WIDTH(C_VGA_ID_WIDTH),
		.C_S_AXI_DATA_WIDTH(C_VGA_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_VGA_ADDR_WIDTH),
		.C_S_AXI_AWUSER_WIDTH(C_VGA_AWUSER_WIDTH),
		.C_S_AXI_ARUSER_WIDTH(C_VGA_ARUSER_WIDTH),
		.C_S_AXI_WUSER_WIDTH(C_VGA_WUSER_WIDTH),
		.C_S_AXI_RUSER_WIDTH(C_VGA_RUSER_WIDTH),
		.C_S_AXI_BUSER_WIDTH(C_VGA_BUSER_WIDTH)
	) VGA_v1_0_VGA_inst (
		.S_AXI_ACLK(vga_aclk),
		.S_AXI_ARESETN(vga_aresetn),
		.S_AXI_AWID(vga_awid),
		.S_AXI_AWADDR(vga_awaddr),
		.S_AXI_AWLEN(vga_awlen),
		.S_AXI_AWSIZE(vga_awsize),
		.S_AXI_AWBURST(vga_awburst),
		.S_AXI_AWLOCK(vga_awlock),
		.S_AXI_AWCACHE(vga_awcache),
		.S_AXI_AWPROT(vga_awprot),
		.S_AXI_AWQOS(vga_awqos),
		.S_AXI_AWREGION(vga_awregion),
		.S_AXI_AWUSER(vga_awuser),
		.S_AXI_AWVALID(vga_awvalid),
		.S_AXI_AWREADY(vga_awready),
		.S_AXI_WDATA(vga_wdata),
		.S_AXI_WSTRB(vga_wstrb),
		.S_AXI_WLAST(vga_wlast),
		.S_AXI_WUSER(vga_wuser),
		.S_AXI_WVALID(vga_wvalid),
		.S_AXI_WREADY(vga_wready),
		.S_AXI_BID(vga_bid),
		.S_AXI_BRESP(vga_bresp),
		.S_AXI_BUSER(vga_buser),
		.S_AXI_BVALID(vga_bvalid),
		.S_AXI_BREADY(vga_bready),
		.S_AXI_ARID(vga_arid),
		.S_AXI_ARADDR(vga_araddr),
		.S_AXI_ARLEN(vga_arlen),
		.S_AXI_ARSIZE(vga_arsize),
		.S_AXI_ARBURST(vga_arburst),
		.S_AXI_ARLOCK(vga_arlock),
		.S_AXI_ARCACHE(vga_arcache),
		.S_AXI_ARPROT(vga_arprot),
		.S_AXI_ARQOS(vga_arqos),
		.S_AXI_ARREGION(vga_arregion),
		.S_AXI_ARUSER(vga_aruser),
		.S_AXI_ARVALID(vga_arvalid),
		.S_AXI_ARREADY(vga_arready),
		.S_AXI_RID(vga_rid),
		.S_AXI_RDATA(vga_rdata),
		.S_AXI_RRESP(vga_rresp),
		.S_AXI_RLAST(vga_rlast),
		.S_AXI_RUSER(vga_ruser),
		.S_AXI_RVALID(vga_rvalid),
		.S_AXI_RREADY(vga_rready)
	);

	// Add user logic here

        wire clk_in;
        wire locked;
        wire clk_fb;
        wire clk_ss;
        wire clk_out;
        wire pclk;
        (* KEEP = "TRUE" *) 
        (* ASYNC_REG = "TRUE" *)
        reg [7:0] safe_start = 0;

        IBUF clk_ibuf (.I(vga_aclk),.O(clk_in));

        MMCME2_BASE #(
            .CLKIN1_PERIOD(10.000),
            .CLKFBOUT_MULT_F(10.000),
            .CLKOUT0_DIVIDE_F(25.000))
        clk_in_mmcme2 (
            .CLKIN1(clk_in),
            .CLKOUT0(clk_out),
            .CLKOUT0B(),
            .CLKOUT1(),
            .CLKOUT1B(),
            .CLKOUT2(),
            .CLKOUT2B(),
            .CLKOUT3(),
            .CLKOUT3B(),
            .CLKOUT4(),
            .CLKOUT5(),
            .CLKOUT6(),
            .CLKFBOUT(clkfb),
            .CLKFBOUTB(),
            .CLKFBIN(clkfb),
            .LOCKED(locked),
            .PWRDWN(1'b0),
            .RST(1'b0)
        );

        BUFH clk_out_bufh (.I(clk_out),.O(clk_ss));
        always @(posedge clk_ss) safe_start<= {safe_start[6:0],locked};

        BUFGCE clk_out_bufgce (.I(clk_out),.CE(safe_start[7]),.O(pclk));
           
        vga_timing my_timing (
            .pclk(pclk),
                             
            .vcount(vcount),
            .vsync(vsync),
            .vblnk(vblnk),
            .hcount(hcount),
            .hsync(hsync),
            .hblnk(hblnk)
        );
       
        // black background
        vga_background my_background (
            .vcount_in(vcount),
            .vsync_in(vsync),
            .vblnk_in(vblnk),
            .hcount_in(hcount),
            .hsync_in(hsync),
            .hblnk_in(hblnk),
            .pclk(pclk),
            .rst(/*vga_aresetn*/),
            
            .vcount_out(vcount_out_bg),
            .vsync_out(vsync_out_bg),
            .vblnk_out(vblnk_out_bg),
            .hcount_out(hcount_out_bg),
            .hsync_out(hsync_out_bg),
            .hblnk_out(hblnk_out_bg),
            
            .rgb_out(rgb_out_bg)
        );
        
        //drawing objects
        vga_draw_objects my_draw_objects (
            .vcount_in(vcount_out_bg),
            .vsync_in(vsync_out_bg),
            .vblnk_in(vblnk_out_bg),
            .hcount_in(hcount_out_bg),
            .hsync_in(hsync_out_bg),
            .hblnk_in(hblnk_out_bg),
            .pclk(pclk),
            .rst(/*vga_aresetn*/),
            .rgb_in(rgb_out_bg),
            
            .vcount_out(vcount_out_obj),
            .vsync_out(vsync_out_obj),
            .vblnk_out(vblnk_out_obj),
            .hcount_out(hcount_out_obj),
            .hsync_out(hsync_out_obj),
            .hblnk_out(hblnk_out_obj),
            .rgb_out(rgb_out_obj)
        );
        
        assign hs = hsync_out_obj;
        assign vs = vsync_out_obj;
        assign {r,g,b} = rgb_out_obj;
        
        /*always @(posedge pclk)
        begin
            hs <= hsync_out_obj;
            vs <= vsync_out_obj;
            
            if(vblnk || hblnk) {r,g,b} <= 12'h0_0_0;
            else
                {r,g,b} <= rgb_out_obj;
        end*/

	// User logic ends

	endmodule
