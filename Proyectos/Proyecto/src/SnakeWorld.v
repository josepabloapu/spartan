`timescale 1ns / 1ps

//This module interconnects the various blocks of Snake game.

module SnakeWorld
(	
	input wire Reset,
	input wire [10:0] iPixelRow, 
	input wire [10:0] iPixelCol,
	input wire [7:0] iSnakeLenght,
	input wire iRandEn,
	input wire iGameOver,
	output reg [10:0] oFoodLocationX,
	output reg [10:0] oFoodLocationY,
	output reg [1:0] oFoodIcon,
	output reg [1:0] oSnakeWorldPixeles				
);
reg [7:0] rLocationXTemp,rLocationYTemp;
reg [7:0] x = 8'd133;
reg [7:0] y = 8'd121;


parameter LimHIzq 	= 192;
parameter LimHDer 	= 448;
parameter LimVUp 	= 112;
parameter LimVDown 	= 368;


//Food icon generation.
always @(iPixelRow,iPixelCol)
begin
	
	if(iPixelRow == oFoodLocationY && iPixelCol == oFoodLocationX && iGameOver == 1'b0)
		oFoodIcon = 2'b11;
	else
		oFoodIcon = 2'b00;
	
end


always @(iPixelRow,iPixelCol)
begin
//Limites del mundo del juego
	if(iPixelCol < LimHIzq || iPixelCol  > LimHDer)
		oSnakeWorldPixeles = 2'b10;
	else if(iPixelRow < LimVUp || iPixelRow > LimVDown)
		oSnakeWorldPixeles = 2'b10;
	else
		oSnakeWorldPixeles = 2'b00;

//Desplegando Game Over
	if(iGameOver == 1'b1 && iSnakeLenght < 8'd95)
	begin
		//G
		if (iPixelCol > (11'd48 + 11'd250) && iPixelCol < (11'd61 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd39 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
	
		else if (iPixelCol > (11'd48 + 11'd250) && iPixelCol < (11'd52 + 11'd250) && iPixelRow > (11'd38 + 11'd200) && iPixelRow < (11'd45 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
	
		else if (iPixelCol > (11'd48 + 11'd250) && iPixelCol < (11'd61 + 11'd250) && iPixelRow > (11'd44 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd57 + 11'd250) && iPixelCol < (11'd61 + 11'd250) && iPixelRow > (11'd41 + 11'd200) && iPixelRow < (11'd45 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		//A
		else if (iPixelCol > (11'd62 + 11'd250) && iPixelCol < (11'd66 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd71 + 11'd250) && iPixelCol < (11'd75 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd65 + 11'd250) && iPixelCol < (11'd72 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd39 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd65 + 11'd250) && iPixelCol < (11'd72 + 11'd250) && iPixelRow > (11'd41 + 11'd200) && iPixelRow < (11'd43 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		
		//M
		else if (iPixelCol > (11'd76 + 11'd250) && iPixelCol < (11'd89 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd39 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd76 + 11'd250) && iPixelCol < (11'd80 + 11'd250) && iPixelRow > (11'd38 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd85 + 11'd250) && iPixelCol < (11'd89 + 11'd250) && iPixelRow > (11'd38 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd81 + 11'd250) && iPixelCol < (11'd84 + 11'd250) && iPixelRow > (11'd38 + 11'd200) && iPixelRow < (11'd42 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		
		//E
		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd94 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd103 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd39 + 11'd200))
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd100 + 11'd250) && iPixelRow > (11'd40 + 11'd200) && iPixelRow < (11'd43 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd103 + 11'd250) && iPixelRow > (11'd44 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		//O
		else if (iPixelCol > (11'd48 + 11'd250) && iPixelCol < (11'd61 + 11'd250) && iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd54 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd48 + 11'd250) && iPixelCol < (11'd61 + 11'd250) && iPixelRow > (11'd59 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd48 + 11'd250) && iPixelCol < (11'd52 + 11'd250) && iPixelRow > (11'd53 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd57 + 11'd250) && iPixelCol < (11'd61 + 11'd250) && iPixelRow > (11'd53 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		
		//V
		else if (iPixelCol > (11'd62 + 11'd250) && iPixelCol < (11'h42 + 11'd250) && iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'h47 + 11'd250) && iPixelCol < (11'h4B + 11'd250) && iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd62 + 11'd250) && iPixelCol < (11'h4B + 11'd250) && iPixelRow > (11'd59 + 11'd200) && iPixelRow < (11'd61 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd63 + 11'd250) && iPixelCol < (11'd74 + 11'd250) && iPixelRow > (11'd60 + 11'd200) && iPixelRow < (11'd62 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd64 + 11'd250) && iPixelCol < (11'h49 + 11'd250) && iPixelRow > (11'd61 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		
		//E
		else if (iPixelCol > (11'd76 + 11'd250) && iPixelCol < (11'd80 + 11'd250) && iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd79 + 11'd250) && iPixelCol < (11'd89 + 11'd250) && iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd54 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd79 + 11'd250) && iPixelCol < (11'd89 + 11'd250) && iPixelRow > (11'd59 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd79 + 11'd250) && iPixelCol < (11'd86 + 11'd250) && iPixelRow > (11'd55 + 11'd200) && iPixelRow < (11'd58 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		
		//R
		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd94 + 11'd250) && iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd103 + 11'd250) && iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd54 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd102 + 11'd250) && iPixelRow > (11'd55 + 11'd200) && iPixelRow < (11'd58 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd99 + 11'd250) && iPixelCol < (11'd103 + 11'd250) && iPixelRow > (11'd53 + 11'd200) && iPixelRow < (11'd56 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > (11'd99 + 11'd250) && iPixelCol < (11'd103 + 11'd250) && iPixelRow > (11'd57 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;

		else 
			oSnakeWorldPixeles = oSnakeWorldPixeles;
		
	end
		//End Game over
 
	//Displaying "You Won!"
	if(iGameOver == 1'b1 && iSnakeLenght >= 8'd95)
	begin
// Letter Y
		if (iPixelCol > (11'd56 + 11'd250) && iPixelCol < (11'd60 + 11'd250) && 	iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd40 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd65 + 11'd250) && iPixelCol < (11'd69 + 11'd250) && iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd40 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd56 + 11'd250) && iPixelCol < (11'd69 + 11'd250) && iPixelRow > (11'd39 + 11'd200) && iPixelRow < (11'd43 + 11'd200)) 				
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd60 + 11'd250) && iPixelCol < (11'd64 + 11'd250) && iPixelRow > (11'd42 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter O
		else if (iPixelCol > (11'd70 + 11'd250) && iPixelCol < (11'd83 + 11'd250) && 	iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd39 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd70 + 11'd250) && iPixelCol < (11'd83 + 11'd250) && 	iPixelRow > (11'd44 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd70 + 11'd250) && iPixelCol < (11'd74 + 11'd250) && 	iPixelRow > (11'd38 + 11'd200) && iPixelRow < (11'd45 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd79 + 11'd250) && iPixelCol < (11'd83 + 11'd250) && 	iPixelRow > (11'd38 + 11'd200) && iPixelRow < (11'd45 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter U
		else if (iPixelCol > (11'd84 + 11'd250) && iPixelCol < (11'd97 + 11'd250) && 	iPixelRow > (11'd44 + 11'd200) && iPixelRow < (11'd48 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd84 + 11'd250) && iPixelCol < (11'd88 + 11'd250) && 	iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd45 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd93 + 11'd250) && iPixelCol < (11'd97 + 11'd250) && 	iPixelRow > (11'd35 + 11'd200) && iPixelRow < (11'd45 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter W
		else if (iPixelCol > (11'd56 + 11'd250) && iPixelCol < (11'd60 + 11'd250) && 	iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd65 + 11'd250) && iPixelCol < (11'd69 + 11'd250) && 	iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd56 + 11'd250) && iPixelCol < (11'd69 + 11'd250) && 	iPixelRow > (11'd59 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd61 + 11'd250) && iPixelCol < (11'd64 + 11'd250) && 	iPixelRow > (11'd56 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter O
		else if (iPixelCol > (11'd70 + 11'd250) && iPixelCol < (11'd83 + 11'd250) && 	iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd54 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd70 + 11'd250) && iPixelCol < (11'd83 + 11'd250) && 	iPixelRow > (11'd59 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd70 + 11'd250) && iPixelCol < (11'd74 + 11'd250) && 	iPixelRow > (11'd53 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd79 + 11'd250) && iPixelCol < (11'd83 + 11'd250) && 	iPixelRow > (11'd53 + 11'd200) && iPixelRow < (11'd60 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter N
		else if (iPixelCol > (11'd84 + 11'd250) && iPixelCol < (11'd88 + 11'd250) && 	iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd93 + 11'd250) && iPixelCol < (11'd97 + 11'd250) && 	iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd87 + 11'd250) && iPixelCol < (11'd89 + 11'd250) && 	iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd55 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd88 + 11'd250) && iPixelCol < (11'd90 + 11'd250) && 	iPixelRow > (11'd52 + 11'd200) && iPixelRow < (11'd57 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd89 + 11'd250) && iPixelCol < (11'd91 + 11'd250) && 	iPixelRow > (11'd54 + 11'd200) && iPixelRow < (11'd59 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd90 + 11'd250) && iPixelCol < (11'd92 + 11'd250) && 	iPixelRow > (11'd56 + 11'd200) && iPixelRow < (11'd61 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd91 + 11'd250) && iPixelCol < (11'd93 + 11'd250) && 	iPixelRow > (11'd58 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd92 + 11'd250) && iPixelCol < (11'd94 + 11'd250) && 	iPixelRow > (11'd60 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		
		// !
		else if (iPixelCol > (11'd99 + 11'd250) && iPixelCol < (11'd102 + 11'd250) && 	iPixelRow > (11'd50 + 11'd200) && iPixelRow < (11'd59 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > (11'd99 + 11'd250) && iPixelCol < (11'd102 + 11'd250) && 	iPixelRow > (11'd60 + 11'd200) && iPixelRow < (11'd63 + 11'd200)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol < (11'd16 + 11'd250) || iPixelCol > (11'd144 + 11'd250)) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelRow < (11'd10 + 11'd200) || iPixelRow > (11'd110 + 11'd000)) 
			oSnakeWorldPixeles = 2'b10;
		
		else 
			oSnakeWorldPixeles = 2'b00;
		
	end	

end

//Función para crear numeros aleatorios
always @(iPixelRow,iPixelCol) 
begin		
	rLocationXTemp = ((x + 4271)*4273 - 9973*3)*57;
	rLocationYTemp = ((y + 3343)*3347 - 9857*3)*55;
	x = rLocationXTemp;
	y = rLocationYTemp;
end

//Posición de la comida
always @(posedge iRandEn or posedge Reset)
begin
	if(Reset)
	begin
		oFoodLocationX = 11'd250;
		oFoodLocationY = 11'd350;
	end
	
	else
	begin
		oFoodLocationX = rLocationXTemp + 11'd192;
		oFoodLocationY = rLocationYTemp + 11'd112;
	end
end
endmodule
