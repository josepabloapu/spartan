`define LISTEN 		0
`define WRITE_SETUP 1
`define WRITE 		2
`define WRITE_HOLD 	3
`define READ 		4

// SPARTAN 6
// CoreSpeed 32Mhz
// SRAM writting times 
// tSA  = 4ns;
// tSCE = 12ns;
// tHA  = 4ns;
// SRAM reading times
// tRC = 20ns

module SRAM_CONTROLLER # ( parameter DATA_WIDTH= 16, parameter ADDR_WIDTH=8 )
(
	input wire							Clock,
	input wire							Reset,
	input wire 							iWriteEnable,
	input wire 							iTrigger,
	input wire [ADDR_WIDTH-1:0]	iAddress,
	input wire [DATA_WIDTH-1:0]	iDataIn,
	output reg [DATA_WIDTH-1:0] 	oDataOut,
	reg CounterDelay;
);

reg [3:0] CurrentState, NextState;
reg [ADDR_WIDTH-1:0] NextAddr;
reg [DATA_WIDTH-1:0] NextDataOut;

//Logica de Estado Presente
always @ ( posedge Clock, posedge Reset )
begin
	if (Reset)
		CurrentState <= `LISTEN;
	else
		CurrentState <= NextState;
end

//Lógica de Próximo Estado de una Máquina de Mealy
always @ ( * )
begin
	case (CurrentState)

		`LISTEN:
		begin
			if (iTrigger)
				begin
					if (iWriteEnable) NextState = `READ;
					else NextState = `WRITE_SETUP;
				end
			else NextState = `LISTEN;
		end

		`WRITE_SETUP:
		begin
			NextState = `WRITE;
			NextAddr = iAddress;
		end

		`WRITE:
		begin
			NextState = `WRITE_HOLD;
			NextAddr = iAddress;
		end

		`WRITE_HOLD:
		begin
			NextState = `LISTEN;
			NextAddr = iAddress;
		end

		`READ:
		begin
			NextState = `LISTEN;
			NextAddr = iAddress;
		end

		default:
		begin
			NextState = `LISTEN;
		end

	endcase
end

//Logica de Salida
always @ ( posedge Clock, posedge Reset )
begin
	if (Reset)
		oDataOut <= 0;
		iAddress <= 0;
	else
		oDataOut <= NextDataOut;
		iAddress <= NextAddr;
end

endmodule
