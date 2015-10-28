
`timescale 1ns / 1ps
`include "Defintions.v"
`include "Collaterals.v"
`include "Module_ROM.v"
`include "RAM.v"
`include "SRAMController.v"
`define DEBUG 1


module MiniAlu
(
	input wire Clock,
 	input wire Reset,
 	output wire [7:0] oLed,
 	output wire [3:0] oRed,oGreen,oBlue,
 	`ifdef UART
 		output wire oUartTx,
 		input  wire iUartRx,
 	`endif
	
	//SRAM pinout
	output wire [18:0] oSramAddr,
 	inout wire [7:0] oSramData,
 	output wire oSramCe,
 	output wire oSramWe, 
 	output wire oSramOe,
 	output wire oVsync,
 	output wire oHsync
);

assign oSramCe = 1'b0;
assign oSramOe = 1'b0;
assign oRed = 4'b0000;
assign oGreen = 4'b1111;
assign oBlue = 4'b0000;
assign oVsync = 4'b0000;
assign oHsync = 4'b0000;

wire [7:0] wSramData;

SRAM_CONTROLLER SRAMController
(
	.Clock(Clock),
	.Reset(Reset),
	.iWriteEnable(rSramWriteEnable),	 //R/W Selection
	.iTrigger(rTrigger),		     		//Enable the SRAM R/W
	.iAddress(rRequestAddr),         //Data from MiAlu
	.iDataIn(rRequestData),          //Data that the guest wants to write into SRAM
	.iSRAMDataIn(oSramData),         //Data from SRAM
	.oSRAMDataRead(wSramData),       //Data that was read from SRAM
	.oSRAMDataWrite(oSramData),      //Data that we want to write into SRAM
	.oSRAMAddressOut(oSramAddr),     //Address to read/write to SRAM
	.oSRaMWriteEnable(oSramWe)
);

	
	
`ifdef UART
	//====== XILINX UART MODULES ================//
	reg [`UART_BAUD_RATE_CNT_SZ:0]      rBaudCount;
	reg                                 rEn_16_X_Baud;
	wire [`UART_WORD_OUT_SZ-1:0]        wUartDataRx,wUartDataTx;                        // UART 1 Byte internal signals
	wire                                wUartRxDataAvailable, wUartTxDataAvailable;             // UART serial input/ouput signals
	wire                                wUartClock;                                                                                                 // 96Mhz clock used for UART
	
	assign wUartDataTx          = wUartDataRx;
	assign wUartTxDataAvailable = wUartRxDataAvailable;
`endif

//Controller VGA
//(
//	.Clock(Clock),
//	.Reset(Reset),
//	.oRed(oRed),
//	.oGreen(oGreen),
//	.oBlue(oBlue),
//	.oVsync(oVsync),	//Polarity of horizontal sync pulse is negative.
//	.oHsync( oHsync )	//Polarity of vertical sync pulse is negative.
//);

wire [15:0] wIP,wIP_temp;
reg         rWriteEnable,rBranchTaken;
wire [27:0] wInstruction;
wire [3:0]  wOperation;
reg [15:0]   /*wSourceData0,wSourceData1,*/rResult;
wire [7:0]  wSourceAddr0,wSourceAddr1,wDestination, wNextDest, wDestinationTemp;
wire [15:0] wSourceData0,wSourceData1,wIPInitialValue,wImmediateValue, wSourceDataTemp0, wSourceDataTemp1, wResultTemp;
wire [15:0] wResult_Fwd;

// SRAM required wires
reg  rTrigger;	 
reg [18:0] rRequestAddr;
reg [16:0] rRequestData;
reg rSramWriteEnable;

FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FF_RSLT_FWD
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(rResult),
	.Q(wResult_Fwd)
);

ROM InstructionRom 
(
	.iAddress(     wIP          ),
	.oInstruction( wInstruction )
);

RAM_DUAL_READ_PORT DataRam
(
	.Clock(         Clock        ),
	.iWriteEnable(  rWriteEnable ),
	.iReadAddress0( wInstruction[7:0] ),
	.iReadAddress1( wInstruction[15:8] ),
	.iWriteAddress( wDestination ),
	.iDataIn(       rResult      ),
	.oDataOut0(     wSourceDataTemp0 ),
	.oDataOut1(     wSourceDataTemp1 )
);

assign wIPInitialValue = (Reset) ? 8'b0 : wDestination;
UPCOUNTER_POSEDGE IP
(
.Clock(   Clock                ), 
.Reset(   Reset | rBranchTaken ),
.Initial( wIPInitialValue + 1'b1  ),
.Enable(  1'b1                 ),
.Q(       wIP_temp             )
);
assign wIP = (rBranchTaken) ? wIPInitialValue : wIP_temp;

FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 ) FFD1 
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[27:24]),
	.Q(wOperation)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD2
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[7:0]),
	.Q(wSourceAddr0)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD3
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[15:8]),
	.Q(wSourceAddr1)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD4
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[23:16]),
	.Q(wDestination)
);


reg rFFLedEN;
`ifndef DEBUG
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LEDS
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable( rFFLedEN ),
	.D( wSourceData1[7:0] ),
	.Q( oLed    )
);
`else 
assign oLed = oSramData;
`endif
//Almacenamiento de la dirección destino del proceso anterior del pipeline
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_NDF
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	//.D(wDestinationTemp),
	.D(wDestination),
	.Q(wNextDest)
);

//assign wDestinationTemp = (rWriteEnable) ? wDestination : wNextDest;

