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

module VgaControllerMarcs (
	input wire Clock,
	input wire Reset,
	output wire [3:0] oVgaRed,
	output wire [3:0] oVgaGreen,
	output wire [3:0] oVgaBlue,
	output wire oVgaVsync,
	output wire oVgaHsync
);

wire wColCurrent;
wire wRowCurrent;
wire wColumnReset;
wire wRowReset;
wire wPllLocked;

assign wPllLocked = 0;

// **************************************************
// RESET LOGIC
// **************************************************
assign wReachedLastCol = (wColCurrent == 806 );
assign wColumnReset = Reset | wPllLocked | wReachedLastCol;
assign wReachedLastRow = (wRowCurrent == 1344 );
assign wRowReset = Reset | wPllLocked | wReachedLastRow;

// **************************************************
// SYNC LOGIC
// **************************************************
assign oVgaVsync = (wReachedLastCol) ? 1'b0 : 1'b1;
assign oVgaHsync = (wReachedLastRow) ? 1'b0 : 1'b1;

// **************************************************
// COLOR LOGIC
// **************************************************

assign oVgaRed   = 3'b111;
assign oVgaGreen = 3'b000;
assign oVgaBlue  = 3'b000;

// always @ ( Clock )
// begin
// 	assign oVgaRed   <= 3'b111;
// 	assign oVgaGreen <= 3'b000;
// 	assign oVgaBlue  <= 3'b000;
// end

// **************************************************
// COUNTERS
// **************************************************

UPCOUNTER_POSEDGE COLCOUNTER (
.Clock  (Clock), 
.Reset  (wColumnReset),
.Initial(1'b0),
.Enable (1'b1),
.Q      (wColCurrent)
);

UPCOUNTER_POSEDGE ROWCOUNTER (
.Clock  (Clock), 
.Reset  (wRowReset),
.Initial(1'b0),
.Enable (1'b1),
.Q      (wRowCurrent)
);

// **************************************************

endmodule