`timescale 1ns / 1ps
`include "Definitions.v" 


module Colores(
	input wire Clock,
	input wire iVideoOn,
	input wire [1:0] iSnakeWorldPixel,
	input wire [1:0] iFoodIcon,
	input wire [2:0] iIcon,
	output reg [11:0] oRGB
);

always @(posedge Clock)
begin
	if ((!iVideoOn))
		oRGB = `COLOR_BLACK;
	else
	begin
		if(iIcon != 3'b000)
		begin
			case(iIcon)
				3'b001:oRGB = `COLOR_RED;
				3'b010:oRGB = `COLOR_CYAN;
				3'b011:oRGB = `COLOR_MAGENTA;
				3'b100:oRGB = `COLOR_BLUE;
				3'b101:oRGB = `COLOR_GREEN;
			endcase
		end
		if(iFoodIcon==2'b11)
			oRGB = `COLOR_GREEN;
		case(iSnakeWorldPixel)
			2'b00: oRGB = `COLOR_BLACK;
			2'b01: oRGB = `COLOR_GREEN;
			2'b10: oRGB = `COLOR_BLUE;
		endcase
	end
end
endmodule
