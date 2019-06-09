module shifter (instr, in, out, imm);
   input imm;
	input [5:0] instr;
	input [7:0] in;
	output reg [7:0] out;
	
	always @(*)
		begin
		
		if (imm == 0)
		begin
			if (instr[2:0] == 3'b000)
			 // LSL
					begin
						if (instr[5:3]==3'b000) out[7:0] = in[7:0];
						else if (instr[5:3]==3'b001) out[7:0] = {in[6:0],1'b0};
						else if (instr[5:3]==3'b010) out[7:0] = {in[5:0],2'b0};
						else if (instr[5:3]==3'b011) out[7:0] = {in[4:0],3'b0};
						else if (instr[5:3]==3'b100) out[7:0] = {in[3:0],4'b0};
						else if (instr[5:3]==3'b101) out[7:0] = {in[2:0],5'b0};
						else if (instr[5:3]==3'b110) out[7:0] = {in[1:0],6'b0};
						else if (instr[5:3]==3'b111) out[7:0] = {in[0],7'b0};						
					end	
				else if (instr[2:0] == 3'b001)
				//LSR
					begin
						if (instr[5:3]==3'b000) out[7:0] = in[7:0];
						else if (instr[5:3]==3'b001) out[7:0] = {1'b0,in[7:1]};
						else if (instr[5:3]==3'b010) out[7:0] = {2'b0,in[7:2]};
						else if (instr[5:3]==3'b011) out[7:0] = {3'b0,in[7:3]};
						else if (instr[5:3]==3'b100) out[7:0] = {4'b0,in[7:4]};
						else if (instr[5:3]==3'b101) out[7:0] = {5'b0,in[7:5]};
						else if (instr[5:3]==3'b110) out[7:0] = {6'b0,in[7:6]};
						else if (instr[5:3]==3'b111) out[7:0] = {7'b0,in[7]};
					
					end
				else if (instr[2:0] == 2'b010)
				//RSR
					begin
						if (instr[5:3]==3'b000) out[7:0] = in[7:0];
						else if (instr[5:3]==3'b001) out[7:0] = {in[0],in[7:1]};
						else if (instr[5:3]==3'b010) out[7:0] = {in[1:0],in[7:2]};
						else if (instr[5:3]==3'b011) out[7:0] = {in[2:0],in[7:3]};
						else if (instr[5:3]==3'b100) out[7:0] = {in[3:0],in[7:4]};
						else if (instr[5:3]==3'b101) out[7:0] = {in[4:0],in[7:5]};
						else if (instr[5:3]==3'b110) out[7:0] = {in[5:0],in[7:6]};
						else if (instr[5:3]==3'b111) out[7:0] = {in[6:0],in[7]};

					end
				else if (instr[2:0] == 3'b011)
			 // RSL
					begin
						if (instr[5:3]==3'b000) out[7:0] = in[7:0];
						else if (instr[5:3]==3'b001) out[7:0] = {in[6:0],in[7]};
						else if (instr[5:3]==3'b010) out[7:0] = {in[5:0],in[7:6]};
						else if (instr[5:3]==3'b011) out[7:0] = {in[4:0],in[7:5]};
						else if (instr[5:3]==3'b100) out[7:0] = {in[3:0],in[7:4]};
						else if (instr[5:3]==3'b101) out[7:0] = {in[2:0],in[7:3]};
						else if (instr[5:3]==3'b110) out[7:0] = {in[1:0],in[7:2]};
						else if (instr[5:3]==3'b111) out[7:0] = {in[0],in[7:1]};
						else out[7:0] = {in[1],7'b0};							
					end	
				else if (instr[2:0] == 3'b100)
				//ASR
					begin
						if (instr[5:3]==3'b000) out[7:0] = in[7:0];
						else if (instr[5:3]==3'b001) out[7:0] = {{1{in[7]}},in[7:1]};
						else if (instr[5:3]==3'b010) out[7:0] = {{2{in[7]}},in[7:2]};
						else if (instr[5:3]==3'b011) out[7:0] = {{3{in[7]}},in[7:3]};
						else if (instr[5:3]==3'b100) out[7:0] = {{4{in[7]}},in[7:4]};
						else if (instr[5:3]==3'b101) out[7:0] = {{5{in[7]}},in[7:5]};
						else if (instr[5:3]==3'b110) out[7:0] = {{6{in[7]}},in[7:6]};
						else if (instr[5:3]==3'b111) out[7:0] = {{7{in[7]}},in[7]};
				
					end		
		end else begin
		out[7:0] = in[7:0] ;
		end
		end
endmodule 
