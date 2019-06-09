module controller(clk, flag, PCWrite, MemWrite, IRWrite, 
						ALUControl , ALUOp, ALUSrcA, ALUSrcB , RegWrite, ResultSrc , RegSrc  , AdrSrc, IRout);

// opcode, clock, and reset inputs

input			clk;
input [23:0] IRout;
input [3:0]  flag;

// control signal outputs
output reg	PCWrite, MemWrite, IRWrite, ALUSrcA, RegWrite, ALUOp , AdrSrc; 
output reg [1:0] ALUSrcB , ResultSrc ;
output reg [2:0] ALUControl , RegSrc;

// ~~~~~~~~~~~~~~~~~~~ REGISTER ~~~~~~~~~~~~~~~~~~~ //

// 4-bit state register
reg [3:0]	state;

// ~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~ //

// state parameters
parameter s0 = 4'b0000;
parameter s1 = 4'b0001;
parameter s2 = 4'b0010;
parameter s3 = 4'b0011;
parameter s4 = 4'b0100;
parameter s5 = 4'b0101;
parameter s6 = 4'b0110;
parameter s7 = 4'b0111;
parameter s8 = 4'b1000;
parameter s9 = 4'b1001;
parameter s10 = 4'b1010;
parameter s11 = 4'b1011;
parameter s12 = 4'b1100;
parameter s13 = 4'b1101;
parameter s14 = 4'b1110;
parameter s15 = 4'b1111;


