module regfile (clk, address1, address2, destadd, RD1, RD2, WE, data, R7, r0, r1, r2, r3, r4, r5, pc, lr);
	
	input clk, WE;
	input [2:0] address1, address2, destadd;
	input [7:0] data, R7;
	output reg [7:0] RD1, RD2;
	output [7:0] r0, r1, r2, r3, r4, r5, pc,lr;	
	reg [7:0] regfile [7:0];
	
	assign r0 = regfile[0];
	assign r1 = regfile[1];
	assign r2 = regfile[2];
	assign r3 = regfile[3];
	assign r4 = regfile[4];
	assign r5 = regfile[5];
	assign pc = regfile[6];
	assign lr = regfile[7];
	
	initial begin
		regfile[0] = 0;
		regfile[1] = 0;
		regfile[2] = 0;
		regfile[3] = 0;
		regfile[4] = 0;
		regfile[5] = 0;
		regfile[6] = 0;
		regfile[7] = 0;
	end
		
	always @(*)
		begin
			RD1 = regfile[address1];
			RD2 = regfile[address2];
		end
		
	always @(posedge clk) 
		begin
			regfile[7] = R7;
			if (WE == 1)
				begin
					regfile[destadd] <= data;
				end
		end
endmodule