assign wImmediateValue = {wSourceAddr1,wSourceAddr0};

//----------------------------------------------------------------------------
assign wSourceData0 = (wSourceAddr0 == wNextDest) ? wResult_Fwd : wSourceDataTemp0;		//selección del dato destino 0
assign wSourceData1 = (wSourceAddr1 == wNextDest) ? wResult_Fwd : wSourceDataTemp1;		//selección del dato destino 1
//----------------------------------------------------------------------------
always @ ( * )
begin
	case (wOperation)
	//-------------------------------------
	`NOP:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b0;
		rSramWriteEnable <= 1'b0;
		rTrigger 	 <= 1'b0;
		rRequestAddr <= 1'b0;
		rRequestData <= 1'b0;
		rResult      <= 0;
	end
	//-------------------------------------
	`ADD:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b1;
		rSramWriteEnable <= 1'b0;
		rBranchTaken <= 1'b0;
		rTrigger 	 <= 1'b0;
		rRequestAddr <= 1'b0;
		rRequestData <= 1'b0;
		rResult      <= wSourceData1 + wSourceData0;
	end
	//-------------------------------------
	`STO:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b1;
		rSramWriteEnable <= 1'b0;
		rBranchTaken <= 1'b0;
		rTrigger 	 <= 1'b0;
		rRequestAddr <= 1'b0;
		rRequestData <= 1'b0;
		rResult      <= wImmediateValue;
	end
	//-------------------------------------
	`SRD:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b0;
		rSramWriteEnable <= 1'b0;
		rBranchTaken <= 1'b0;
		rTrigger 	 <= 1'b1;
		rRequestAddr <= {3'b000,wSourceData0};
		rRequestData <= 1'b0;
		rResult      <= {8'b0,wSramData};
	end
	//-------------------------------------
	`SWR:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b0;
		rSramWriteEnable <= 1'b1;
		rBranchTaken <= 1'b0;
		rTrigger 	 <= 1'b1;
		rRequestAddr <= {3'b000,wSourceData0};
		rRequestData <= wSourceData1;
		rResult      <= 1'b0;
	end
	//-------------------------------------
	`BLE:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b0;
		rSramWriteEnable <= 1'b0;
		rTrigger 	 <= 1'b0;
		rRequestAddr <= 1'b0;
		rRequestData <= 1'b0;
		rResult      <= 0;
		if (wSourceData1 <= wSourceData0 )
			rBranchTaken <= 1'b1;
		else
			rBranchTaken <= 1'b0;
		
	end
	//-------------------------------------	
	`JMP:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b0;
		rSramWriteEnable <= 1'b0;
		rTrigger 	 <= 1'b0;
		rRequestAddr <= 1'b0;
		rRequestData <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b1;
	end
	//-------------------------------------	
	`LED:
	begin
		rFFLedEN     <= 1'b1;
		rWriteEnable <= 1'b0;
		rSramWriteEnable <= 1'b0;
		rTrigger 	 <= 1'b0;
		rRequestAddr <= 1'b0;
		rRequestData <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b0;
	end
	//-------------------------------------
	default:
	begin
		rFFLedEN     <= 1'b1;
		rWriteEnable <= 1'b0;
		rSramWriteEnable <= 1'b0;
		rTrigger 	 <= 1'b0;
		rRequestAddr <= 1'b0;
		rRequestData <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b0;
	end	
	//-------------------------------------	
	endcase	
end


////////////////////////////////////////////////////////////////////////////
//                                                                        //
//                           **  UART **                                  //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

`ifdef UART
wire wPllLocked,wPsDone;

DCM_SP 
#
(
.CLKFX_MULTIPLY(3),	//96
.CLKFX_DIVIDE(1)		

)
ClockUart
(
.CLKIN(Clock),				//32Mhz
.CLKFB(wUartClock), 		//Feed back
.RST( Reset ),				//Global reset
.PSEN(1'b0), 				//Disable variable phase shift. Ignore inputs to phase shifter
.LOCKED(wPllLocked),		//Use this signal to make sure PLL is locked
.PSDONE(wPsDone),			//I am not really using this one
.CLKFX(wUartClock)		//FCLKFX = FCLKIN * CLKFX_MULTIPLY / CLKFX_DIVIDE 

);


//--------------------------------------------------
always @ (posedge wUartClock )
begin
        if (rBaudCount == 1)
        begin
                rBaudCount    = 1'b0;
                rEn_16_X_Baud = 1'b1;
        end
        else
        begin
                rBaudCount    = rBaudCount + 1'b1;
                rEn_16_X_Baud = 1'b0;
        end

end

uart_rx6 UART_RX
(
.serial_in(           iUartRx              ),
.en_16_x_baud(        rEn_16_X_Baud        ),
.data_out(            wUartDataRx          ), //8 bits
.buffer_read(         1'b1                 ),
.buffer_data_present( wUartRxDataAvailable ), //8 bits from UART became available for reading
.buffer_reset(        1'b0                 ),
.clk(                 wUartClock           )
);


uart_tx6 UART_TX
(
.data_in(             wUartDataTx          ),   //Amaze yourself! put any 8b'char in here and see the magic
.buffer_write(        wUartTxDataAvailable ),
.buffer_reset(        1'b0                 ),
.clk(                 wUartClock           ),
.en_16_x_baud(        rEn_16_X_Baud        ),
.serial_out(          oUartTx              )
);
`endif


endmodule
