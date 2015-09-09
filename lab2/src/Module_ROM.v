
`timescale 1ns / 1ps
`include "Defintions.v"
`define 	LOOP1	7 
`define 	LOOP2 	14 

module ROM
(
	input  wire[15:0]  		iAddress,
	output reg [27:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `NOP ,	24'd4000	};
	1: oInstruction = { `STO , `R0, 16'd2};
	2: oInstruction = { `STO , `R6, 16'd4};
	3: oInstruction = { `STO , `R7, 16'd1};
	4: oInstruction = { `STO , `R3, 16'd1};
	5: oInstruction = { `STO , `R4, 16'd1};
	6: oInstruction = { `STO , `R5, 16'd0};
	7: oInstruction = { `LED ,	8'b0, `R7, 8'b0 };
	8: oInstruction = { `STO , `R1, 16'd0};
	9: oInstruction = { `STO , `R2, 16'd6};
	10: oInstruction = { `ADD , `R3, `R1, `R3};
	11: oInstruction = { `BLE , `LOOP2, `R1, `R2};
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
