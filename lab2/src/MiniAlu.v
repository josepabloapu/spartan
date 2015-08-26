
`timescale 1ns / 1ps
`include "Defintions.v"

module MiniAlu
(
 input wire Clock,
 input wire Reset,
 output wire [7:0] oLed

);

wire [15:0]	wIP,wIP_temp;
reg        	rWriteEnable,rBranchTaken;
wire [27:0] wInstruction;
wire [3:0]  wOperation;
reg [15:0]  rResult;
wire [7:0]  wSourceAddr0,wSourceAddr1,wDestination,wDestination_pre;
wire [15:0] wSourceData0,wSourceData1,wIPInitialValue,wImmediateValue,wResult_pre,wSourceData0_FromRam,wSourceData1_FromRam;

wire signed [15:0] wMula,wMulb;
wire [3:0] wQSumResult;
wire wCarry;

assign {wCarry,wQSumResult} = {wSourceData1[3],wSourceData1[2],wSourceData1[1],wSourceData1[0] + 
											wSourceData0[3],wSourceData0[2],wSourceData0[1],wSourceData0[0]};
assign wMula = wSourceData0;
assign wMulb = wSourceData1;



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
	.oDataOut0(     wSourceData0_FromRam ),
	.oDataOut1(     wSourceData1_FromRam )
);

assign wIPInitialValue = (Reset) ? 8'b0 : wDestination;
UPCOUNTER_POSEDGE IP
(
.Clock(   Clock                ), 
.Reset(   Reset | rBranchTaken ),
.Initial( wIPInitialValue + 1  ),
.Enable(  1'b1                 ),
.Q(       wIP_temp             )
);
assign wIP = (rBranchTaken) ? wIPInitialValue : wIP_temp;

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD1 
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
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LEDS
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable( rFFLedEN ),
	.D( wSourceData1 ),
	.Q( oLed    )
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_DESTINATION
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable( 1'b1 ),
	.D( wDestination ),
	.Q( wDestination_pre)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FF_RESULT
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable( 1'b1 ),
	.D( rResult ),
	.Q( wResult_pre)
);

assign wImmediateValue = {wSourceAddr1,wSourceAddr0};


// Corrección del hazard de RaW
// Se utiliza un comparador y se verifica si algun SourceAddr es igual al DestinarionAddr anterior
// Si es igual permite que el source tome el resultado más rápido del destino
assign wSourceData0 = ( wSourceAddr0 == wDestination_pre) ? wResult_pre :  wSourceData0_FromRam;
assign wSourceData1 = ( wSourceAddr1 == wDestination_pre) ? wResult_pre : wSourceData1_FromRam;

// Descomentar para observar el pipeline con el harzard de RaW
//assign wSourceData0 = wSourceData0_FromRam;
//assign wSourceData1 = wSourceData1_FromRam;

always @ ( * )
begin
	case (wOperation)
	//-------------------------------------
	`NOP:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
	end
	//-------------------------------------
	`ADD:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult      <= wSourceData1 + wSourceData0;
	end
	//-------------------------------------
	// Se agregó la función SUB (resta)
	`SUB:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		// Es posible hacer rResult <= SourceData1 + SourceData0 "en complemento a 2"
		rResult      <= wSourceData1 - wSourceData0;
	end
	//-------------------------------------
	// Se agregó la función MUL (multiplicación)
	`MUL:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult      <= wMula * wMulb;
	end
	//-------------------------------------
	// Se agregó la función MUL (multiplicación)
	`IMUL:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult <= wQSumResult; 
		end
	//-------------------------------------
	`STO:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b1;
		rBranchTaken <= 1'b0;
		rResult      <= wImmediateValue;
	end
	//-------------------------------------
	`BLE:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b0;
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
		rResult      <= 0;
		rBranchTaken <= 1'b1;
	end
	//-------------------------------------	
	`LED:
	begin
		rFFLedEN     <= 1'b1;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b0;
	end
	//-------------------------------------
	default:
	begin
		rFFLedEN     <= 1'b1;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b0;
	end	
	//-------------------------------------	
	endcase	
end


endmodule