// ~~~~~~~~~~~~~~~~~~~ STATE MACHINE ~~~~~~~~~~~~~~~~~~~ //
// control state machine
always @(posedge clk) begin

		case (state)
		s0: begin
				PCWrite 		<= 1;
				ALUOp 		<= 1;
				ALUControl [2:0]  <= 3'b000;
				ALUSrcA 		<= 1;
				ALUSrcB [1:0] 		<= 2'b10;
				ResultSrc [1:0]	<= 2'b10;
				AdrSrc      <= 0; 
				MemWrite    <= 0; 
				IRWrite     <= 1; 
				RegWrite    <= 0; 
				RegSrc [2:0]      <= 3'b000; 
				state <= s1;
		end
		
		s1: begin
		      PCWrite 		<= 0;
		      IRWrite 		<= 0;
				ALUOp 		<= 1;
				ALUControl [2:0]  <= 3'b000;
				ALUSrcA 		<= 1;
				ALUSrcB [1:0] 		<= 2'b10;
				ResultSrc [1:0]	<= 2'b10;
				AdrSrc      <= 0; 
				MemWrite    <= 0; 
				RegWrite    <= 0; 
				RegSrc [2:0]      <= 3'b000;	
			   state <= s2;
		end
		
		s2: begin
		
		if (IRout[18]==1 && IRout[22:21]== 2'b00) // Reg Operation with Immediate
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b00;
				ALUControl [2:0]  <= IRout[17:15];
				RegSrc [2:0] 		<= 3'b000;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0; 
				state <= s3;
		end
		else if (IRout[18]==0 && IRout[22:21]== 2'b00) // Reg Operation with Register 
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b00;
				ResultSrc [1:0]	<= 2'b00;
				ALUControl [2:0]  <= IRout[17:15];
				RegSrc [2:0]      <= 3'b000;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s4;
		end
		
		else if (IRout[20:19]==2'b01 && IRout[22:21]== 2'b01 && IRout[18]==0 ) // LDR
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b11;
				ResultSrc [1:0]	<= 2'b00;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b000;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s5;
		end
			
		else if (IRout[20:19]==2'b10 && IRout[22:21]== 2'b01) // STR
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b01;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b010;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s7;
		end
		
		else if (IRout[22:21]==2'b10 && flag[0] ==1 && IRout[20:19]==2'b00 ) // BEQ
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b011;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s10;
		end
		else if (IRout[22:21]==2'b10 && flag[0] ==0 && IRout[20:19]==2'b00 ) // BNE
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b011;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s10;
		end
		else if (IRout[22:21]==2'b10 && IRout[20:19]==2'b01) // B
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b011;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s10;
		end
			
			else if (IRout[22:21]==2'b10 && flag[3] ==1 && IRout[20:19]==2'b10) // BCS
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b011;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s10;
			end
			
			else if (IRout[22:21]==2'b10 && IRout[20:19]==2'b11 && IRout[23] == 1'b0) // BL
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b111;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s12;
			end
			
			else if (IRout[22:21]==2'b10  && IRout[20:19]==2'b11 && IRout[23] == 1'b1) // BLI
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b111;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s12;
			end
			
			else if (IRout[22:21]==2'b11) // shift
		begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b11;
				ResultSrc [1:0]	<= 2'b00;
				ALUControl [2:0]  <= IRout[17:15];
				RegSrc [2:0] 		<= 3'b000;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0; 
				state <= s3;
		end
		end
		s3: begin
				ALUOp 		<= 0;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b00;
				ResultSrc [1:0]	<= 2'b00;
				ALUControl [2:0]  <= 3'b000;
				RegWrite    <= 1 ;
				PCWrite 		<= 0;
				AdrSrc      <= 0;
				PCWrite     <= 0; 
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegSrc [2:0]      <= 3'b000;
				state <= s0;
		end

		s4: begin
				ALUOp 		<= 0;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b00;
				ResultSrc [1:0]	<= 2'b00;
				ALUControl [2:0]  <= 3'b000;
				RegWrite    <= 1 ;
				RegSrc [2:0] 		<= 3'b000;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				state <= s0;
		end		
		s5: begin
				ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b11;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0] 		<= 3'b000;
	         PCWrite 		<= 0;
				AdrSrc      <= 1;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s6;
		end
		
		s6: begin
		      AdrSrc      <= 0;
				ResultSrc [1:0]	<= 2'b01;
				RegWrite    <= 1;
            ALUOp 		<= 0;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b11;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0] 		<= 3'b000;
	         PCWrite 		<= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 			
				state <= s9;
		end
		
		s9: begin
		      AdrSrc      <= 0;
				ResultSrc [1:0]	<= 2'b10;
				MemWrite    <= 0;	
	         ALUOp 		<= 1;
				ALUSrcA 		<= 1;
				ALUSrcB [1:0] 		<= 2'b11;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0] 		<= 3'b010;
	         PCWrite 		<= 0;
				IRWrite     <= 0; 
				RegWrite    <= 0;			
				state <= s0;
				end
		
		s7: begin
		      AdrSrc      <= 1;
				ResultSrc [1:0]	<= 2'b10;
				MemWrite    <= 1;	
	         ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b11;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0] 		<= 3'b010;
	         PCWrite 		<= 0;
				IRWrite     <= 0; 
				RegWrite    <= 0;			
				state <= s8;
		end
		
		s8: begin
		      AdrSrc      <= 1;
				ResultSrc [1:0]	<= 2'b10;
				MemWrite    <= 0;	
	         ALUOp 		<= 1;
				ALUSrcA 		<= 1;
				ALUSrcB [1:0] 		<= 2'b11;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0] 		<= 3'b010;
	         PCWrite 		<= 0;
				IRWrite     <= 0; 
				RegWrite    <= 0;			
				state <= s0;
		end
		
		s10: begin
		      ALUOp 		<= 1;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b01;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b011;
	         PCWrite 		<= 1;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s11;
		end
		
		s11: begin
		      ALUOp 		<= 1;
				ALUSrcA 		<= 1;
				ALUSrcB [1:0] 		<= 2'b11;
				ResultSrc [1:0]	<= 2'b10;
				ALUControl [2:0]  <= 3'b000;
				RegSrc [2:0]      <= 3'b011;
	         PCWrite 		<= 0;
				AdrSrc      <= 0;
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegWrite    <= 0;
				state <= s0;
		     end
		s12: begin
		      ALUOp 		<= 0;
				ALUSrcA 		<= 0;
				ALUSrcB [1:0] 		<= 2'b00;
				ResultSrc [1:0]	<= 2'b00;
				ALUControl [2:0]  <= 3'b000;
				RegWrite    <= 1 ;
				PCWrite 		<= 0;
				AdrSrc      <= 0;
				PCWrite     <= 0; 
				MemWrite    <= 0; 
				IRWrite     <= 0; 
				RegSrc [2:0]      <= 3'b000;
				state <= s10;
			
		end
		
		endcase 
		end
		
		endmodule
		