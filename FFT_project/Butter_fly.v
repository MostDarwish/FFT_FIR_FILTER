module Butter_fly(in_1,in_2,out_1,out_2);

	input [31:0] in_1,in_2;
	output [31:0] out_1,out_2;

	assign out_1 = in_1	+ in_2;
	assign out_2 = in_1 - in_2; 

endmodule