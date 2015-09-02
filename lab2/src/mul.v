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


assign ResultMul[2] = A[2]&B[0]+A[1]&B[1]+ A[0]&B[2]};


endmodule
