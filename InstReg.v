module InstReg (clk, in, out, en);

	input clk, en;
	input [23:0] in;
	output reg [23:0] out;
	
	always @(posedge clk)
	if (clk == 1 & en == 1)
		out <= in;

endmodule 