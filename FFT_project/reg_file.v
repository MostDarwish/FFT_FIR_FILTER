module reg_file(Data0,Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,Data9,Data10,Data11,Data12,Data13,Data14,Data15,
				Add0,Add1,Add2,Add3,Add4,Add5,Add6,Add7,Add8,Add9,Add10,Add11,Add12,Add13,Add14,Add15,
				reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,
				CLK,RST);

	input [31:0] Data0,Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,Data9,Data10,Data11,Data12,Data13,Data14,Data15;
	input [3:0] Add0,Add1,Add2,Add3,Add4,Add5,Add6,Add7,Add8,Add9,Add10,Add11,Add12,Add13,Add14,Add15;
	input CLK,RST;
	output reg [31:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15;

	reg [31:0] register [0:15];

	always @(posedge CLK) begin
		
		if(~RST) begin
			register[0]  <= 0; register[1]  <= 0; register[2]  <= 0; register[3]  <= 0; 
			register[4]  <= 0; register[5]  <= 0; register[6]  <= 0; register[7]  <= 0; 
			register[8]  <= 0; register[9]  <= 0; register[10] <= 0; register[11] <= 0; 
			register[12] <= 0; register[13] <= 0; register[14] <= 0; register[15] <= 0;
		end
		else begin
			register[Add0]  <= Data0; register[Add1]   <= Data1; register[Add2]   <= Data2; register[Add3]   <= Data3;
			register[Add4]  <= Data4; register[Add5]   <= Data5; register[Add6]   <= Data6; register[Add7]   <= Data7;
			register[Add8]  <= Data8; register[Add9]   <= Data9; register[Add10]  <= Data10; register[Add11] <= Data11;
			register[Add12] <= Data12; register[Add13] <= Data13; register[Add14] <= Data14; register[Add15] <= Data15;
		end

	end

	always@(*)begin

			reg0  = register[0];
			reg1  = register[1];
			reg2  = register[2];
			reg3  = register[3];
			reg4  = register[4];
			reg5  = register[5];
			reg6  = register[6];
			reg7  = register[7];
			reg8  = register[8];
			reg9  = register[9];
			reg10 = register[10];
			reg11 = register[11];
			reg12 = register[12];
			reg13 = register[13];
			reg14 = register[14];
			reg15 = register[15];
	end

endmodule