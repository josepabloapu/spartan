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


	0: oInstruction = { `NOP ,  24'd4000    };
	1: oInstruction = { `STO , `R7,16'hffff };
	2: oInstruction = { `NOP ,	24'd4000    }; 
	3: oInstruction = { `STO , `R6,16'hffff };
	4: oInstruction = { `JMP ,  8'd1,16'b0  };
	
	default:
		oInstruction = { `LED ,  24'b10101010 };		//NOP
	endcase	
end
	
endmodule
