
`timescale 1ns / 1ps
`include "Defintions.v"
`define LOOP1 8 
`define LOOP2 5 
`define LOOP3 8 
`define LOOP4 5 

module ROM
(
	input  wire[15:0]  		iAddress,
	output reg [27:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `NOP ,	24'd4000	};
	1: oInstruction = { `STO , `R11, 16'h10};
	2: oInstruction = { `STO , `R12, 16'h20};
	3: oInstruction = { `STO , `R13, 16'h30};
	4: oInstruction = { `STO , `R14, 16'b0000000011000011};
	5: oInstruction = { `STO , `R15, 16'b0000000011100111};
	6: oInstruction = { `STO , `R16, 16'b0000000000100100};
	7: oInstruction = { `ADD , 8'hff, `R14, `R11};
	8: oInstruction = { `NOP ,	24'd4000	};
	9: oInstruction = { `NOP ,	24'd4000	};
	10: oInstruction = { `ADD , 8'hff, `R15, `R12};
	11: oInstruction = { `NOP ,	24'd4000	};
	12: oInstruction = { `NOP ,	24'd4000	};
	13: oInstruction = { `ADD , 8'hff, `R16, `R13};
	14: oInstruction = { `NOP ,	24'd4000	};
	15: oInstruction = { `NOP ,	24'd4000	};
	16: oInstruction = { `BLE , `R17, 8'hff, `R11};
	17: oInstruction = { `NOP ,	24'd4000	};
	18: oInstruction = { `NOP ,	24'd4000	};
	19: oInstruction = { `JMP , 8'd2, 16'b0 };


	default:
		oInstruction = { `LED ,  24'b10101010 };		//NOP
	endcase	
end
	
endmodule
