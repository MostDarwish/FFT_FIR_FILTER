module Twiddle_Multiplier (in_sig,W_fact,out_sig);
	
	input [31:0] in_sig,W_fact;
	output [31:0] out_sig;

	wire signed [15:0] in_sig_real,in_sig_imag,W_fact_real,W_fact_imag;
	wire signed [31:0] mul_real,mul_imag;

	assign in_sig_real = in_sig[31:16];
	assign in_sig_imag = in_sig[15:0];
	assign W_fact_real = W_fact[31:16];
	assign W_fact_imag = W_fact[16:0];

	assign mul_real = in_sig_real * W_fact_real - in_sig_imag * W_fact_imag;
	assign mul_imag = in_sig_imag * W_fact_real + in_sig_real * W_fact_imag;
	
	assign out_sig = {mul_real[23:8],mul_imag[23:8]};

endmodule