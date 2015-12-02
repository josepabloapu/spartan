`timescale 1ns / 1ps
//This module is for user control and random locations for food
module SnakeIcon
(
	//input wire Clock,
	input wire Reset,
	input wire iIconTick,	
	input wire [10:0] iPixelRow,
	input wire [10:0] iPixelCol,
	input wire [10:0] iLocationX,
	input wire [10:0] iLocationY,
	input wire [10:0] iFoodLocationX,
	input wire [10:0] iFoodLocationY,
	output reg [2:0] oIcon,
	output reg [7:0] oSnakeLenght,
	output reg oGameOver,
	output reg oFoodGen
);

//Cuerpo de la Serpiente
reg [21:0] rBodyStack[100:0];
reg [7:0] i,j;

always @(posedge iIconTick or posedge Reset)
begin
	if(Reset)//Valores iniciales
	begin
		oFoodGen = 1'b0;
		oGameOver = 1'b0;
		oSnakeLenght = 8'd20;
		
		rBodyStack[25] = {11'd215,11'd350};
		rBodyStack[24] = {11'd216,11'd350};
		rBodyStack[23] = {11'd217,11'd350};
		rBodyStack[22] = {11'd218,11'd350};
		rBodyStack[21] = {11'd219,11'd350};
		rBodyStack[20] = {11'd220,11'd350};
		rBodyStack[19] = {11'd221,11'd350};
		rBodyStack[18] = {11'd222,11'd350};
		rBodyStack[17] = {11'd223,11'd350};
		rBodyStack[16] = {11'd224,11'd350};
		rBodyStack[15] = {11'd225,11'd350};
		rBodyStack[14] = {11'd226,11'd350};
		rBodyStack[13] = {11'd227,11'd350};
		rBodyStack[12] = {11'd228,11'd350};
		rBodyStack[11] = {11'd229,11'd350};
		rBodyStack[10] = {11'd230,11'd350};
		rBodyStack[9]  = {11'd231,11'd350};
		rBodyStack[8]  = {11'd232,11'd350};
		rBodyStack[7]  = {11'd233,11'd350};
		rBodyStack[6]  = {11'd234,11'd350};
		rBodyStack[5]  = {11'd235,11'd350};
		rBodyStack[4]  = {11'd236,11'd350};
		rBodyStack[3]  = {11'd237,11'd350};
		rBodyStack[2]  = {11'd238,11'd350};
		rBodyStack[1]  = {11'd239,11'd350};
		rBodyStack[0]  = {11'd240,11'd350};
	end
	else
	begin
		rBodyStack[0] = {iLocationX,iLocationY};
		/*Start generation of the body dynamically while the snake eats more food*/
		for(i=100;i>=1;i=i-1) 
		begin 
			if(i <= oSnakeLenght && oGameOver == 1'b0) 
				rBodyStack[i] = rBodyStack[i-1];
			else 
				rBodyStack[i] = 22'd0;
		end
	
//When the snake hit the world boundaries or the snake reaches the boundaries
		if (oSnakeLenght >= 8'd26 || iLocationX <= 11'd192 ||  iLocationX >= 11'd449 || iLocationY <= 11'd112 || iLocationY >= 11'd368)
			oGameOver = 1;
		else
			oGameOver = 0;

//When tha snake eats itself oGameOver flag is set			
		for(j=100;j>=2;j=j-1) 
		begin
			if(rBodyStack[0] == rBodyStack[j] && j <= oSnakeLenght) //Check the condition 1 - If the head location is equal to any of the body locations the game is over
				oGameOver = 1;
			else  //This else has been used just to maintain a flip-flop kind of harware instead of a latch
				oGameOver = oGameOver;
		end		
		
		
		if(iFoodLocationX < 11'd192 && iFoodLocationX > 11'd448 && iFoodLocationY < 11'd112 && iFoodLocationY > 11'd368)
			oFoodGen = 1'b1;
		else
			oFoodGen = 1'b0;
	
		if(rBodyStack[0]=={iFoodLocationX,iFoodLocationY}) 
		begin //Check if the head location of the snake is equal to the location of the food
			oFoodGen = 1'b1; //If the above condition is met the oFoodGen is set high to generate the new location for the food
	/*The levels of the snake game are based on the updating length of the snake !*/
			if( oSnakeLenght == 8'd27 ) /*Contion to jump from lvl - 1  to lvl - 2*/
				oSnakeLenght = oSnakeLenght + 8'd23;
			else if(oSnakeLenght == 8'd60) /*Contion to jump from lvl - 2  to lvl - 3*/
				oSnakeLenght = oSnakeLenght + 8'd25;
			else
				oSnakeLenght = oSnakeLenght + 8'd1; /*When the snake is in a particular level its body increments by 1 when it eats food */

		end
		else 
			oFoodGen=oFoodGen;
			
		
	end
end	

always @(iPixelRow,iPixelCol) 
begin
	/*Start the generation of body*/

	case({iPixelCol,iPixelRow})
		rBodyStack[0]:oIcon <= 3'b001;
		rBodyStack[1]:oIcon <= 3'b001;
		rBodyStack[2]:oIcon <= 3'b001;
		rBodyStack[3]:oIcon <= 3'b001;
		rBodyStack[4]:oIcon <= 3'b001;
		rBodyStack[5]:oIcon <= 3'b001;
		rBodyStack[6]:oIcon <= 3'b001;
		rBodyStack[7]:oIcon <= 3'b001;
		rBodyStack[8]:oIcon <= 3'b001;
		rBodyStack[9]:oIcon <= 3'b001;
		rBodyStack[10]:oIcon <= 3'b001;
		rBodyStack[11]:oIcon <= 3'b001;
		rBodyStack[12]:oIcon <= 3'b001;
		rBodyStack[13]:oIcon <= 3'b001;
		rBodyStack[14]:oIcon <= 3'b001;
		rBodyStack[15]:oIcon <= 3'b001;
		rBodyStack[16]:oIcon <= 3'b001;
		rBodyStack[17]:oIcon <= 3'b001;
		rBodyStack[18]:oIcon <= 3'b001;
		rBodyStack[19]:oIcon <= 3'b001;
		rBodyStack[20]:oIcon <= 3'b001;
		rBodyStack[21]:oIcon <= 3'b001;
		rBodyStack[22]:oIcon <= 3'b001;
		rBodyStack[23]:oIcon <= 3'b001;
		rBodyStack[24]:oIcon <= 3'b001;
		rBodyStack[25]:oIcon <= 3'b001;
		rBodyStack[26]:oIcon <= 3'b001;
		rBodyStack[27]:oIcon <= 3'b001;
		rBodyStack[28]:oIcon <= 3'b001;
		rBodyStack[29]:oIcon <= 3'b001;
		rBodyStack[30]:oIcon <= 3'b001;
		rBodyStack[31]:oIcon <= 3'b001;
		rBodyStack[32]:oIcon <= 3'b001;
		rBodyStack[33]:oIcon <= 3'b001;
		rBodyStack[34]:oIcon <= 3'b001;
		rBodyStack[35]:oIcon <= 3'b001;
		rBodyStack[36]:oIcon <= 3'b001;
		rBodyStack[37]:oIcon <= 3'b001;
		rBodyStack[38]:oIcon <= 3'b001;
		rBodyStack[39]:oIcon <= 3'b001;
		rBodyStack[40]:oIcon <= 3'b001;
		rBodyStack[41]:oIcon <= 3'b001;
		rBodyStack[42]:oIcon <= 3'b001;
		rBodyStack[43]:oIcon <= 3'b001;
		rBodyStack[44]:oIcon <= 3'b001;
		rBodyStack[45]:oIcon <= 3'b001;
		rBodyStack[46]:oIcon <= 3'b001;
		rBodyStack[47]:oIcon <= 3'b001;
		rBodyStack[48]:oIcon <= 3'b001;
		rBodyStack[49]:oIcon <= 3'b001;
		rBodyStack[50]:oIcon <= 3'b001;
		rBodyStack[51]:oIcon <= 3'b001;
		rBodyStack[52]:oIcon <= 3'b001;
		rBodyStack[53]:oIcon <= 3'b001;
		rBodyStack[54]:oIcon <= 3'b001;
		rBodyStack[55]:oIcon <= 3'b001;
		rBodyStack[56]:oIcon <= 3'b001;
		rBodyStack[57]:oIcon <= 3'b001;
		rBodyStack[58]:oIcon <= 3'b001;
		rBodyStack[59]:oIcon <= 3'b001;
		rBodyStack[60]:oIcon <= 3'b001;
		rBodyStack[61]:oIcon <= 3'b001;
		rBodyStack[62]:oIcon <= 3'b001;
		rBodyStack[63]:oIcon <= 3'b001;
		rBodyStack[64]:oIcon <= 3'b001;
		rBodyStack[65]:oIcon <= 3'b001;
		rBodyStack[66]:oIcon <= 3'b001;
		rBodyStack[67]:oIcon <= 3'b001;
		rBodyStack[68]:oIcon <= 3'b001;
		rBodyStack[69]:oIcon <= 3'b001;
		rBodyStack[70]:oIcon <= 3'b001;
		rBodyStack[71]:oIcon <= 3'b001;
		rBodyStack[72]:oIcon <= 3'b001;
		rBodyStack[73]:oIcon <= 3'b001;
		rBodyStack[74]:oIcon <= 3'b001;
		rBodyStack[75]:oIcon <= 3'b001;
		rBodyStack[76]:oIcon <= 3'b001;
		rBodyStack[77]:oIcon <= 3'b001;
		rBodyStack[78]:oIcon <= 3'b001;
		rBodyStack[79]:oIcon <= 3'b001;
		rBodyStack[80]:oIcon <= 3'b001;
		rBodyStack[81]:oIcon <= 3'b001;
		rBodyStack[82]:oIcon <= 3'b001;
		rBodyStack[83]:oIcon <= 3'b001;
		rBodyStack[84]:oIcon <= 3'b001;
		rBodyStack[85]:oIcon <= 3'b001;
		rBodyStack[86]:oIcon <= 3'b001;
		rBodyStack[87]:oIcon <= 3'b001;
		rBodyStack[88]:oIcon <= 3'b001;
		rBodyStack[89]:oIcon <= 3'b001;
		rBodyStack[90]:oIcon <= 3'b001;
		rBodyStack[91]:oIcon <= 3'b001;
		rBodyStack[92]:oIcon <= 3'b001;
		rBodyStack[93]:oIcon <= 3'b001;
		rBodyStack[94]:oIcon <= 3'b001;
		rBodyStack[95]:oIcon <= 3'b001;
		rBodyStack[96]:oIcon <= 3'b001;
		rBodyStack[97]:oIcon <= 3'b001;
		rBodyStack[98]:oIcon <= 3'b001;
		rBodyStack[99]:oIcon <= 3'b001;
		rBodyStack[100]:oIcon <= 3'b001;
	  
		
		default:oIcon <= 3'b000; /*This will be used in the colorizer to set the priority*/
	endcase
end

endmodule
			

