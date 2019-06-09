module Mux_2x1_8 (select, I0, I1, mux_output);
	
	
	
	input select;
	input  [7:0] I0, I1;
	output reg [7:0] mux_output;
	
	always @(*)
		begin
			case (select)
				
				0:	mux_output = I0;
				1:	mux_output = I1;
			
			endcase
		end
endmodule
	