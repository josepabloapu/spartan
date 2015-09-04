`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:05 08/26/2015 
// Design Name: 
// Module Name:    MUL_MUX 
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

module MUL_MUX(
input wire [1:0] iB,
input wire [7:0] iA,
output reg [15:0] oOut
);

always @(iB)
begin
case (iB)
2'b00: oOut=0;
2'b01: oOut=iA;
2'b10: oOut=(iA<<1);
2'b11: oOut=(iA<<1)+iA;
endcase
end
endmodule
