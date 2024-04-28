module low_pass_filter(X,Y,CLK,RST);

	input CLK,RST;
	input  signed [15:0] X;
	output signed [31:0] Y;

	reg  signed [15:0] Window [0:66];   // these registers contains the last 67 sample from the input signal x[n]
	wire signed [15:0] FilCoeff_LUT [0:66]; // these registers contain the filter coeffecients h[n]
	wire signed [31:0] PartialProduct[0:66]; // each wire contains the product of 2 samples x and h

	//assigning filter coeffecients in the lookup table
	assign FilCoeff_LUT[0]  = 16'hFFF1;
	assign FilCoeff_LUT[1]  = 16'h0010;
	assign FilCoeff_LUT[2]  = 16'h001C;
	assign FilCoeff_LUT[3]  = 16'h0000;
	assign FilCoeff_LUT[4]  = 16'hFFD9;
	assign FilCoeff_LUT[5]  = 16'hFFE3;
	assign FilCoeff_LUT[6]  = 16'h0023;
	assign FilCoeff_LUT[7]  = 16'h0044;
	assign FilCoeff_LUT[8]  = 16'h0000;
	assign FilCoeff_LUT[9]  = 16'hFF9D;
	assign FilCoeff_LUT[10] = 16'hFFB7;
	assign FilCoeff_LUT[11] = 16'h0056;
	assign FilCoeff_LUT[12] = 16'h00A5;
	assign FilCoeff_LUT[13] = 16'h0000;
	assign FilCoeff_LUT[14] = 16'hFF1F;
	assign FilCoeff_LUT[15] = 16'hFF5E;
	assign FilCoeff_LUT[16] = 16'h00BB;
	assign FilCoeff_LUT[17] = 16'h015C;
	assign FilCoeff_LUT[18] = 16'h0000;
	assign FilCoeff_LUT[19] = 16'hFE35;
	assign FilCoeff_LUT[20] = 16'hFEBB;
	assign FilCoeff_LUT[21] = 16'h0175;
	assign FilCoeff_LUT[22] = 16'h02B6;
	assign FilCoeff_LUT[23] = 16'h0000;
	assign FilCoeff_LUT[24] = 16'hFC61;
	assign FilCoeff_LUT[25] = 16'hFD63;
	assign FilCoeff_LUT[26] = 16'h0315;
	assign FilCoeff_LUT[27] = 16'h05FC;
	assign FilCoeff_LUT[28] = 16'h0000;
	assign FilCoeff_LUT[29] = 16'hF6A3;
	assign FilCoeff_LUT[30] = 16'hF82B;
	assign FilCoeff_LUT[31] = 16'h0BDF;
	assign FilCoeff_LUT[32] = 16'h26A7;
	assign FilCoeff_LUT[33] = 16'h332E;
	assign FilCoeff_LUT[34] = 16'h26A7;
	assign FilCoeff_LUT[35] = 16'h0BDF;
	assign FilCoeff_LUT[36] = 16'hF82B;
	assign FilCoeff_LUT[37] = 16'hF6A3;
	assign FilCoeff_LUT[38] = 16'h0000;
	assign FilCoeff_LUT[39] = 16'h05FC;
	assign FilCoeff_LUT[40] = 16'h0315;
	assign FilCoeff_LUT[41] = 16'hFD63;
	assign FilCoeff_LUT[42] = 16'hFC61;
	assign FilCoeff_LUT[43] = 16'h0000;
	assign FilCoeff_LUT[44] = 16'h02B6;
	assign FilCoeff_LUT[45] = 16'h0175;
	assign FilCoeff_LUT[46] = 16'hFEBB;
	assign FilCoeff_LUT[47] = 16'hFE35;
	assign FilCoeff_LUT[48] = 16'h0000;
	assign FilCoeff_LUT[49] = 16'h015C;
	assign FilCoeff_LUT[50] = 16'h00BB;
	assign FilCoeff_LUT[51] = 16'hFF5E;
	assign FilCoeff_LUT[52] = 16'hFF1F;
	assign FilCoeff_LUT[53] = 16'h0000;
	assign FilCoeff_LUT[54] = 16'h00A5;
	assign FilCoeff_LUT[55] = 16'h0056;
	assign FilCoeff_LUT[56] = 16'hFFB7;
	assign FilCoeff_LUT[57] = 16'hFF9D;
	assign FilCoeff_LUT[58] = 16'h0000;
	assign FilCoeff_LUT[59] = 16'h0044;
	assign FilCoeff_LUT[60] = 16'h0023;
	assign FilCoeff_LUT[61] = 16'hFFE3;
	assign FilCoeff_LUT[62] = 16'hFFD9;
	assign FilCoeff_LUT[63] = 16'h0000;
	assign FilCoeff_LUT[64] = 16'h001C;
	assign FilCoeff_LUT[65] = 16'h0010;
	assign FilCoeff_LUT[66] = 16'hFFF1;

	//taking new sample and hold the last 67 sample (order of the filter) from the input
	always@(posedge CLK or negedge RST)begin
		
		if(~RST)begin
			Window[0]  <= 0;
			Window[1]  <= 0;
			Window[2]  <= 0;
			Window[3]  <= 0;
			Window[4]  <= 0;
			Window[5]  <= 0;
			Window[6]  <= 0;
			Window[7]  <= 0;
			Window[8]  <= 0;
			Window[9]  <= 0;
			Window[10] <= 0;
			Window[11] <= 0;
			Window[12] <= 0;
			Window[13] <= 0;
			Window[14] <= 0;
			Window[15] <= 0;
			Window[16] <= 0;
			Window[17] <= 0;
			Window[18] <= 0;
			Window[19] <= 0;
			Window[20] <= 0;
			Window[21] <= 0;
			Window[22] <= 0;
			Window[23] <= 0;
			Window[24] <= 0;
			Window[25] <= 0;
			Window[26] <= 0;
			Window[27] <= 0;
			Window[28] <= 0;
			Window[29] <= 0;
			Window[30] <= 0;
			Window[31] <= 0;
			Window[32] <= 0;
			Window[33] <= 0;
			Window[34] <= 0;
			Window[35] <= 0;
			Window[36] <= 0;
			Window[37] <= 0;
			Window[38] <= 0;
			Window[39] <= 0;
			Window[40] <= 0;
			Window[41] <= 0;
			Window[42] <= 0;
			Window[43] <= 0;
			Window[44] <= 0;
			Window[45] <= 0;
			Window[46] <= 0;
			Window[47] <= 0;
			Window[48] <= 0;
			Window[49] <= 0;
			Window[50] <= 0;
			Window[51] <= 0;
			Window[52] <= 0;
			Window[53] <= 0;
			Window[54] <= 0;
			Window[55] <= 0;
			Window[56] <= 0;
			Window[57] <= 0;
			Window[58] <= 0;
			Window[59] <= 0;
			Window[60] <= 0;
			Window[61] <= 0;
			Window[62] <= 0;
			Window[63] <= 0;
			Window[64] <= 0;
			Window[65] <= 0;
			Window[66] <= 0;
		end
		else begin
			Window[0]  <= X;
			Window[1]  <= Window[0];
			Window[2]  <= Window[1];
			Window[3]  <= Window[2];
			Window[4]  <= Window[3];
			Window[5]  <= Window[4];
			Window[6]  <= Window[5];
			Window[7]  <= Window[6];
			Window[8]  <= Window[7];
			Window[9]  <= Window[8];
			Window[10] <= Window[9];
			Window[11] <= Window[10];
			Window[12] <= Window[11];
			Window[13] <= Window[12];
			Window[14] <= Window[13];
			Window[15] <= Window[14];
			Window[16] <= Window[15];
			Window[17] <= Window[16];
			Window[18] <= Window[17];
			Window[19] <= Window[18];
			Window[20] <= Window[19];
			Window[21] <= Window[20];
			Window[22] <= Window[21];
			Window[23] <= Window[22];
			Window[24] <= Window[23];
			Window[25] <= Window[24];
			Window[26] <= Window[25];
			Window[27] <= Window[26];
			Window[28] <= Window[27];
			Window[29] <= Window[28];
			Window[30] <= Window[29];
			Window[31] <= Window[30];
			Window[32] <= Window[31];
			Window[33] <= Window[32];
			Window[34] <= Window[33];
			Window[35] <= Window[34];
			Window[36] <= Window[35];
			Window[37] <= Window[36];
			Window[38] <= Window[37];
			Window[39] <= Window[38];
			Window[40] <= Window[39];
			Window[41] <= Window[40];
			Window[42] <= Window[41];
			Window[43] <= Window[42];
			Window[44] <= Window[43];
			Window[45] <= Window[44];
			Window[46] <= Window[45];
			Window[47] <= Window[46];
			Window[48] <= Window[47];
			Window[49] <= Window[48];
			Window[50] <= Window[49];
			Window[51] <= Window[50];
			Window[52] <= Window[51];
			Window[53] <= Window[52];
			Window[54] <= Window[53];
			Window[55] <= Window[54];
			Window[56] <= Window[55];
			Window[57] <= Window[56];
			Window[58] <= Window[57];
			Window[59] <= Window[58];
			Window[60] <= Window[59];
			Window[61] <= Window[60];
			Window[62] <= Window[61];
			Window[63] <= Window[62];
			Window[64] <= Window[63];
			Window[65] <= Window[64];
			Window[66] <= Window[65];
		end
	end
	//multiplication of input samples with filter coeff at single time instance 
	assign PartialProduct[0]  = Window[0]  * FilCoeff_LUT[0];
	assign PartialProduct[1]  = Window[1]  * FilCoeff_LUT[1];
	assign PartialProduct[2]  = Window[2]  * FilCoeff_LUT[2];
	assign PartialProduct[3]  = Window[3]  * FilCoeff_LUT[3];
	assign PartialProduct[4]  = Window[4]  * FilCoeff_LUT[4];
	assign PartialProduct[5]  = Window[5]  * FilCoeff_LUT[5];
	assign PartialProduct[6]  = Window[6]  * FilCoeff_LUT[6];
	assign PartialProduct[7]  = Window[7]  * FilCoeff_LUT[7];
	assign PartialProduct[8]  = Window[8]  * FilCoeff_LUT[8];
	assign PartialProduct[9]  = Window[9]  * FilCoeff_LUT[9];
	assign PartialProduct[10] = Window[10] * FilCoeff_LUT[10];
	assign PartialProduct[11] = Window[11] * FilCoeff_LUT[11];
	assign PartialProduct[12] = Window[12] * FilCoeff_LUT[12];
	assign PartialProduct[13] = Window[13] * FilCoeff_LUT[13];
	assign PartialProduct[14] = Window[14] * FilCoeff_LUT[14];
	assign PartialProduct[15] = Window[15] * FilCoeff_LUT[15];
	assign PartialProduct[16] = Window[16] * FilCoeff_LUT[16];
	assign PartialProduct[17] = Window[17] * FilCoeff_LUT[17];
	assign PartialProduct[18] = Window[18] * FilCoeff_LUT[18];
	assign PartialProduct[19] = Window[19] * FilCoeff_LUT[19];
	assign PartialProduct[20] = Window[20] * FilCoeff_LUT[20];
	assign PartialProduct[21] = Window[21] * FilCoeff_LUT[21];
	assign PartialProduct[22] = Window[22] * FilCoeff_LUT[22];
	assign PartialProduct[23] = Window[23] * FilCoeff_LUT[23];
	assign PartialProduct[24] = Window[24] * FilCoeff_LUT[24];
	assign PartialProduct[25] = Window[25] * FilCoeff_LUT[25];
	assign PartialProduct[26] = Window[26] * FilCoeff_LUT[26];
	assign PartialProduct[27] = Window[27] * FilCoeff_LUT[27];
	assign PartialProduct[28] = Window[28] * FilCoeff_LUT[28];
	assign PartialProduct[29] = Window[29] * FilCoeff_LUT[29];
	assign PartialProduct[30] = Window[30] * FilCoeff_LUT[30];
	assign PartialProduct[31] = Window[31] * FilCoeff_LUT[31];
	assign PartialProduct[32] = Window[32] * FilCoeff_LUT[32];
	assign PartialProduct[33] = Window[33] * FilCoeff_LUT[33];
	assign PartialProduct[34] = Window[34] * FilCoeff_LUT[34];
	assign PartialProduct[35] = Window[35] * FilCoeff_LUT[35];
	assign PartialProduct[36] = Window[36] * FilCoeff_LUT[36];
	assign PartialProduct[37] = Window[37] * FilCoeff_LUT[37];
	assign PartialProduct[38] = Window[38] * FilCoeff_LUT[38];
	assign PartialProduct[39] = Window[39] * FilCoeff_LUT[39];
	assign PartialProduct[40] = Window[40] * FilCoeff_LUT[40];
	assign PartialProduct[41] = Window[41] * FilCoeff_LUT[41];
	assign PartialProduct[42] = Window[42] * FilCoeff_LUT[42];
	assign PartialProduct[43] = Window[43] * FilCoeff_LUT[43];
	assign PartialProduct[44] = Window[44] * FilCoeff_LUT[44];
	assign PartialProduct[45] = Window[45] * FilCoeff_LUT[45];
	assign PartialProduct[46] = Window[46] * FilCoeff_LUT[46];
	assign PartialProduct[47] = Window[47] * FilCoeff_LUT[47];
	assign PartialProduct[48] = Window[48] * FilCoeff_LUT[48];
	assign PartialProduct[49] = Window[49] * FilCoeff_LUT[49];
	assign PartialProduct[50] = Window[50] * FilCoeff_LUT[50];
	assign PartialProduct[51] = Window[51] * FilCoeff_LUT[51];
	assign PartialProduct[52] = Window[52] * FilCoeff_LUT[52];
	assign PartialProduct[53] = Window[53] * FilCoeff_LUT[53];
	assign PartialProduct[54] = Window[54] * FilCoeff_LUT[54];
	assign PartialProduct[55] = Window[55] * FilCoeff_LUT[55];
	assign PartialProduct[56] = Window[56] * FilCoeff_LUT[56];
	assign PartialProduct[57] = Window[57] * FilCoeff_LUT[57];
	assign PartialProduct[58] = Window[58] * FilCoeff_LUT[58];
	assign PartialProduct[59] = Window[59] * FilCoeff_LUT[59];
	assign PartialProduct[60] = Window[60] * FilCoeff_LUT[60];
	assign PartialProduct[61] = Window[61] * FilCoeff_LUT[61];
	assign PartialProduct[62] = Window[62] * FilCoeff_LUT[62];
	assign PartialProduct[63] = Window[63] * FilCoeff_LUT[63];
	assign PartialProduct[64] = Window[64] * FilCoeff_LUT[64];
	assign PartialProduct[65] = Window[65] * FilCoeff_LUT[65];
	assign PartialProduct[66] = Window[66] * FilCoeff_LUT[66];

	//calculating the output signal by summing the partial products
	assign Y = (PartialProduct[0]  + PartialProduct[1]  + PartialProduct[2]  + PartialProduct[3]  + PartialProduct[4]  +
			   PartialProduct[5]  + PartialProduct[6]  + PartialProduct[7]  + PartialProduct[8]  + PartialProduct[9]  + 
			   PartialProduct[10] + PartialProduct[11] + PartialProduct[12] + PartialProduct[13] + PartialProduct[14] + 
			   PartialProduct[15] + PartialProduct[16] + PartialProduct[17] + PartialProduct[18] + PartialProduct[19] + 
			   PartialProduct[20] + PartialProduct[21] + PartialProduct[22] + PartialProduct[23] + PartialProduct[24] +
			   PartialProduct[25] + PartialProduct[26] + PartialProduct[27] + PartialProduct[28] + PartialProduct[29] + 
			   PartialProduct[30] + PartialProduct[31] + PartialProduct[32] + PartialProduct[33] + PartialProduct[34] + 
			   PartialProduct[35] + PartialProduct[36] + PartialProduct[37] + PartialProduct[38] + PartialProduct[39] + 
			   PartialProduct[40] + PartialProduct[41] + PartialProduct[42] + PartialProduct[43] + PartialProduct[44] +
			   PartialProduct[45] + PartialProduct[46] + PartialProduct[47] + PartialProduct[48] + PartialProduct[49] + 
			   PartialProduct[50] + PartialProduct[51] + PartialProduct[52] + PartialProduct[53] + PartialProduct[54] + 
			   PartialProduct[55] + PartialProduct[56] + PartialProduct[57] + PartialProduct[58] + PartialProduct[59] + 
			   PartialProduct[60] + PartialProduct[61] + PartialProduct[62] + PartialProduct[63] + PartialProduct[64] + 
			   PartialProduct[65] + PartialProduct[66])/32768;
endmodule