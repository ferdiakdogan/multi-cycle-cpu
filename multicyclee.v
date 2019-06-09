// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
// CREATED		"Tue Apr 30 02:11:41 2019"

module multicyclee(
	clk
);


input wire	clk;

wire	AdrSrc;
wire	[2:0] ALU_Control;
wire	[3:0] ALU_Flags;
wire	ALU_Op;
wire	AluSrcA;
wire	[1:0] AluSrcB;
wire	[23:0] data;
wire	[23:0] IR_Out;
wire	IRWrite;
wire	MemWrite;
wire	[7:0] PC_Out;
wire	PCWrite;
wire	[7:0] regout;
wire	[2:0] RegSrc;
wire	RegWrite;
wire	[23:0] result;
wire	[1:0] ResultSrc;
wire	[2:0] SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	[7:0] SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	[7:0] SYNTHESIZED_WIRE_20;
wire	[23:0] SYNTHESIZED_WIRE_21;
wire	[7:0] SYNTHESIZED_WIRE_10;
wire	[7:0] SYNTHESIZED_WIRE_11;
wire	[7:0] SYNTHESIZED_WIRE_13;
wire	[7:0] SYNTHESIZED_WIRE_14;
wire	[2:0] SYNTHESIZED_WIRE_15;
wire	[2:0] SYNTHESIZED_WIRE_17;
wire	[2:0] SYNTHESIZED_WIRE_18;
wire	[2:0] SYNTHESIZED_WIRE_19;





PCregister	b2v_inst(
	.clk(clk),
	.en(PCWrite),
	.D(result[7:0]),
	.Q(PC_Out));


Mux_2x1	b2v_inst1(
	.select(RegSrc[2]),
	.I0(IR_Out[11:9]),
	.I1(SYNTHESIZED_WIRE_0),
	.mux_output(SYNTHESIZED_WIRE_19));


RegR	b2v_inst10(
	.clk(clk),
	.in1(SYNTHESIZED_WIRE_1),
	.in2(SYNTHESIZED_WIRE_2),
	.out1(SYNTHESIZED_WIRE_3),
	.out2(regout));


shifter	b2v_inst11(
	.imm(IR_Out[18]),
	.in(SYNTHESIZED_WIRE_3),
	.instr(IR_Out[8:3]),
	.out(SYNTHESIZED_WIRE_10));


mux4x1	b2v_inst13(
	.I0(regout),
	.I1(IR_Out[7:0]),
	.I2(SYNTHESIZED_WIRE_4),
	.I3(SYNTHESIZED_WIRE_5),
	.select(AluSrcB),
	.Y(SYNTHESIZED_WIRE_7));


alu	b2v_inst14(
	.ALUOp(ALU_Op),
	.ALUSrcA(AluSrcA),
	.ALUControl(ALU_Control),
	.SrcA(SYNTHESIZED_WIRE_6),
	.SrcB(SYNTHESIZED_WIRE_7),
	.ALUFlags(ALU_Flags),
	.ALUResult(SYNTHESIZED_WIRE_20));


register	b2v_inst15(
	.clk(clk),
	.in(SYNTHESIZED_WIRE_20),
	.out(SYNTHESIZED_WIRE_11));


register24	b2v_inst17(
	.clk(clk),
	.in(SYNTHESIZED_WIRE_21),
	.out(data));


lpm_constant_0	b2v_inst19(
	.result(SYNTHESIZED_WIRE_15));


lpm_constant_1	b2v_inst2(
	.result(SYNTHESIZED_WIRE_0));


lpm_constant_2	b2v_inst20(
	.result(SYNTHESIZED_WIRE_5));


lpm_constant_3	b2v_inst21(
	.result(SYNTHESIZED_WIRE_4));


lpm_constant_4	b2v_inst23(
	.result(SYNTHESIZED_WIRE_13));


Mux_2x1	b2v_inst25(
	.select(RegSrc[1]),
	.I0(IR_Out[2:0]),
	.I1(IR_Out[11:9]),
	.mux_output(SYNTHESIZED_WIRE_18));


