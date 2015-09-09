
`timescale 1ns / 1ps
`include "Defintions.v"
`define 	LOOP1	8 
`define 	LOOP2 5 

module ROM
(
	input  wire[15:0]  		iAddress,
	output reg [27:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `NOP ,	24'd4000	};
	1: oInstruction = { `STO , `R0, 16'd8};
	2: oInstruction = { `STO , `R6, 16'd9};
	3: oInstruction = { `STO , `R7, 16'b0001};
	4: oInstruction = { `STO , `R3, 16'h1};
	5: oInstruction = { `STO , `R4, 16'd1000};
	6: oInstruction = { `STO , `R5, 16'd0};
	7: oInstruction = { `LED ,	8'b0, `R7, 8'b0 };
	8: oInstruction = { `STO , `R1, 16'h0};
	9: oInstruction = { `STO , `R2, 16'd500};
	10: oInstruction = { `ADD , `R1, `R1, `R3};
	11: oInstruction = { `BLE , `LOOP1, `R1, `R2};
	12: oInstruction = { `ADD , `R5, `R5, `R3};
	13: oInstruction = { `BLE , `LOOP1, `R1, `R2};
	14: oInstruction = { `NOP ,	24'd4000	};
	15: oInstruction = { `IMUL , `R7, `R0, `R6 };
	16: oInstruction = { `JMP , 8'd2, 16'b0 };


	default:
		oInstruction = { `LED ,  24'b10101010 };		//NOP
	endcase	
end
	
endmodule
