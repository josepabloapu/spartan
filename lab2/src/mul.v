`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:05 08/26/2015 
// Design Name: 
// Module Name:    iMul 
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
module iMul(
    input [3:0] A,
    input [3:0] B,
    output [7:0] ResultMul
    );

reg Co1,Ci2a,Co2a,Co2b,Ci3a,Ci3b,Co3a,Co3b,Co3c; //Carries 
reg ResultMul; // Resultado


assign ResultMul[0] = A[0] & B[0];


//assign {CI,ResultMul[1]} = {A[1]&B[0]+A[0]&B[1]};
//assign {C2,}





assign ResultMul[1] = A[1]&B[0]^A[0]&B[1] ;
assign C1 = A[1]&B[0]&A[0]&B[1];

assign ResultMul[2] = {C1^A[1]&B[1]^A[2]&B[0]^A[0]&B[2]  };
assign C2 = {C1&A[1]&B[0]|C1&A[0]&B[1]|A[1]&B[0]&A[0]&B[1]};


assign ResultMul[2] = {A[2]&B[0]+A[1]&B[1]+ A[0]&B[2]};


endmodule
//////////////////////////////////
module mul_cuatro_bits(
input wire [3:0] wA,
input wire [3:0] wB,
output [7:0] out
);
reg wCA0,wCA1,wCA2,wCA3;
reg wOutA0,wOutA1,wOutA2,wOutA3;
reg wCB0,wCB1,wCB2,wCB3;
reg wOutB0,wOutB1,wOutB2,wOutB3;
reg wCC0,wCC1,wCC2,wCC3;
reg wOutC0,wOutC1,wOutC2,wOutC3;


//Nivel A
{wCA0,wOutA0}=(wA[0]&wB[1])+(wA[1]&wB[0]);
{wCA1,wOutA1}<=(wA[2]&wB[0])+(wA[1]&wB[1])+wCA0;
{wCA2,wOutA2}<=(wA[3]&wB[0])+(wA[2]&wB[1])+wCA1;
{wCA3,wOutA3}<=(wA[3]&wB[1])+wCA2;
//NIvel B
{wCB0,wOutB0}<=wOutA1+(wA[0]&wB[2]);
{wCB1,wOutB1}<=wOutA2+(wA[1]&wB[2])+wCB0;
{wCB2,wOutB2}<=wOutA3+(wA[2]&wB[2])+wCB1;
{wCB3,wOutB3}<=wCA3+(wA[3]&wB[2])+wCB2;
//Nivel C
{wCC0,wOutC0}<=wOutB1+(wA[0]&wB[3]);
{wCC1,wOutC1}<=wOutB2+(wA[1]&wB[3])+wCC0;
{wCC2,wOutC2}<=wOutB3+(wA[2]&wB[3])+wCC1;
{wCC3,wOutC3}<=wCB3+(wA[3]&wB[3])+wCC2;
out<={wCC3,wOutC3,wOutC2,wOutC1,wOutC0,wOutB0,wOutA0,(wA[0]&wB[0])};
endmodule		