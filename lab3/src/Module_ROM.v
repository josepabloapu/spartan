`timescale 1ns / 1ps
`include "Defintions.v"

`define LOOP1 8'd8
`define LOOP2 8'd5
module ROM
(
	input  wire[15:0]  		iAddress,
	output reg [27:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)


	0: oInstruction = { `NOP , 24'd4000    	 };
	1: oInstruction = { `STO , R7,16'h13   	 };
	2: oInstruction = { `NOP , 24'd4000    	 }; 
	3: oInstruction = { `STO , R6,16'h7    	 };
	0: oInstruction = { `NOP , 24'd4000      };
	5: oInstruction = { `SRD , 8'b0,`R7,8'b0 };
	6: oInstruction = { `LED , 8'b0,`R7,8'b0 };

/*	
	SRREAD, `R8, `R7, 8,b0 // r8 = SRAM[ R7 ]
   SRWRITE, `R9, `R5	
	SRREAD, `R8, `R7, 8,b0 // r8 = SRAM[ R7 ]
   oInstruction = { `LED ,8'b0,`R7,8'b0 };
*/

	default:
		oInstruction = { `LED ,  24'b10101010 };		//NOP
	endcase	
end
	
endmodule
