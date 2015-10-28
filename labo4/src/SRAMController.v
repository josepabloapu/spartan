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

module SRAM_CONTROLLER # ( parameter DATA_WIDTH= 8, parameter ADDR_WIDTH=19 )
(
	input wire							Clock,
	input wire							Reset,
	input wire 							iWriteEnable,	     //R/W Selection
	input wire 							iTrigger,		     //Enable the SRAM R/W
	input wire [ADDR_WIDTH-1:0]		iAddress,           //Data from MiAlu
	input wire [DATA_WIDTH-1:0] 		iDataIn,            //Data that the guest wants to write into SRAM
	input wire [DATA_WIDTH-1:0]		iSRAMDataIn,        //Data from SRAM
	output wire [DATA_WIDTH-1:0]		oSRAMDataRead,      //Data that was read from SRAM
	output wire [DATA_WIDTH-1:0] 		oSRAMDataWrite,     //Data that we want to write into SRAM
	output wire [ADDR_WIDTH-1:0]		oSRAMAddressOut,     //Address to read/write to SRAM
	output reg                      oSRaMWriteEnable
);

reg wAddrEn, rDataWriteHold ;
reg rDataReadEn, rDataWriteEn;
wire [DATA_WIDTH-1:0] wSRAMDataWrite;


assign oSRAMDataWrite = ( rDataWriteEn ) ?  wSRAMDataWrite : 8'bz ;


FFD_POSEDGE_SYNCRONOUS_RESET # ( ADDR_WIDTH ) FFD_ADDR 
(
	.Clock(  Clock        ),
	.Reset(  Reset        ),
	.Enable( wAddrEn      ),
	.D(      iAddress     ),
	.Q(      oSRAMAddressOut  )
);


FFD_POSEDGE_SYNCRONOUS_RESET # ( DATA_WIDTH ) FFD_DATAOUT 
(
	.Clock(  Clock           ),
	.Reset(  Reset           ),
	.Enable( rDataWriteHold  ),
	.D(      iDataIn         ),
	.Q(      wSRAMDataWrite  )
);


FFD_POSEDGE_SYNCRONOUS_RESET # ( DATA_WIDTH ) FFD_DATAIN 
(
	.Clock(  Clock            ),
	.Reset(  Reset            ),
	.Enable( rDataReadEn      ),
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
			rDataReadEn  = 1'b0;
			rDataWriteEn = 1'b0;
			rDataWriteHold = iWriteEnable;
			oSRaMWriteEnable = 1'b1;

			if (iTrigger)
				   rNextState = ( iWriteEnable ) ? `WRITE_SETUP : `READ_REQUEST  ;
			else 
			      rNextState = `LISTEN;
		end

		`WRITE_SETUP:
		begin
			wAddrEn          = 1'b0;
			rDataReadEn      = 1'b0;
			rDataWriteEn     = 1'b0;
			rDataWriteHold   = 1'b0;
			oSRaMWriteEnable = 1'b1;

			rNextState = `WRITE;
			
		end

		`WRITE:
		begin
			wAddrEn          = 1'b0;
			rDataReadEn      = 1'b0;
			rDataWriteEn     = 1'b0;
			rDataWriteHold   = 1'b0;
			oSRaMWriteEnable = 1'b1;

			rNextState = `WRITE_HOLD;
		end

		`WRITE_HOLD:
		begin
			wAddrEn          = 1'b0;
			rDataReadEn      = 1'b0;
			rDataWriteEn     = 1'b1;
			rDataWriteHold   = 1'b0;
			oSRaMWriteEnable = 1'b0;

			rNextState = `LISTEN;
		end

		`READ_REQUEST:			//Present address bus
		begin	
			wAddrEn          = 1'b0;
			rDataReadEn      = 1'b0;
			rDataWriteEn     = 1'b0;
			rDataWriteHold   = 1'b0;
			oSRaMWriteEnable = 1'b1;

			rNextState = `READ_LATCH;
		end

		`READ_LATCH:           //Readback data from Memory
		begin
			wAddrEn          = 1'b0;
         rDataReadEn      = 1'b1;
         rDataWriteEn     = 1'b0;
			rDataWriteHold   = 1'b0;
			oSRaMWriteEnable = 1'b1;

			rNextState = `LISTEN;
		end


		default:
		begin
			wAddrEn          =  1'b0;
			rDataReadEn      =  1'b0;
			rDataWriteEn     = 1'b0;
			rDataWriteHold   = 1'b0;
			oSRaMWriteEnable = 1'b1;

			rNextState = `LISTEN;
		end

	endcase
end

endmodule
