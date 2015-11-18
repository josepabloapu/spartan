`timescale 1ns / 1ps
`include "Definitions.v" 

module SnakeMovement
(
	input wire Clock,
	input wire Reset,
	input wire iGameOver,
	input wire iWest,
	input wire iEast,
	input wire iNorth,
	input wire iSouth,
	input wire [7:0] iSnakeLenght,
	output wire [10:0] oSnakeLocationX,
	output wire [10:0] oSnakeLocationY,
	output reg oIconTick = 0,
	output reg oCtrlOff
);

//parameter SnakeCont1 = 28'd9_999_999; 
parameter SnakeCont1 = 28'd200; 

parameter SnakeCont2 = 28'd5_999_999; 
parameter SnakeCont3 = 28'd1_999_999; 

reg [10:0] rLocSX ,rLocSY;
reg [3:0] rCurrentHeading,rUserInput; //Keeps track of the user inputs and current heading direction of thesnake 
reg [28:0] rTickInc = 28'd0;
reg [28:0] rSnakeSpeed = SnakeCont1; // register to store the speed with which the snake is moving
reg [4:0] k = 0;

//Reloj para la velocidad.
always  @(posedge Clock)
begin
	if(rTickInc == rSnakeSpeed)
	begin
		oIconTick <= 1;
		rTickInc  <= 0;
	end
	else 
	begin
		rTickInc  <= rTickInc + 1;
		oIconTick <= 0;
	end
end

always @(*)
begin
	if(iWest == 1'b1 && oCtrlOff == 1'b0)
		rUserInput = `West;
	if(iEast == 1'b1 && oCtrlOff == 1'b0)
		rUserInput = `East;
	if(iNorth == 1'b1 && oCtrlOff == 1'b0)
		rUserInput = `North;
	if(iSouth == 1'b1 && oCtrlOff == 1'b0)
		rUserInput = `South;
end

always @(posedge oIconTick or posedge Reset)
begin
	if(Reset == 1)
	begin
		rLocSX = 11'd240;
		rLocSY = 11'd380;
		rCurrentHeading = `East;
	end
	
	else
	begin
	if(iSnakeLenght >= 8'd20 && iSnakeLenght <=8'd27)
		rSnakeSpeed = SnakeCont1;
	else if(iSnakeLenght >= 8'd50 && iSnakeLenght <= 8'd60)
		rSnakeSpeed = SnakeCont2;
	else 
		rSnakeSpeed = SnakeCont3;

	if(rUserInput == `West && rCurrentHeading != `West && rCurrentHeading != `East)
		rCurrentHeading = `West;

	else if(rUserInput == `East && rCurrentHeading != `West && rCurrentHeading != `East)
		rCurrentHeading = `East;

	else if(rUserInput == `North && rCurrentHeading != `North && rCurrentHeading != `South)
		rCurrentHeading = `North;

	else if(rUserInput == `South && rCurrentHeading != `North && rCurrentHeading != `South)
		rCurrentHeading = `South;
	
		

	
		case(rCurrentHeading)
		`West:rLocSX = rLocSX - 1;
		`East :rLocSX = rLocSX + 1;
		`North:rLocSY = rLocSY - 1;
		`South:rLocSY = rLocSY + 1;
		endcase
	

	end
end
always @(posedge Clock)
begin
	if(iGameOver)
		k=k+1;
	else
		k=0;
	
	if(k>=2)
		oCtrlOff=1;
	else
		oCtrlOff=0;
end
	
/*always @(posedge Reset) 
begin
	
	
		rCurrentHeading = `East;
		rLocSX = 11'd240;
		rLocSY = 11'd380;
		oCtrlOff = 1'b0;
		
end*/

assign oSnakeLocationX = rLocSX;
assign oSnakeLocationY = rLocSY;

endmodule

