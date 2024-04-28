module control(CLK,RST,S,W_sel,Add_sel,RD_en);

	input CLK,RST;
	output reg [27:0] S;
	output reg [23:0] W_sel;
	output reg [63:0] Add_sel;
	output reg RD_en;

	parameter stage_1 = 2'b00;
	parameter stage_2 = 2'b01;
	parameter stage_3 = 2'b10;
	parameter stage_4 = 2'b11;

	reg [1:0] cs,ns;

	always@(posedge CLK or negedge RST)begin

		if(~RST) cs <= 0;
		else cs <= ns;

	end

	always@(*)begin
		
		case(cs)

			stage_1: begin
						S = 28'h0;
						W_sel = 24'h0;
						Add_sel = 64'hFEDC_BA98_7654_3210;
						RD_en = 1;
					 end
			stage_2: begin 
						S = 28'hB55_555B;
						W_sel = 24'h820_820;
						Add_sel = 64'hFDEC_B9A8_7564_3120;
						RD_en = 0;
					 end
			stage_3: begin
						S = 28'hDA6_59AD;
						W_sel = 24'hD10_D10;
						Add_sel = 64'hFBEA_D9C8_7362_5140;
						RD_en = 0;
					 end
			stage_4: begin
						S = 28'hFEA_AABF;
						W_sel = 24'hFAC_688;
						Add_sel = 64'hF7E6_D5C4_B3A2_9180;
						RD_en = 0;
					 end

			default: begin
						S = 28'h0;
						W_sel = 24'h0;
						Add_sel = 64'hFEDC_BA98_7654_3210;
						RD_en = 1;
					 end
		endcase

	end

	always@(*)begin
		
		case(cs)

			stage_1: ns = stage_2;
			stage_2: ns = stage_3;
			stage_3: ns = stage_4;
			stage_4: ns = stage_1;

			default: ns = stage_1;

		endcase

	end

endmodule