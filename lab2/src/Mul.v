`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:05 08/26/2015 
// Design Name: 
// Module Name:    mul 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//module 2bitsMul(
//    wire input [115:0] A,
//    wire input [1:0] B,
//    reg output [15:0] Y
//    );

//module CAJITAS_MUL(
//	input wire [3:0] iA,
//	input wire [3:0] iB,
//	output reg [7:0] oY
//	);
//
//reg C1,C2,C3;
//reg Temp1,Temp2;
//	
//always @(*)
//begin
//	//R0
//	oY[0] = iA[0]&iB[0];
//	//R1
//	{C1,oY[1]} = (iA[0] & iB[1]) + (iA[1] & iB[0]);
//	//R2
//	{C1,Temp1[0]} = (iA[2] & iB[0]) + (iA[1] & iB[1])+ C1;
//	{C2,oY[2]} = (iA[0] & iB[2]) + Temp1[0];
//	//R3
//	{C1,Temp1[1]} = (iA[3] & iB[0]) + (iA[2] & iB[1]) + C1;
//	{C2,Temp2[0]} = (iA[1] & iB[2]) + Temp1[1] + C2;
//	{C3,oY[3]}   = (iA[0] & iB[3]) + Temp2[0];
//	//R4
//	{C1,Temp1[2]} = (iA[3] & iB[1]) + C1;
//	{C2,Temp2[1]} = (iA[2] & iB[2]) + Temp1[2] + C2;
//	{C3,oY[4]} = (iA[1] & iB[3]) + Temp2[1] + C3;
//	//R5
//	{C2,Temp2[2]} = (iA[3] & iB[2]) + C2 + C1;
//	{C3,oY[5]} = (iA[2] & iB[3]) + Temp2[2] + C3;
//	//R6 y R7.
//	{oY[7],oY[6]} = (iA[3] & iB[3]) + C2 + C3; 
//end
//endmodule

module MUL_CUATRO_BITS(
input wire [3:0] iA,
input wire [3:0] iB,
output wire [7:0] oY
);
wire wCA0,wCA1,wCA2,wCA3;
wire woYA0,woYA1,woYA2,woYA3;
wire wCB0,wCB1,wCB2,wCB3;
wire woYB0,woYB1,woYB2,woYB3;
wire wCC0,wCC1,wCC2,wCC3;
wire woYC0,woYC1,woYC2,woYC3;

//Nivel A
assign {wCA0,woYA0} =(iA[0]&iB[1])+(iA[1]&iB[0]);
assign {wCA1,woYA1} =(iA[2]&iB[0])+(iA[1]&iB[1])+wCA0;
assign {wCA2,woYA2} =(iA[3]&iB[0])+(iA[2]&iB[1])+wCA1;
assign {wCA3,woYA3} =(iA[3]&iB[1])+wCA2;
//NIvel B
assign {wCB0,woYB0} =woYA1+(iA[0]&iB[2]);
assign {wCB1,woYB1} =woYA2+(iA[1]&iB[2])+wCB0;
assign {wCB2,woYB2} =woYA3+(iA[2]&iB[2])+wCB1;
assign {wCB3,woYB3} =wCA3+(iA[3]&iB[2])+wCB2;
//Nivel C
assign {wCC0,woYC0} =woYB1+(iA[0]&iB[3]);
assign {wCC1,woYC1} =woYB2+(iA[1]&iB[3])+wCC0;
assign {wCC2,woYC2} =woYB3+(iA[2]&iB[3])+wCC1;
assign {wCC3,woYC3} =wCB3+(iA[3]&iB[3])+wCC2;
assign oY ={wCC3,woYC3,woYC2,woYC1,woYC0,woYB0,woYA0,(iA[0]&iB[0])};
endmodule

