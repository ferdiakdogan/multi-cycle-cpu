module PCregister (clk, D, Q, en);
input clk;
input en ;

input [7:0] D;
output[7:0] Q;
reg [7:0]Q;

initial begin
Q = 8'b10000000;
end
always @(posedge clk)

if (en==1'b1)
			Q <= D;
			
endmodule 


