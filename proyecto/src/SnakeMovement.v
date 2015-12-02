`timescale 1ns / 1ps
`include "Definitions.v" 

module SnakeMovement
(	input wire Clock,
	input wire Reset,
	input wire iGameOver,
	input wire iWest,
	input wire iEast,
	input wire iNorth,
	input wire iSouth,
	input wire [7:0] iSnakeLenght,
	output reg [10:0] oSnakeLocationX,
	output reg [10:0] oSnakeLocationY,
	output reg oIconTick = 0

);

parameter SnakeCont1 = 28'd2000000; 
parameter SnakeCont2 = 28'd900_999; 
parameter SnakeCont3 = 28'd400000; 


reg [3:0] rCurrentHeading, rUserInput; //Keeps track of the user inputs and current heading direction of thesnake 
reg [28:0] rTickInc = 28'd0;
reg [28:0] rSnakeSpeed = SnakeCont1; // register to store the speed with which the snake is moving




always  @(posedge Clock)
begin
	if(!iGameOver)
	begin
	if(rTickInc == rSnakeSpeed)
	begin
		oIconTick <= 1;
		rTickInc  <= 0;
	end
	
	else 
	begin
		rTickInc  <= rTickInc + 1'b1;
		oIconTick <= 0;
	end
	end
	else
		oIconTick <= 0;
end
//
always @(*)
begin
	if(iWest == 1'b1)
		rUserInput = `West;
	else if(iEast == 1'b1)
		rUserInput = `East;
	else if(iSouth == 1'b1) 
		rUserInput = `South;
	else if(iNorth == 1'b1)
		rUserInput = `North;
	else	
		rUserInput = rUserInput;
end


always @(posedge oIconTick or posedge Reset)
begin
	if(Reset == 1'b1)
	begin
		oSnakeLocationX = 11'd240;
		oSnakeLocationY = 11'd350;
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
		else
			rCurrentHeading = rCurrentHeading;
		
		if(!iGameOver)
		begin
			case(rCurrentHeading)
				`West:oSnakeLocationX = oSnakeLocationX - 1;
				`East :oSnakeLocationX = oSnakeLocationX + 1;
				`North:oSnakeLocationY = oSnakeLocationY - 1;
				`South:oSnakeLocationY = oSnakeLocationY + 1;
			endcase
		end
	end	
end
endmodule

