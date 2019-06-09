module RegR (clk, in1, out1, in2, out2);

	input clk;
	input [7:0] in1, in2;
	output reg [7:0] out1, out2;
	
	always @(posedge clk)
	begin
		out1 <= in1;
		out2 <= in2;
   end
endmodule 