Mux_2x1_8	b2v_inst26(
	.select(AluSrcA),
	.I0(SYNTHESIZED_WIRE_10),
	.I1(PC_Out),
	.mux_output(SYNTHESIZED_WIRE_6));


Mux_2x1_8	b2v_inst27(
	.select(AdrSrc),
	.I0(PC_Out),
	.I1(result[7:0]),
	.mux_output(SYNTHESIZED_WIRE_14));


mux4x1_24	b2v_inst28(
	.I0(SYNTHESIZED_WIRE_11),
	.I1(data),
	.I2(SYNTHESIZED_WIRE_20),
	.I3(SYNTHESIZED_WIRE_13),
	.select(ResultSrc),
	.Y(result));


memory	b2v_inst3(
	.clk(clk),
	.write_enable(MemWrite),
	.address(SYNTHESIZED_WIRE_14),
	.in(regout),
	.out(SYNTHESIZED_WIRE_21));


Mux_2x1	b2v_inst30(
	.select(RegSrc[0]),
	.I0(IR_Out[14:12]),
	.I1(SYNTHESIZED_WIRE_15),
	.mux_output(SYNTHESIZED_WIRE_17));


InstReg	b2v_inst5(
	.clk(clk),
	.en(IRWrite),
	.in(SYNTHESIZED_WIRE_21),
	.out(IR_Out));


controller	b2v_inst7(
	.clk(clk),
	.flag(ALU_Flags),
	.IRout(IR_Out),
	.PCWrite(PCWrite),
	.MemWrite(MemWrite),
	.IRWrite(IRWrite),
	.ALUOp(ALU_Op),
	.ALUSrcA(AluSrcA),
	.RegWrite(RegWrite),
	.AdrSrc(AdrSrc),
	.ALUControl(ALU_Control),
	.ALUSrcB(AluSrcB),
	.RegSrc(RegSrc),
	.ResultSrc(ResultSrc));
	defparam	b2v_inst7.s0 = 4'b0000;
	defparam	b2v_inst7.s1 = 4'b0001;
	defparam	b2v_inst7.s10 = 4'b1010;
	defparam	b2v_inst7.s11 = 4'b1011;
	defparam	b2v_inst7.s12 = 4'b1100;
	defparam	b2v_inst7.s13 = 4'b1101;
	defparam	b2v_inst7.s14 = 4'b1110;
	defparam	b2v_inst7.s15 = 4'b1111;
	defparam	b2v_inst7.s2 = 4'b0010;
	defparam	b2v_inst7.s3 = 4'b0011;
	defparam	b2v_inst7.s4 = 4'b0100;
	defparam	b2v_inst7.s5 = 4'b0101;
	defparam	b2v_inst7.s6 = 4'b0110;
	defparam	b2v_inst7.s7 = 4'b0111;
	defparam	b2v_inst7.s8 = 4'b1000;
	defparam	b2v_inst7.s9 = 4'b1001;


regfile	b2v_inst8(
	.clk(clk),
	.WE(RegWrite),
	.address1(SYNTHESIZED_WIRE_17),
	.address2(SYNTHESIZED_WIRE_18),
	.data(result[7:0]),
	.destadd(SYNTHESIZED_WIRE_19),
	.R7(result[7:0]),
	.RD1(SYNTHESIZED_WIRE_1),
	.RD2(SYNTHESIZED_WIRE_2));


endmodule

module lpm_constant_0(result);
/* synthesis black_box */

output [2:0] result;

endmodule

module lpm_constant_1(result);
/* synthesis black_box */

output [2:0] result;

endmodule

module lpm_constant_2(result);
/* synthesis black_box */

output [7:0] result;

endmodule

module lpm_constant_3(result);
/* synthesis black_box */

output [7:0] result;

endmodule

module lpm_constant_4(result);
/* synthesis black_box */

output [7:0] result;

endmodule
