module fft_test ();

	reg CLK,RST;
	reg [15:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15;
	wire [31:0] y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15;

	main_fft DUT (x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,
				  y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,
				  CLK,RST);

	initial begin
		CLK = 0;
		forever
		#1 CLK = ~CLK;
	end

	initial begin
		RST = 0;
		x0  = 16'hFD00;
		x1  = 16'hFE00;
		x2  = 16'hFF00;
		x3  = 16'h0000;
		x4  = 16'h0100;
		x5  = 16'h0200;
		x6  = 16'h0300;
		x7  = 16'h0400;
		x8  = 16'h0400;
		x9  = 16'h0300;
		x10 = 16'h0200;
		x11 = 16'h0100;
		x12 = 16'h0000;
		x13 = 16'h0000;
		x14 = 16'h0100;
		x15 = 16'h0200;
		#10
		RST = 1;
		#20;
		$stop;

	end

endmodule