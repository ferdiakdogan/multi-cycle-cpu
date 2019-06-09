module register24 (clk, in, out);

	input clk;
	input [23:0] in;
	output reg [23:0] out;
	
	always @(posedge clk)
		out <= in;

endmodule 