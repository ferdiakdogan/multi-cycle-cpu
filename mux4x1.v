module mux4x1(Y, I0, I1, I2, I3, select);
//*********************************************************
 output [7:0] Y;
 input [7:0] I0, I1, I2, I3;
 input [1:0] select;
 reg [7:0] Y;

 always @(*)
 case ( select )
 2'b00: Y = I0;
 2'b01: Y = I1;
 2'b10: Y = I2;
 2'b11: Y = I3;
 default: Y = 8'bxxxxxxxx;
 endcase

 endmodule
 