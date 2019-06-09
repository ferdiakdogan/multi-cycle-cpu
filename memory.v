module memory (clk, address, out, write_enable, in);
	
	input clk, write_enable;
	input [7:0] address;
	input [7:0] in;
	output reg [23:0] out;
	
	reg [23:0] Memory_File [255:0];
	
	initial 
	begin	
			   Memory_File[8'b10000000] = 24'b000001000000001000000111; // ADD R1, R0, 7
				Memory_File[8'b10000100] = 24'b000001001001000000000011; // SUB R0, R1, #0x3
				Memory_File[8'b10001000] = 24'b000000000001000000000000; // ADD R0, R1, R0
				Memory_File[8'b10001100] = 24'b001100000001000000000000; // STR R0 [R1]
				Memory_File[8'b10010000] = 24'b001010000001011000000000; // LDR R3 [R1]
				Memory_File[8'b10010100] = 24'b000001001001000000000011; // SUB R0, R1, #0x3
				Memory_File[8'b10011000] = 24'b000001011001000000000001; // ORR R0, R1, #0X1
		      Memory_File[8'b10011100] = 24'b011000000000000010000000; // LSL R0, R0, #2 
				Memory_File[8'b10100000] = 24'b000000001000000000000000; // SUB R0, R0, R0
		      Memory_File[8'b10100100] = 24'b010001000000000111011100; // BEQ TURN BACK 		
				
			/*	Memory_File[8'b100000000] = 24'b000001000000001000100111; // ADD R1, R0, 7
				Memory_File[8'b100000100] = 24'b000001100001001111111111; // XOR R1, R1, R1
				Memory_File[8'b100001000] = 24'b000001000001001000000001; // ADD R1, R1, 1
		      Memory_File[8'b100001100] = 24'b000001011001001000000000; // ORR R1, R1 ,0   */
	end 
	
	always @(posedge clk)
	begin
	
		out = Memory_File[address];
		
	if (write_enable == 1)
		begin
				Memory_File[address] <= in;
		end
	end

endmodule
