
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
	3: oInstruction = { `STO , `R3, 16'h1};
	4: oInstruction = { `STO , `R4, 8'b0, 8'b11010100};
	5: oInstruction = { `STO , `R5, 8'b0, 8'b11101000};
	6: oInstruction = { `STO , `R6, 16'd50000 };
	7: oInstruction = { `SWR , 8'hff, `R4, `R1};
	8: oInstruction = { `NOP ,	24'd4000	};
	9: oInstruction = { `NOP ,	24'd4000	};
	10: oInstruction = { `NOP ,	24'd4000	};
	11: oInstruction = { `SWR , 8'hff, `R5, `R2};
	12: oInstruction = { `NOP ,	24'd4000	};
	13: oInstruction = { `NOP ,	24'd4000	};
	14: oInstruction = { `NOP ,	24'd4000	};
	//loop1-store
	15: oInstruction = { `STO , `R0, 16'd49600 };
	//loop2-store
	16: oInstruction = { `STO , `R7, 16'd0 };
	17: oInstruction = { `SRD , `R4, 8'hff, `R1};
	18: oInstruction = { `NOP ,	24'd4000	};
	19: oInstruction = { `NOP ,	24'd4000	};
	20: oInstruction = { `NOP ,	24'd4000	};
	21: oInstruction = { `LED , 8'hff, 8'hff, `R4 };
	22: oInstruction = { `ADD , `R7,`R7,`R3 }; 
	23: oInstruction = { `BLE , 8'd17,`R7,`R6 };
	24: oInstruction = { `ADD , `R0,`R0,`R3 }; 
	25: oInstruction = { `BLE , 8'd16,`R0,`R6 };
	//loop3
	26: oInstruction = { `STO , `R0, 16'd49600 };
	//loop4
	27: oInstruction = { `STO , `R7, 16'd0 };
	28: oInstruction = { `SRD , `R5, 8'hff, `R2};
	29: oInstruction = { `NOP ,	24'd4000	};
	30: oInstruction = { `NOP ,	24'd4000	};
	31: oInstruction = { `NOP ,	24'd4000	};
	32: oInstruction = { `LED , 8'hff, 8'hff, `R5 };
	33: oInstruction = { `ADD ,`R7,`R7,`R3  };
	34: oInstruction = { `BLE ,8'd28,`R7,`R6 };	
	35: oInstruction = { `ADD , `R0,`R0,`R3 }; 
	36: oInstruction = { `BLE , 8'd27,`R0,`R6 };
	
	37: oInstruction = { `JMP , 8'd15, 16'b0 };



	default:
		oInstruction = { `LED ,  24'b10101010 };
	endcase	
end
	
endmodule
