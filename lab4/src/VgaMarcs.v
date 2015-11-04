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
	output reg oVgaVsync,
	output reg oVgaHsync
);

reg colReset;
reg rowReset;

always @ ( Reset )
begin
	colReset <= 1'b1;
	rowReset <= 1'b1;
end

// **************************************************
// RESET LOGIC
// **************************************************

// VSync
always @ ( Clock )
begin
	if (colCurrent == 806)
	begin 
		colReset <= 1'b1;
		oVgaVsync <= 1'b1;
	end
	else
	begin  
		colReset <= 1'b0;
		oVgaVsync <= 1'b0;
	end
end

// HSync
always @ ( Clock )
begin
	if (rowCurrent == 1344) 
	begin
		rowReset <= 1'b1;
		oVgaHsync <= 1'b1;
	end
	else 
	begin 
		rowReset <= 1'b0;
		oVgaHsync <= 1'b0;
	end
end

// **************************************************
// VSYNC LOGIC
// **************************************************

// always @ ( Clock )
// begin
	
// end

// **************************************************
// HSYNC LOGIC
// **************************************************

// always @ ( Clock )
// begin
	
// end

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
.Reset  (colReset),
.Initial(1'b0),
.Enable (1'b1),
.Q      (colCurrent)
);

UPCOUNTER_POSEDGE ROWCOUNTER (
.Clock  (Clock), 
.Reset  (rowReset),
.Initial(1'b0),
.Enable (1'b1),
.Q      (rowCurrent)
);

// **************************************************

endmodule