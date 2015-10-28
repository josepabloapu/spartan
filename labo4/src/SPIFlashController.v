`timescale 1ns / 1ps

module SPIFlashController
(
	input  wire Clock,
	input  wire Reset,
	input  wire iEnable,
	input  wire[23:0] iAddress,
	output reg [15:0] oData,
	output wire oSPIClock,
	output wire oSPICs,
	output reg  oSPIOut
	
);

parameter SPI_CMD_READ=8'h3;

assign oSPICs = ~iEnable;

SHIFTLEFT_POSEDGE # ( .SIZE(32) )SHL
( 
  .Clock( Clock ),
  .Reset( Reset ),
  .Initial({SPI_CMD_READ,iAddress}),
  .Enable(iEnable),
  .O( oSPIOut )
);

UPCOUNTER_POSEDGE # (.SIZE(16)) UP1
(
  .Clock( Clock ),
  .Reset( Reset ),
  .Initial(16'b0),
  .Enable(iEnable),
  .Q( wCycCounter )
);

assign wDataRdy = wCycCounter[6];

always @ (posedge Clock)
begin
	
end

endmodule
