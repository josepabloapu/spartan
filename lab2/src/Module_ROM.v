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
	// Inicialización de los registros
	1: oInstruction = { `STO , `R0,16'd0	};
	2: oInstruction = { `STO , `R1,16'd65535	};
	3: oInstruction = { `STO , `R2,16'd4	};	
	4: oInstruction = { `STO , `R4,16'd10	};
	5: oInstruction = { `STO , `R5,16'd3	};
	6: oInstruction = { `STO , `R6,16'd5	};

	7: oInstruction = { `IMUL ,`R0,`R1,`R2  };
	
	default:
		oInstruction = { `LED ,  24'b10101010 };	//NOP
	endcase	
end
	
endmodule
