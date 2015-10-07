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
	1: oInstruction = { `STO , `R7,16'hcafe };
	2: oInstruction = { `NOP ,	24'd4000    }; 
	3: oInstruction = { `STO , `R6,16'h7 };
	4: oInstruction = { `NOP ,  24'd4000    };
	5: oInstruction = { `SWR ,	8'hff,`R7,`R6 };
	6: oInstruction = { `NOP ,  24'd4000    };
	7: oInstruction = { `NOP ,  24'd4000    };
	8: oInstruction = { `NOP ,  24'd4000    };
	9: oInstruction = { `NOP ,  24'd4000    };
	10: oInstruction = { `STO , `R6,16'h7 };
	11: oInstruction = { `NOP ,  24'd4000    };
	12: oInstruction = { `NOP ,  24'd4000    };
	13: oInstruction = { `SRD ,	`R2,8'hff,`R6 };
	14: oInstruction = { `NOP ,  24'd4000    };
	15: oInstruction = { `LED ,8'b0,`R2,8'b0 };

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
