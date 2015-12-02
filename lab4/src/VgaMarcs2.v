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
`include "Defintions.v"
module VgaControllerMarcs (
	input wire Clock,
	input wire Reset,
	output wire [3:0] oVgaRed,
	output wire [3:0] oVgaGreen,
	output wire [3:0] oVgaBlue,
	output wire oVgaVsync,
	output wire oVgaHsync
);

wire colReset;
wire rowReset;
wire VgaClock;
wire wPllLock,wPsDone;
wire [15:0] colCurrent,rowCurrent;




//*******************************************
// Generating a 65 MHz frequency clock      *
//*******************************************
//64=4*32/2

DCM_SP 
#
(
.CLKFX_MULTIPLY(4),	
.CLKFX_DIVIDE(2)		
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

assign rowReset = (rowCurrent == 805)? 1'b1:1'b0;
assign colReset = (colCurrent == 1343)? 1'b1:1'b0;

assign oVgaVsync = (rowCurrent >= 771 && rowCurrent <= 777)? 0:1;
assign oVgaHsync = (colCurrent >= 1048 && colCurrent <= 1184)? 0:1;


//Desplega la pantalla en blanco.
assign {oVgaRed,oVgaGreen,oVgaBlue} = ( (colCurrent < 612 && colCurrent > 412) || (rowCurrent < 484 && rowCurrent > 584) ) ? `COLOR_RED:`COLOR_BLACK;

// assign {oVgaRed,oVgaGreen,oVgaBlue} = (rowCurrent < 484 && rowCurrent > 584)? `COLOR_RED:`COLOR_BLACK;


// **************************************************
// COUNTERS
// **************************************************

UPCOUNTER_POSEDGE #(16) COLCOUNTER (
.Clock  (VgaClock), 
.Reset  (colReset | Reset | ~wPllLock),
.Initial(16'b0),
.Enable (1'b1),
.Q      (colCurrent)
);

UPCOUNTER_POSEDGE #(16) ROWCOUNTER (
.Clock  (VgaClock), 
.Reset  (rowReset | Reset | ~wPllLock),
.Initial(16'b0),
.Enable (colReset),
.Q      (rowCurrent)
);

// **************************************************

endmodule
