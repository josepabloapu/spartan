
module Main
(
	input wire Clock, // 32 MHz frequency clock from papilio board.
	input wire Reset,	
	input wire iWest,
	input wire iEast,
	input wire iNorth,
	input wire iSouth,
	output wire oVgaVsync,
	output wire oVgaHsync,
	output wire [3:0] oRed,
	output wire [3:0] oGreen,
	output wire [3:0] oBlue
);

// internal variables
//wire [3:0]		wDbBtns;				// debounced buttons
wire VgaClock;				// 50MHz clock from on-board oscillator	
//wire			wSysReset;				// system reset signal - asserted high to force reset
	
wire 	[10:0] 	wLocX;					// X - Location of the snake head 
wire 	[10:0] 	wLocY;					// Y - locationof the snake head

   
	//wire for pixel row and pixel column
wire [10:0] wPixRow,wPixCol;	// pixel row and column signals for the display
wire wVidOn;						// VGA video on signal
wire wPllLock,wPsDone;
wire [1:0] wSnakeWorldPixel;			// Wire to interconnect snake world pixels(background) to colorizer
wire wGameOver;					// Wire for the game over flag
wire [1:0] wFoodIcon;			// Wire for the food icon
wire [2:0] wIcon;					// Wire for the main icon [The snake]
wire [11:0] wRGB;	// Wire to interconnect the vga color pixels to colorizer	
wire [9:0] wSnakeLenght;	// Universal wire for the snake length			
wire wIconTick;	// Clock tick for the snake icon
wire wCtrlOff;		// Universal control off wire if this is set high then the game is over	
wire wRandGen;		// Flag to start the generation of random numbers
wire [10:0] wRandLocX,wRandLocY; // Wires to interconnect the X,Y locations of the food to various modules

assign oRed   = wRGB[11:8];
assign oGreen = wRGB[7:4];
assign oBlue  = wRGB[3:0];

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

//Instanciación de Módulos

/*FiltroRebote FR(
	.Clock(VgaClock),
	.iPushBtn({iWest,iNorth,iEast,iSouth}),
	.oPushBtn(wDbBtns)
); */

Colores color(
	.Clock(VgaClock),
	.iVideoOn(wVidOn),
	.iSnakeWorldPixel(wSnakeWorldPixel),
	.iIcon(wIcon),
	.iFoodIcon(wFoodIcon),
	.oRGB(wRGB)
);

VgaController VGA(
	.Clock(Clock),
	.Reset(Reset),
	.oVideoOn(wVidOn),
	.oVgaHsync(oVgaHsync),
	.oVgaVsync(oVgaVsync),
	.oColCurrent(wPixCol),
	.oRowCurrent(wPixRow)
);

SnakeIcon Icon(
	.Clock(VgaClock),
	.Reset(Reset),
	.iCtrlOff(wCtrlOff),
	.iIconTick(wIconTick),
	.iPixelRow(wPixRow),
	.iPixelCol(wPixCol),
	.iLocationX(wLocX),
	.iLocationY(wLocY),
	.oIcon(wIcon),
	.oSnakeLenght(wSnakeLenght),
	.iFoodLocationX(wRandLocX),
	.iFoodLocationY(wRandLocY),
	.oGameOver(wGameOver),
	.oFoodGen(wRandGen)
);

SnakeWorld World(
	.Clock(Clock),
	.Reset(Reset),
	.iPixelRow(wPixRow),
	.iPixelCol(wPixCol),
	.iSnakeLenght(wSnakeLenght),
	.iRandEn(wRandGen),
	.iCtrlOff(wCtrlOff),

	.oFoodLocationX(wRandLocX),
	.oFoodLocationY(wRandLocY),
	.oFoodIcon(wFoodIcon),
	.oSnakeWorldPixeles(wSnakeWorldPixel)
);

SnakeMovement Move(
	.Clock(VgaClock),
	.Reset(Reset),
	.iGameOver(wGameOver),
	/*.iWest(wDbBtns[3]),
	.iEast(wDbBtns[1]),
	.iNorth(wDbBtns[2]),
	.iSouth(wDbBtns[0]),*/
	.iWest(iWest),
	.iEast(iEast),
	.iNorth(iNorth),
	.iSouth(iSouth),
	.iSnakeLenght(wSnakeLenght),
	.oSnakeLocationX(wLocX),
	.oSnakeLocationY(wLocY),
	.oIconTick(wIconTick),
	.oCtrlOff(wCtrlOff)
);
endmodule



