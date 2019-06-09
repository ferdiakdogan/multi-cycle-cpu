module alu (ALUControl, ALUOp, SrcA, SrcB, ALUFlags, ALUResult,ALUSrcA);
   
	input  ALUOp, ALUSrcA;
	input [2:0] ALUControl;
	input [7:0] SrcA, SrcB;
	reg CO, OVF, Z, N;
	output reg [3:0] ALUFlags;
	output reg [7:0] ALUResult;
	wire [8:0] sum ;
	wire [8:0] a ;
	wire [8:0] b ;
	assign sum = a + b ;
	
	always @(*)
		begin
		
		if (ALUOp == 1)
			begin
			case(ALUControl) 
					3'b000:	
						begin
						   
							ALUResult = SrcA + SrcB;
							CO  = sum[8];
							OVF = (~SrcA[7] & ~SrcB[7] & ALUResult[7]) | (SrcA[7] & SrcB[7] & ~ALUResult[7]) ;
							Z   = (ALUResult == 0);
							N	 =  ALUResult[7];
							end 
					
					3'b001:
						begin
							ALUResult = SrcA - SrcB;
							CO  = (ALUResult[7]==0);
							OVF = (SrcA[7] & ~SrcB[7] & ~ALUResult[7]) | (~SrcA[7] & SrcB[7] & ALUResult[7]) ;
							Z   = (ALUResult == 0);
							N	 =  ALUResult[7];
						end
					3'b010:	
						begin
							ALUResult = SrcA & SrcB;
							CO = 0;
							OVF = 0;
							Z   = (ALUResult == 0);
							N	 =  ALUResult[7];
						end
					3'b011:	
						begin
							ALUResult = SrcA | SrcB;
							CO = 0;
							OVF = 0;
							Z   = (ALUResult == 0);
							N	 =  ALUResult[7];
						end
					3'b100:
					   begin 
						   ALUResult = SrcA ^ SrcB;
							CO = 0;
							OVF = 0;
							Z   = (ALUResult == 0);
							N	 =  ALUResult[7];
						end
					3'b101:
					   begin 
						   ALUResult = SrcA & 8'b0;
							CO = 0;
							OVF = 0;
							Z   = (ALUResult == 0);
							N	 =  ALUResult[7];
						end
			endcase
		end
		
		else
 	                  ALUResult = SrcB;	
		
			if (ALUSrcA == 0)
			begin
			ALUFlags = {CO,OVF,N,Z};
			end
		end
endmodule
