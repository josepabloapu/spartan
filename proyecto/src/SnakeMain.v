`timescale 1ns / 1ps
`include "VgaController.v"
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
wire VgaClock;				// 25MHz clock from on-board oscillator	
wire 	[10:0] 	wLocX;					// X - Location of the snake head 
wire 	[10:0] 	wLocY;					// Y - locationof the snake head
wire [10:0] wPixRow,wPixCol;	// pixel row and column signals for the display
wire [1:0] wSnakeWorldPixel;			// Wire to interconnect snake world pixels(background) to colores
wire wGameOver;					// Wire for the game over flag
wire [1:0] wFoodIcon;			// Wire for the food icon
wire [2:0] wIcon;					// Wire for the main icon [The snake]
wire wVsync,wHsync;
wire [7:0] wSnakeLenght;	// Universal wire for the snake length			
wire wIconTick;	// Clock tick for the snake icon
wire wRandGen;		// Flag to start the generation of random numbers
wire [10:0] wRandLocX,wRandLocY; // Wires to interconnect the X,Y locations of the food to various modules


assign oVgaVsync = wVsync;
assign oVgaHsync = wHsync;


//Instanciación de Módulos

Colores color(
	.Clock(VgaClock),
	.Row(wPixRow),
	.Col(wPixCol),
	.iSnakeWorldPixel(wSnakeWorldPixel),
	.iIcon(wIcon),
	.iFoodIcon(wFoodIcon),
	.oRGB({oRed,oGreen,oBlue})
);

VgaController VGA(
	.Clock(Clock),
	.Reset(Reset),
	.oVgaHsync(wHsync),
	.oVgaVsync(wVsync),
	.oColCurrent(wPixCol),
	.oRowCurrent(wPixRow),
	.VgaClock(VgaClock)
);

SnakeIcon Icon(
	.Reset(Reset),
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
	.Reset(Reset),
	.iPixelRow(wPixRow),
	.iPixelCol(wPixCol),
	.iSnakeLenght(wSnakeLenght),
	.iRandEn(wRandGen),
	.iGameOver(wGameOver),
	.oFoodLocationX(wRandLocX),
	.oFoodLocationY(wRandLocY),
	.oFoodIcon(wFoodIcon),
	.oSnakeWorldPixeles(wSnakeWorldPixel)
);

SnakeMovement Move(
	.Clock(VgaClock),
	.Reset(Reset),
	.iGameOver(wGameOver),
	.iWest(iWest),
	.iEast(iEast),
	.iNorth(iNorth),
	.iSouth(iSouth),
	.iSnakeLenght(wSnakeLenght),
	.oSnakeLocationX(wLocX),
	.oSnakeLocationY(wLocY),
	.oIconTick(wIconTick)
);
endmodule



