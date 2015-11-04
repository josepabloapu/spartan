//http://tinyvga.com/vga-timing/1024x768@60Hz

module VGA_CONTROLLER (
	input wire iClock,
	output reg oVSync,
	output reg oHSync,
	output reg [3:0] oRed,
	output reg [3:0] oGreen,
	output reg [3:0] oBlue
);

UPCOUNTER_POSEDGE colCounter (
.Clock  (Clock), 
.Reset  (colReset),
.Initial(1'b0),
.Enable (1'b1),
.Q      (colCurrent)
);

UPCOUNTER_POSEDGE rowCounter (
.Clock  (Clock), 
.Reset  (rowReset),
.Initial(1'b0),
.Enable (1'b1),
.Q      (rowCurrent)
);