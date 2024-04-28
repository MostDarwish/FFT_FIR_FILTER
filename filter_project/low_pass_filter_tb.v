`timescale 1ns / 1ps
module low_pass_filter_tb();

	reg signed [15:0] X_tb; // we will test for sinusoidal input @100KHz(pass) 200KHz(attinuated) 250KHz(rejected)
	reg CLK_tb,RST_tb;
	wire signed [31:0] Y_tb;

	parameter test_type = 3;

	low_pass_filter DUT (.X(X_tb),.Y(Y_tb),.CLK(CLK_tb),.RST(RST_tb));

	initial begin
		CLK_tb = 0;
		forever
		#500 CLK_tb = ~CLK_tb;
	end

	initial begin
		RST_tb = 0;
		#10000
		RST_tb = 1;
		#500000
		$stop;
	end

	always begin
		if(test_type == 0)begin //100 KHz input signal at sampling frequency 1MHz (clock frequency used)
			X_tb = 16'h0000; #1000
			X_tb = 16'h4B3D; #1000
			X_tb = 16'h79BC; #1000
			X_tb = 16'h79BC; #1000
			X_tb = 16'h4B3D; #1000
			X_tb = 16'h0000; #1000
			X_tb = 16'hB4C3; #1000
			X_tb = 16'h8644; #1000
			X_tb = 16'h8644; #1000
			X_tb = 16'hB4C3; #1000;
		end
		else if(test_type == 1)begin //200KHz input signal at sampling frequency 1MHz (clock frequency used)
			X_tb = 16'h0000; #1000
			X_tb = 16'h79BC; #1000
			X_tb = 16'h4B3D; #1000
			X_tb = 16'hB4C3; #1000
			X_tb = 16'h8644; #1000;
		end
		else if(test_type == 2)begin //250KHz input signal at sampling frequency 1MHz (clock frequency used)
			X_tb = 16'h0000; #1000
			X_tb = 16'h7FFF; #1000
			X_tb = 16'h0000; #1000
			X_tb = 16'h8001; #1000;
		end
		else if(test_type == 3)begin //square wave with fundamental frequency 100KHz
			X_tb = 16'h7FFF; #1000
			X_tb = 16'h7FFF; #1000
			X_tb = 16'h7FFF; #1000
			X_tb = 16'h7FFF; #1000
			X_tb = 16'h7FFF; #1000
			X_tb = 16'h8000; #1000
			X_tb = 16'h8000; #1000
			X_tb = 16'h8000; #1000
			X_tb = 16'h8000; #1000;
		end
	end

endmodule