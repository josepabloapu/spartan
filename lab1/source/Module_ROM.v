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

	0: oInstruction = { `NOP , 24'd4000 	};
	1: oInstruction = { `STO , `R0,16'd0};
	2: oInstruction = { `STO , `R1,16'd2	};
	3: oInstruction = { `STO , `R2,16'd4	};	
	4: oInstruction = { `STO , `R4,16'd10};
	5: oInstruction = { `STO , `R5,16'd3	};
	6: oInstruction = { `STO , `R6,16'hcaca	};  	//j
	
	7: oInstruction = { `ADD ,`R0,`R1,`R2  };
	8: oInstruction = { `SUB ,`R4,`R0,`R6 	};

	default:
		oInstruction = { `LED ,  24'b10101010 };	//NOP
	endcase	
end
	
endmodule
