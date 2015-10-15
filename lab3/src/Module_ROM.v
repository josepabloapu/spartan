
`timescale 1ns / 1ps
`include "Defintions.v"

module ROM
(
	input  wire[15:0]  		iAddress,
	output reg [27:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `NOP ,	24'd4000	};
	1: oInstruction = { `STO , `R1, 16'h10};
	2: oInstruction = { `STO , `R2, 16'h20};
	3: oInstruction = { `STO , `R3, 16'h30};
	4: oInstruction = { `STO , `R4, 8'b0, 8'b11000011};
	5: oInstruction = { `STO , `R5, 8'b0, 8'b11100111};
	6: oInstruction = { `STO , `R6, 8'b0, 8'b00100100};
	7: oInstruction = { `SWR , 8'hff, `R4, `R1};
	8: oInstruction = { `NOP ,	24'd4000	};
	9: oInstruction = { `NOP ,	24'd4000	};
	10: oInstruction = { `NOP ,	24'd4000	};
	11: oInstruction = { `SWR , 8'hff, `R5, `R2};
	12: oInstruction = { `NOP ,	24'd4000	};
	13: oInstruction = { `NOP ,	24'd4000	};
	14: oInstruction = { `NOP ,	24'd4000	};
	15: oInstruction = { `SWR , 8'hff, `R6, `R3};
	16: oInstruction = { `NOP ,	24'd4000	};
	17: oInstruction = { `NOP ,	24'd4000	};
	18: oInstruction = { `NOP ,	24'd4000	};
	19: oInstruction = { `SRD , `R7, 8'hff, `R1};
	//19: oInstruction = { `STO , `R7, 8'b0, `R4};
	20: oInstruction = { `NOP ,	24'd4000	};
	21: oInstruction = { `NOP ,	24'd4000	};
	22: oInstruction = { `NOP ,	24'd4000	};
	23: oInstruction = { `LED , 8'hff, 8'hff, `R7 };
	24: oInstruction = { `JMP , 8'd17, 16'b0 };



	default:
		oInstruction = { `LED ,  24'b10101010 };
	endcase	
end
	
endmodule
