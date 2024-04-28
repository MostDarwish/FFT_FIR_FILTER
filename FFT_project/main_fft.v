module main_fft(X_0,X_1,X_2,X_3,X_4,X_5,X_6,X_7,X_8,X_9,X_10,X_11,X_12,X_13,X_14,X_15,
				Y_0,Y_1,Y_2,Y_3,Y_4,Y_5,Y_6,Y_7,Y_8,Y_9,Y_10,Y_11,Y_12,Y_13,Y_14,Y_15,
				CLK,RST);

	input  [15:0] X_0,X_1,X_2,X_3,X_4,X_5,X_6,X_7,X_8,X_9,X_10,X_11,X_12,X_13,X_14,X_15;
	input CLK,RST;
	output reg [31:0] Y_0,Y_1,Y_2,Y_3,Y_4,Y_5,Y_6,Y_7,Y_8,Y_9,Y_10,Y_11,Y_12,Y_13,Y_14,Y_15;

	wire [31:0] M [0:15];
	wire [31:0] W_LUT [0:7];
	wire [27:0] input_sel;
	wire [23:0] twid_sel;
	wire [63:0] Add_sel;
	wire [31:0] selected_twid [0:7];
	wire [31:0] in_mux_output [0:15];
	wire [31:0] twid_mul_out [0:7];
	wire [31:0] BF_out [0:15];
	wire RD_en;

	assign W_LUT [0] = 32'h0100_0000;
	assign W_LUT [1] = 32'h00ED_FF9E;
	assign W_LUT [2] = 32'h00B5_FF4B;
	assign W_LUT [3] = 32'h0062_FF13;
	assign W_LUT [4] = 32'h0000_FF00;
	assign W_LUT [5] = 32'hFF9E_FF13;
	assign W_LUT [6] = 32'hFF4B_FF4B;
	assign W_LUT [7] = 32'hFF13_FF9E;

	always@(posedge RD_en) begin
		Y_0 = M[0];
		Y_1 = M[1];
		Y_2 = M[2];
		Y_3 = M[3];
		Y_4 = M[4];
		Y_5 = M[5];
		Y_6 = M[6];
		Y_7 = M[7];
		Y_8 = M[8];
		Y_9 = M[9];
		Y_10 = M[10];
		Y_11 = M[11];
		Y_12 = M[12];
		Y_13 = M[13];
		Y_14 = M[14];
		Y_15 = M[15];
	end

	MUX2x1 in_mux_1  (.in1(X_0),.in2(M[0]),.sel(input_sel[0]),.out(in_mux_output[0]));
	MUX4x1 in_mux_2  (.in1(X_8),.in2(M[2]),.in3(M[4]),.in4(M[8]),.sel(input_sel[2:1]),.out(in_mux_output[1]));
	MUX2x1 in_mux_3  (.in1(X_4),.in2(M[1]),.sel(input_sel[3]),.out(in_mux_output[2]));
	MUX4x1 in_mux_4  (.in1(X_12),.in2(M[3]),.in3(M[5]),.in4(M[9]),.sel(input_sel[5:4]),.out(in_mux_output[3]));
	MUX3x1 in_mux_5  (.in1(X_2),.in2(M[4]),.in3(M[2]),.sel(input_sel[7:6]),.out(in_mux_output[4]));
	MUX3x1 in_mux_6  (.in1(X_10),.in2(M[6]),.in3(M[10]),.sel(input_sel[9:8]),.out(in_mux_output[5]));
	MUX3x1 in_mux_7  (.in1(X_6),.in2(M[5]),.in3(M[3]),.sel(input_sel[11:10]),.out(in_mux_output[6]));
	MUX3x1 in_mux_8  (.in1(X_14),.in2(M[7]),.in3(M[11]),.sel(input_sel[13:12]),.out(in_mux_output[7]));
	MUX3x1 in_mux_9  (.in1(X_1),.in2(M[8]),.in3(M[4]),.sel(input_sel[15:14]),.out(in_mux_output[8]));
	MUX3x1 in_mux_10 (.in1(X_9),.in2(M[10]),.in3(M[12]),.sel(input_sel[17:16]),.out(in_mux_output[9]));
	MUX3x1 in_mux_11 (.in1(X_5),.in2(M[9]),.in3(M[5]),.sel(input_sel[19:18]),.out(in_mux_output[10]));
	MUX3x1 in_mux_12 (.in1(X_13),.in2(M[11]),.in3(M[13]),.sel(input_sel[21:20]),.out(in_mux_output[11]));
	MUX4x1 in_mux_13 (.in1(X_3),.in2(M[12]),.in3(M[10]),.in4(M[6]),.sel(input_sel[23:22]),.out(in_mux_output[12]));
	MUX2x1 in_mux_14 (.in1(X_11),.in2(M[14]),.sel(input_sel[24]),.out(in_mux_output[13]));
	MUX4x1 in_mux_15 (.in1(X_7),.in2(M[13]),.in3(M[11]),.in4(M[7]),.sel(input_sel[26:25]),.out(in_mux_output[14]));
	MUX2x1 in_mux_16 (.in1(X_15),.in2(M[15]),.sel(input_sel[27]),.out(in_mux_output[15]));

	Twiddle_Multiplier TM1 (.in_sig(in_mux_output[1]),.W_fact(selected_twid[0]),.out_sig(twid_mul_out[0]));
	Twiddle_Multiplier TM2 (.in_sig(in_mux_output[3]),.W_fact(selected_twid[1]),.out_sig(twid_mul_out[1]));
	Twiddle_Multiplier TM3 (.in_sig(in_mux_output[5]),.W_fact(selected_twid[2]),.out_sig(twid_mul_out[2]));
	Twiddle_Multiplier TM4 (.in_sig(in_mux_output[7]),.W_fact(selected_twid[3]),.out_sig(twid_mul_out[3]));
	Twiddle_Multiplier TM5 (.in_sig(in_mux_output[9]),.W_fact(selected_twid[4]),.out_sig(twid_mul_out[4]));
	Twiddle_Multiplier TM6 (.in_sig(in_mux_output[11]),.W_fact(selected_twid[5]),.out_sig(twid_mul_out[5]));
	Twiddle_Multiplier TM7 (.in_sig(in_mux_output[13]),.W_fact(selected_twid[6]),.out_sig(twid_mul_out[6]));
	Twiddle_Multiplier TM8 (.in_sig(in_mux_output[15]),.W_fact(selected_twid[7]),.out_sig(twid_mul_out[7]));

	MUX8x1 twiddle_mux_1 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[2:0]),.out(selected_twid[0]));
	MUX8x1 twiddle_mux_2 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[5:3]),.out(selected_twid[1]));
	MUX8x1 twiddle_mux_3 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[8:6]),.out(selected_twid[2]));
	MUX8x1 twiddle_mux_4 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[11:9]),.out(selected_twid[3]));
	MUX8x1 twiddle_mux_5 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[14:12]),.out(selected_twid[4]));
	MUX8x1 twiddle_mux_6 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[17:15]),.out(selected_twid[5]));
	MUX8x1 twiddle_mux_7 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[20:18]),.out(selected_twid[6]));
	MUX8x1 twiddle_mux_8 (.in1(W_LUT[0]),.in2(W_LUT[1]),.in3(W_LUT[2]),.in4(W_LUT[3]),.in5(W_LUT[4]),.in6(W_LUT[5]),.in7(W_LUT[6]),.in8(W_LUT[7]),.sel(twid_sel[23:21]),.out(selected_twid[7]));

	Butter_fly BF_1 (.in_1(in_mux_output[0]),.in_2(twid_mul_out[0]),.out_1(BF_out[0]),.out_2(BF_out[1]));
	Butter_fly BF_2 (.in_1(in_mux_output[2]),.in_2(twid_mul_out[1]),.out_1(BF_out[2]),.out_2(BF_out[3]));
	Butter_fly BF_3 (.in_1(in_mux_output[4]),.in_2(twid_mul_out[2]),.out_1(BF_out[4]),.out_2(BF_out[5]));
	Butter_fly BF_4 (.in_1(in_mux_output[6]),.in_2(twid_mul_out[3]),.out_1(BF_out[6]),.out_2(BF_out[7]));
	Butter_fly BF_5 (.in_1(in_mux_output[8]),.in_2(twid_mul_out[4]),.out_1(BF_out[8]),.out_2(BF_out[9]));
	Butter_fly BF_6 (.in_1(in_mux_output[10]),.in_2(twid_mul_out[5]),.out_1(BF_out[10]),.out_2(BF_out[11]));
	Butter_fly BF_7 (.in_1(in_mux_output[12]),.in_2(twid_mul_out[6]),.out_1(BF_out[12]),.out_2(BF_out[13]));
	Butter_fly BF_8 (.in_1(in_mux_output[14]),.in_2(twid_mul_out[7]),.out_1(BF_out[14]),.out_2(BF_out[15]));

	reg_file fft_samples (
							  .Data0(BF_out[0]),.Data1(BF_out[1]),.Data2(BF_out[2]) ,.Data3(BF_out[3]) ,.Data4(BF_out[4]) ,.Data5(BF_out[5]) ,.Data6(BF_out[6]) ,.Data7(BF_out[7]) ,
							  .Data8(BF_out[8]),.Data9(BF_out[9]),.Data10(BF_out[10]),.Data11(BF_out[11]),.Data12(BF_out[12]),.Data13(BF_out[13]),.Data14(BF_out[14]),.Data15(BF_out[15]),
							  .Add0(Add_sel[3:0]) ,.Add1(Add_sel[7:4]) ,.Add2(Add_sel[11:8]) ,.Add3(Add_sel[15:12]) ,.Add4(Add_sel[19:16]) ,.Add5(Add_sel[23:20]),.Add6(Add_sel[27:24]),.Add7(Add_sel[31:28]),.Add8(Add_sel[35:32]),.Add9(Add_sel[39:36]),
							  .Add10(Add_sel[43:40]),.Add11(Add_sel[47:44]),.Add12(Add_sel[51:48]),.Add13(Add_sel[55:52]),.Add14(Add_sel[59:56]),.Add15(Add_sel[63:60]),
							  .reg0(M[0]) ,.reg1(M[1]) ,.reg2(M[2]) ,.reg3(M[3]) ,.reg4(M[4]) ,.reg5(M[5]) ,.reg6(M[6]),.reg7(M[7]),.reg8(M[8]),.reg9(M[9]),
							  .reg10(M[10]),.reg11(M[11]),.reg12(M[12]),.reg13(M[13]),.reg14(M[14]),.reg15(M[15]),
							  .CLK(CLK),.RST(RST)
						  );

	control con_unit (.CLK(CLK),.RST(RST),.S(input_sel),.W_sel(twid_sel),.Add_sel(Add_sel),.RD_en(RD_en));

endmodule