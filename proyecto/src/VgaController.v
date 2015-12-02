// http://tinyvga.com/vga-timing/1024x768@60Hz

//This circuit provides pixel location and horizontal and 
//vertical sync for a 640 x 480 video image.
`timescale 1ns / 1ps
`include "Collaterals.v"
`include "Definitions.v"
module VgaController(
	input wire Clock,
	input wire Reset,
	output wire oVgaVsync,
	output wire oVgaHsync,
	output wire [10:0] oColCurrent,
	output wire [10:0] oRowCurrent,
	output wire VgaClock

);

wire colReset;
wire rowReset;
wire wVgaClock;
wire wPllLock,wPsDone;
wire [10:0] wRtemp,wCtemp;

parameter VisibleHArea = 640;	
parameter FrontHPorch  = 16;	
parameter SyncHPulse   = 96;	
parameter BackHPorch   = 48;	
parameter WholeHLine   = 800;	
//Vertical
parameter VisibleVArea = 480;	
parameter FrontVPorch  = 10;	
parameter SyncVPulse   = 2;	
parameter BackVPorch   = 33;	
parameter WholeVFrame  = 525;	



assign oColCurrent = wCtemp;
assign oRowCurrent = wRtemp; 
assign VgaClock = wVgaClock;
//*******************************************
// Generating a 25 MHz frequency clock      *
//*******************************************
//25=25*32/32

DCM_SP 
#
(
.CLKFX_MULTIPLY(25),	
.CLKFX_DIVIDE(32)		
)
ClockVga
(
.CLKIN(Clock),			
.CLKFB(wVgaClock), 	
.RST( Reset ),			
.PSEN(1'b0), 			
.LOCKED(wPllLock),	//Para bloquear el Pll.
.PSDONE(wPsDone),	
.CLKFX(wVgaClock)		 

);
//***********************************

//***********************************

assign rowReset = (wRtemp == (WholeVFrame-1))? 1'b1:1'b0;
assign colReset = (wCtemp == (WholeHLine-1))? 1'b1:1'b0;

assign oVgaVsync = (wRtemp >= (VisibleVArea + FrontVPorch) && wRtemp <= (VisibleVArea + FrontVPorch + SyncVPulse))? 0:1;
assign oVgaHsync = (wCtemp >= (VisibleHArea + FrontHPorch) && wCtemp <= (VisibleHArea + FrontHPorch + SyncHPulse))? 0:1;


// **************************************************
// COUNTERS
// **************************************************

UPCOUNTER_POSEDGE #(11) COLCOUNTER (
.Clock  (wVgaClock), 
.Reset  (colReset | Reset | ~wPllLock),
.Initial(11'b0),
.Enable (1'b1),
.Q      (wCtemp)
);

UPCOUNTER_POSEDGE #(11) ROWCOUNTER (
.Clock  (wVgaClock), 
.Reset  (rowReset | Reset | ~wPllLock),
.Initial(11'b0),
.Enable (colReset),
.Q      (wRtemp)
);

// **************************************************

endmodule
