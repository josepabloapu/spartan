// http://tinyvga.com/vga-timing/1024x768@60Hz

// General timing

// Screen refresh rate	60 Hz
// Vertical refresh	48.363095238095 kHz
// Pixel freq.	65.0 MHz
// Horizontal timing (line)

// Polarity of horizontal sync pulse is negative.
// Scanline part	Pixels	Time [µs]
// Visible area	1024	15.753846153846
// Front porch	24	0.36923076923077
// Sync pulse	136	2.0923076923077
// Back porch	160	2.4615384615385
// Whole line	1344	20.676923076923

// Vertical timing (frame)

// Polarity of vertical sync pulse is negative.
// Frame part	Lines	Time [ms]
// Visible area	768	15.879876923077
// Front porch	3	0.062030769230769
// Sync pulse	6	0.12406153846154
// Back porch	29	0.59963076923077
// Whole frame	806	16.6656
// **************************************************

`timescale 1ns / 1ps
`include "Collaterals.v"

module VgaController(
	input wire Clock,
	input wire Reset,
	output wire oVideoOn,
	output wire oVgaVsync,
	output wire oVgaHsync,
	output wire [10:0] oColCurrent,
	output wire [10:0] oRowCurrent

);

wire colReset;
wire rowReset;
wire VgaClock;
wire wPllLock,wPsDone;
wire [10:0] wRtemp,wCtemp;

parameter VisibleHArea = 640;	
parameter FrontHPorch  = 16;	
parameter SyncHPulse   = 96;	
parameter BackHPorch   = 48;	
parameter WholeHLine   = 800;	
//Verttical
parameter VisibleVArea = 480;	
parameter FrontVPorch  = 10;	
parameter SyncVPulse   = 2;	
parameter BackVPorch   = 33;	
parameter WholeVFrame  = 525;	



assign oColCurrent = wCtemp;
assign oRowCurrent = wRtemp; 

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
.CLKFB(VgaClock), 	
.RST( Reset ),			
.PSEN(1'b0), 			
.LOCKED(wPllLock),	//Para bloquear el Pll.
.PSDONE(wPsDone),	
.CLKFX(VgaClock)		 

);
//***********************************

//***********************************

assign rowReset = (wRtemp == (WholeVFrame-1))? 1'b1:1'b0;
assign colReset = (wCtemp == (WholeHLine-1))? 1'b1:1'b0;

assign oVgaVsync = (wRtemp >= (VisibleVArea + FrontVPorch) && wRtemp <= (VisibleVArea + FrontVPorch + SyncVPulse))? 0:1;
assign oVgaHsync = (wCtemp >= (VisibleHArea + FrontHPorch) && wCtemp <= (VisibleHArea + FrontHPorch + SyncHPulse))? 0:1;

assign oVideoOn = (wCtemp < 640 && wRtemp < 480)? 1:0;
//Desplega la pantalla en blanco.


// **************************************************
// COUNTERS
// **************************************************

UPCOUNTER_POSEDGE #(11) COLCOUNTER (
.Clock  (VgaClock), 
.Reset  (colReset | Reset | ~wPllLock),
.Initial(11'b0),
.Enable (1'b1),
.Q      (wCtemp)
);

UPCOUNTER_POSEDGE #(11) ROWCOUNTER (
.Clock  (VgaClock), 
.Reset  (rowReset | Reset | ~wPllLock),
.Initial(11'b0),
.Enable (colReset),
.Q      (wRtemp)
);

// **************************************************

endmodule
