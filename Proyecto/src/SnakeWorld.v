
module SnakeWorld
(	input wire Clock,
	input wire Reset,
	input wire [10:0] iPixelRow, 
	input wire [10:0] iPixelCol,
	input wire [7:0] iSnakeLenght,
	input wire iRandEn,
	input wire iCtrlOff,
	output reg [10:0] oFoodLocationX = 11'd245,
	output reg [10:0] oFoodLocationY= 11'd380,
	output reg [1:0] oFoodIcon,
	output reg [1:0] oSnakeWorldPixeles				
);
reg [7:0] rLocationXTemp,rLocationYTemp;
reg [7:0] x = 7'd133;
reg [7:0] y = 7'd121;


	parameter LimHIzq 	= 212;
	parameter LimHDer 	= 468;
	parameter LimVUp 	= 112;
	parameter LimVDown 	= 368;

/*always @(Reset)
begin
	if (Reset)
	begin
		oFoodLocationX = 11'd245;
		oFoodLocationY = 11'd380;
		oFoodIcon = 2'b00;
		oSnakeWorldPixeles = 2'b00;
	end
end*/


//Food icon generation.
always @(iPixelRow,iPixelCol)
begin
	
	
	if(iPixelRow == oFoodLocationY && iPixelCol == oFoodLocationX && iCtrlOff == 1'b0)
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
/*	if(iCtrlOff == 1'b1 && iSnakeLenght < 500)
	begin
		//G
		if (iPixelCol > 11'd289 && iPixelCol < 11'd325 && iPixelRow > 11'd264 && iPixelRow < 11'd268) 
			oSnakeWorldPixeles = 2'b10;
	
		else if (iPixelCol > 11'd289 && iPixelCol < 11'd293 && iPixelRow > 11'd267 && iPixelRow < 11'd299) 
			oSnakeWorldPixeles = 2'b10;
	
		else if (iPixelCol > 11'd289 && iPixelCol < 11'd325 && iPixelRow > 11'd44 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd57 && iPixelCol < 11'd61 && iPixelRow > 11'd41 && iPixelRow < 11'd45) 
			oSnakeWorldPixeles = 2'b10;
		
		//A
		else if (iPixelCol > 11'd62 && iPixelCol < 11'd66 && iPixelRow > 11'd35 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd71 && iPixelCol < 11'd75 && iPixelRow > 11'd35 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd65 && iPixelCol < 11'd72 && iPixelRow > 11'd35 && iPixelRow < 11'd39) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd65 && iPixelCol < 11'd72 && iPixelRow > 11'd41 && iPixelRow < 11'd43) 
			oSnakeWorldPixeles = 2'b10;

		
		//M
		else if (iPixelCol > 11'd76 && iPixelCol < 11'd89 && iPixelRow > 11'd35 && iPixelRow < 11'd39) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd76 && iPixelCol < 11'd80 && iPixelRow > 11'd38 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd85 && iPixelCol < 11'd89 && iPixelRow > 11'd38 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd81 && iPixelCol < 11'd84 && iPixelRow > 11'd38 && iPixelRow < 11'd42) 
			oSnakeWorldPixeles = 2'b10;

		
		//E
		else if (iPixelCol > 11'd90 && iPixelCol < 11'd94 && iPixelRow > 11'd35 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd90 && iPixelCol < 11'd103 && iPixelRow > 11'd35 && iPixelRow<11'd39) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd90 && iPixelCol < 11'd100 && iPixelRow > 11'd40 && iPixelRow< 11'd43) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd90 && iPixelCol < 11'd103 && iPixelRow > 11'd44 && iPixelRow< 11'd48) 
			oSnakeWorldPixeles = 2'b10;
		
		//O
		else if (iPixelCol > 11'd48 && iPixelCol < 11'd61 && iPixelRow > 11'd50 && iPixelRow < 11'd54) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd48 && iPixelCol < 11'd61 && iPixelRow > 11'd59 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd48 && iPixelCol < 11'd52 && iPixelRow > 11'd53 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd57 && iPixelCol < 11'd61 && iPixelRow > 11'd53 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;

		
		//V
		else if (iPixelCol > 11'd62 && iPixelCol < 11'h42 && iPixelRow > 11'd50 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'h47 && iPixelCol < 11'h4B && iPixelRow > 11'd50 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd62 && iPixelCol < 11'h4B && iPixelRow > 11'd59 && iPixelRow < 11'd61) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd63 && iPixelCol < 11'd74 && iPixelRow > 11'd60 && iPixelRow < 11'd62) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd64 && iPixelCol < 11'h49 && iPixelRow > 11'd61 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;

		
		//E
		else if (iPixelCol > 11'd76 && iPixelCol < 11'd80 && iPixelRow > 11'd50 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd79 && iPixelCol < 11'd89 && iPixelRow > 11'd50 && iPixelRow < 11'd54) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd79 && iPixelCol < 11'd89 && iPixelRow > 11'd59 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd79 && iPixelCol < 11'd86 && iPixelRow > 11'd55 && iPixelRow < 11'd58) 
			oSnakeWorldPixeles = 2'b10;

		
		//R
		else if (iPixelCol > 11'd90 && iPixelCol < 11'd94 && iPixelRow > 11'd50 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd90 && iPixelCol < 11'd103 && iPixelRow > 11'd50 && iPixelRow< 11'd54) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd90 && iPixelCol < 11'd102 && iPixelRow > 11'd55 && iPixelRow< 11'd58) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd99 && iPixelCol < 11'd103 && iPixelRow > 11'd53 && iPixelRow< 11'd56) 
			oSnakeWorldPixeles = 2'b10;

		else if (iPixelCol > 11'd99 && iPixelCol < 11'd103 && iPixelRow > 11'd57 && iPixelRow< 11'd63) 
			oSnakeWorldPixeles = 2'b10;

		else 
			oSnakeWorldPixeles = 2'b00;
		
	end
		End Game over*/
 
/*	//Displaying "You Won!"
	if(iCtrlOff == 1'b1 && iSnakeLenght >= 11'd40)
	begin
// Letter Y
		if (iPixelCol > 11'd56 && iPixelCol < 11'd60 && 	iPixelRow > 11'd35 && iPixelRow < 11'd40) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd65 && iPixelCol < 11'd69 && iPixelRow > 11'd35 && iPixelRow < 11'd40) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd56 && iPixelCol < 11'd69 && iPixelRow > 11'd39 && iPixelRow < 11'd43) 				oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd60 && iPixelCol < 11'd64 && iPixelRow > 11'd42 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter O
		else if (iPixelCol > 11'd70 && iPixelCol < 11'd83 && 	iPixelRow > 11'd35 && iPixelRow < 11'd39) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd70 && iPixelCol < 11'd83 && 	iPixelRow > 11'd44 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd70 && iPixelCol < 11'd74 && 	iPixelRow > 11'd38 && iPixelRow < 11'd45) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd79 && iPixelCol < 11'd83 && 	iPixelRow > 11'd38 && iPixelRow < 11'd45) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter U
		else if (iPixelCol > 11'd84 && iPixelCol < 11'd97 && 	iPixelRow > 11'd44 && iPixelRow < 11'd48) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd84 && iPixelCol < 11'd88 && 	iPixelRow > 11'd35 && iPixelRow < 11'd45) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd93 && iPixelCol < 11'd97 && 	iPixelRow > 11'd35 && iPixelRow < 11'd45) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter W
		else if (iPixelCol > 11'd56 && iPixelCol < 11'd60 && 	iPixelRow > 11'd50 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd65 && iPixelCol < 11'd69 && 	iPixelRow > 11'd50 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd56 && iPixelCol < 11'd69 && 	iPixelRow > 11'd59 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd61 && iPixelCol < 11'd64 && 	iPixelRow > 11'd56 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter O
		else if (iPixelCol > 11'd70 && iPixelCol < 11'd83 && 	iPixelRow > 11'd50 && iPixelRow < 11'd54) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd70 && iPixelCol < 11'd83 && 	iPixelRow > 11'd59 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd70 && iPixelCol < 11'd74 && 	iPixelRow > 11'd53 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd79 && iPixelCol < 11'd83 && 	iPixelRow > 11'd53 && iPixelRow < 11'd60) 
			oSnakeWorldPixeles = 2'b10;
		
		
		//Letter N
		else if (iPixelCol > 11'd84 && iPixelCol < 11'd88 && 	iPixelRow > 11'd50 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd93 && iPixelCol < 11'd97 && 	iPixelRow > 11'd50 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd87 && iPixelCol < 11'd89 && 	iPixelRow > 11'd50 && iPixelRow < 11'd55) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd88 && iPixelCol < 11'd90 && 	iPixelRow > 11'd52 && iPixelRow < 11'd57) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd89 && iPixelCol < 11'd91 && 	iPixelRow > 11'd54 && iPixelRow < 11'd59) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd90 && iPixelCol < 11'd92 && 	iPixelRow > 11'd56 && iPixelRow < 11'd61) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd91 && iPixelCol < 11'd93 && 	iPixelRow > 11'd58 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd92 && iPixelCol < 11'd94 && 	iPixelRow > 11'd60 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;
		
		
		// !
		else if (iPixelCol > 11'd99 && iPixelCol < 11'd102 && 	iPixelRow > 11'd50 && iPixelRow < 11'd59) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol > 11'd99 && iPixelCol < 11'd102 && 	iPixelRow > 11'd60 && iPixelRow < 11'd63) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelCol < 11'd16 || iPixelCol >11'd144) 
			oSnakeWorldPixeles = 2'b10;
		
		else if (iPixelRow < 11'd10 || iPixelRow >11'd110) 
			oSnakeWorldPixeles = 2'b10;
		
		else 
			oSnakeWorldPixeles = 2'b00;
		
	end	*/

end

//Función para crear numeros aleatorios
always @(iPixelRow,iPixelCol) 
begin		
	rLocationXTemp = ((x + 4271)*4273 - 9973*3)*57;
	rLocationYTemp = ((y + 3343)*3347 - 9857*3)*55;
	x = rLocationXTemp;
	y = rLocationYTemp;
end

always @(posedge Clock or posedge iRandEn)
begin
	if(iRandEn == 1)// || oFoodLocationX > 11'd144 || oFoodLocationY > 11'd109 || oFoodLocationX < 11'd17 || oFoodLocation < 11'd11)
	begin
		oFoodLocationX = rLocationXTemp + LimHIzq;
		oFoodLocationY = rLocationYTemp + LimVUp;
	end
	else if(Reset==1)
		begin
		oFoodLocationX = 11'd245;
		oFoodLocationY = 11'd380;
		end
	else
	begin
		oFoodLocationX = oFoodLocationX;
		oFoodLocationY = oFoodLocationY;
	end
		
end
endmodule
