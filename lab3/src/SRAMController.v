`define LISTEN 		  0
`define WRITE_SETUP   1
`define WRITE 		  2
`define WRITE_HOLD 	  3
`define READ_REQUEST  4
`define READ_LATCH    5


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
	input wire 							iWriteEnable,	     //R/W Selection
	input wire 							iTrigger,		     //Enable the SRAM R/W
	input wire [ADDR_WIDTH-1:0]	iAddress,           //Data from MiAlu
	input wire [DATA_WIDTH-1:0] 	iDataIn,            //Data that the guest wants to write into SRAM
	input wire [DATA_WIDTH-1:0]	iSRAMDataIn,        //Data from SRAM
	output wire [DATA_WIDTH-1:0]	oSRAMDataRead,      //Data that was read from SRAM
	output wire [DATA_WIDTH-1:0] 	oSRAMDataWrite,     //Data that we want to write into SRAM
	output wire [ADDR_WIDTH-1:0]	oSRAMAddressOut     //Address to read/write to SRAM
);



wire wAddrEn;
wire wDataEn


FFD_POSEDGE_SYNCRONOUS_RESET # ( ADDR_WIDTH-1 ) FFD_ADDR 
(
	.Clock(  Clock        ),
	.Reset(  Reset        ),
	.Enable( wAddrEn      ),
	.D(      iAddress     ),
	.Q(      oSRAMAddressOut  )
);


FFD_POSEDGE_SYNCRONOUS_RESET # ( DATA_WIDTH-1 ) FFD_DATAOUT 
(
	.Clock(  Clock           ),
	.Reset(  Reset           ),
	.Enable( 1'b1            ),
	.D(      iDataIn         ),
	.Q(      oSRAMDataWrite  )
);


FFD_POSEDGE_SYNCRONOUS_RESET # ( DATA_WIDTH-1 ) FFD_DATAIN 
(
	.Clock(  Clock            ),
	.Reset(  Reset            ),
	.Enable( wDataEn          ),
	.D(      iSRAMDataIn      ),
	.Q(      oSRAMDataRead    )
);

reg [3:0] rCurrentState, rNextState;
reg [ADDR_WIDTH-1:0]    rNextAddr;
reg [DATA_WIDTH-1:0]    rNextDataOut;

//Logica de Estado Presente
always @ ( posedge Clock, posedge Reset )
begin
	if (Reset)
		rCurrentState <= `LISTEN;
	else
		rCurrentState <= rNextState;
end

//Lógica de Próximo Estado de una Máquina de Mealy
always @ ( * )
begin
	case (rCurrentState)

		`LISTEN:
		begin
			wAddrEn  = 1'b1;	//Hold address in this state to make sure it will become available in next state
			wDataEn  = 1'b0;

			if (iTrigger)
				   rNextAddr = ( iWriteEnable ) ? `READ_REQUEST :  `WRITE_SETUP ;
			else 
			      rNextState = `LISTEN;
		end

		`WRITE_SETUP:
		begin
			wAddrEn  = 1'b1;
			wDataEn  = 1'b1;

			rNextState = `WRITE;
			
		end

		`WRITE:
		begin
			wAddrEn  = 1'b0;
			wDataEn  = 1'b0;


			rNextState = `WRITE_HOLD;
		end

		`WRITE_HOLD:
		begin
			wAddrEn  = 1'b0;
			wDataEn  = 1'b0;

			rNextState = `LISTEN;
		end

		`READ_REQUEST:			//Present address bus
		begin	
			wAddrEn  = 1'b0;
            wDataEn  = 1'b0;

			rNextState = `READ_LATCH;
		end

		`READ_LATCH:           //Readback data from Memory
		begin
			wAddrEn  = 1'b0;
            wDataEn  = 1'b1;

			rNextState = `LISTEN;
		end


		default:
		begin
			wAddrEn  =  1'b0;
			wDataEn  =  1'b0;

			rNextState = `LISTEN;
		end

	endcase
end

endmodule
