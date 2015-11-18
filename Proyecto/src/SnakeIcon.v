

module SnakeIcon
(
	input wire Clock,
	input wire Reset,
	input wire iCtrlOff,
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


reg [21:0] rBodyStack[100:0];
reg [7:0] i,j;


always @(iIconTick,Reset)
begin
	if(Reset==1)
	begin
		oFoodGen = 1'b1;
		oGameOver = 1'b0;
		oSnakeLenght = 8'd20;
//		oSnakeLenght = 8'd20;//Longitud inicial
//		for ( i=0;i<=100;i=i+1 ) 
//		begin
//			rBodyStack[i] = 22'd0;
//		end
		
		rBodyStack[25] = {11'd215,11'd380};
		rBodyStack[24] = {11'd216,11'd380};
		rBodyStack[23] = {11'd217,11'd380};
		rBodyStack[22] = {11'd218,11'd380};
		rBodyStack[21] = {11'd219,11'd380};
		rBodyStack[20] = {11'd220,11'd380};
		rBodyStack[19] = {11'd221,11'd380};
		rBodyStack[18] = {11'd222,11'd380};
		rBodyStack[17] = {11'd223,11'd380};
		rBodyStack[16] = {11'd224,11'd380};
		rBodyStack[15] = {11'd225,11'd380};
		rBodyStack[14] = {11'd226,11'd380};
		rBodyStack[13] = {11'd227,11'd380};
		rBodyStack[12] = {11'd228,11'd380};
		rBodyStack[11] = {11'd229,11'd380};
		rBodyStack[10] = {11'd230,11'd380};
		rBodyStack[9]  = {11'd231,11'd380};
		rBodyStack[8]  = {11'd232,11'd380};
		rBodyStack[7]  = {11'd233,11'd380};
		rBodyStack[6]  = {11'd234,11'd380};
		rBodyStack[5]  = {11'd235,11'd380};
		rBodyStack[4]  = {11'd236,11'd380};
		rBodyStack[3]  = {11'd237,11'd380};
		rBodyStack[2]  = {11'd238,11'd380};
		rBodyStack[1]  = {11'd239,11'd380};
		rBodyStack[0]  = {11'd240,11'd380};
	end
	else if(iIconTick)
	begin
	
		
		/*Start generation of the body dynamically while the snake eats more food*/
		for(i=100;i>=1;i=i-1) 
		begin 
			if(i <= oSnakeLenght && iCtrlOff == 0) //iCtrlOff assures that the game is not yet over
				rBodyStack[i] = rBodyStack[i-1];
			else 
			begin
				rBodyStack[i] = 22'd0;
			end
		end
		
		
//		if(iCtrlOff)
//			rBodyStack[0] = 22'b0;
//		else
//			rBodyStack[0] = {iLocationX,iLocationY};


		if(iCtrlOff == 0 && (rBodyStack[0]=={iFoodLocationX,iFoodLocationY})) 
		begin //Check if the head location of the snake is equal to the location of the food
			oFoodGen = 1; //If the above condition is met the oFoodGen is set high to generate the new location for the food
	/*The levels of the snake game are based on the updating length of the snake !*/
			if( oSnakeLenght == 8'd27 ) /*Contion to jump from lvl - 1  to lvl - 2*/
				oSnakeLenght = oSnakeLenght + 8'd23;
			else if(oSnakeLenght == 8'd60) /*Contion to jump from lvl - 2  to lvl - 3*/
				oSnakeLenght = oSnakeLenght + 8'd25;
			else
				oSnakeLenght = oSnakeLenght + 8'd1; /*When the snake is in a particular level its body increments by 1 when it eats food */

		end
		else 
			oFoodGen = 0;
		
		

		if ( (oSnakeLenght >= 8'd95)||( rBodyStack[0][21:11] <= 11'd212 )|| ( rBodyStack[0][21:11] >= 11'd469 )|| ( rBodyStack[0][10:0] <= 11'd112 )||( rBodyStack[0][10:0] >= 11'd368 ) )
/*The above condition checks the boundary hit condition and also the 'You won !' condition.
*/			oGameOver = 1;
		else
			oGameOver = 0;
	end
	
	else
	begin
	rBodyStack[0] = {iLocationX,iLocationY};	
	for(j=100;j>=1;j=j-1) 
	begin
		if( (rBodyStack[0] == rBodyStack[j]) &&(j <= oSnakeLenght)) //Check the condition 1 - If the head location is equal to any of the body locations the game is over
			oGameOver = 1;
 		else  //This else has been used just to maintain a flip-flop kind of harware instead of a latch
			oGameOver = 0;
				
	end
	end
/*End check for game over*/
end



always@(iPixelRow,iPixelCol) 
begin
	/*Start the generation of body*/

	case({iPixelRow,iPixelCol})
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
	  /*rBodyStack[101]:oIcon <= 3'b001;
		rBodyStack[102]:oIcon <= 3'b001;
		rBodyStack[103]:oIcon <= 3'b001;
		rBodyStack[104]:oIcon <= 3'b001;
		rBodyStack[105]:oIcon <= 3'b001;
		rBodyStack[106]:oIcon <= 3'b001;
		rBodyStack[107]:oIcon <= 3'b001;
		rBodyStack[108]:oIcon <= 3'b001;
		rBodyStack[109]:oIcon <= 3'b001;
		rBodyStack[110]:oIcon <= 3'b001;
		rBodyStack[111]:oIcon <= 3'b001;
		rBodyStack[112]:oIcon <= 3'b001;
		rBodyStack[113]:oIcon <= 3'b001;
		rBodyStack[114]:oIcon <= 3'b001;
		rBodyStack[115]:oIcon <= 3'b001;
		rBodyStack[116]:oIcon <= 3'b001;
		rBodyStack[117]:oIcon <= 3'b001;
		rBodyStack[118]:oIcon <= 3'b001;
		rBodyStack[119]:oIcon <= 3'b001;
		rBodyStack[120]:oIcon <= 3'b001;
		rBodyStack[121]:oIcon <= 3'b001;
		rBodyStack[122]:oIcon <= 3'b001;
		rBodyStack[123]:oIcon <= 3'b001;
		rBodyStack[124]:oIcon <= 3'b001;
		rBodyStack[125]:oIcon <= 3'b001;
		rBodyStack[126]:oIcon <= 3'b001;
		rBodyStack[127]:oIcon <= 3'b001;
		rBodyStack[128]:oIcon <= 3'b001;
		rBodyStack[129]:oIcon <= 3'b001;
		rBodyStack[130]:oIcon <= 3'b001;
		rBodyStack[131]:oIcon <= 3'b001;
		rBodyStack[132]:oIcon <= 3'b001;
		rBodyStack[133]:oIcon <= 3'b001;
		rBodyStack[134]:oIcon <= 3'b001;
		rBodyStack[135]:oIcon <= 3'b001;
		rBodyStack[136]:oIcon <= 3'b001;
		rBodyStack[137]:oIcon <= 3'b001;
		rBodyStack[138]:oIcon <= 3'b001;
		rBodyStack[139]:oIcon <= 3'b001;
		rBodyStack[140]:oIcon <= 3'b001;
		rBodyStack[141]:oIcon <= 3'b001;
		rBodyStack[142]:oIcon <= 3'b001;
		rBodyStack[143]:oIcon <= 3'b001;
		rBodyStack[144]:oIcon <= 3'b001;
		rBodyStack[145]:oIcon <= 3'b001;
		rBodyStack[146]:oIcon <= 3'b001;
		rBodyStack[147]:oIcon <= 3'b001;
		rBodyStack[148]:oIcon <= 3'b001;
		rBodyStack[149]:oIcon <= 3'b001;
		rBodyStack[150]:oIcon <= 3'b001;
		rBodyStack[151]:oIcon <= 3'b001;
		rBodyStack[152]:oIcon <= 3'b001;
		rBodyStack[153]:oIcon <= 3'b001;
		rBodyStack[154]:oIcon <= 3'b001;
		rBodyStack[155]:oIcon <= 3'b001;
		rBodyStack[156]:oIcon <= 3'b001;
		rBodyStack[157]:oIcon <= 3'b001;
		rBodyStack[158]:oIcon <= 3'b001;
		rBodyStack[159]:oIcon <= 3'b001;
		rBodyStack[160]:oIcon <= 3'b001;
		rBodyStack[161]:oIcon <= 3'b001;
		rBodyStack[162]:oIcon <= 3'b001;
		rBodyStack[163]:oIcon <= 3'b001;
		rBodyStack[164]:oIcon <= 3'b001;
		rBodyStack[165]:oIcon <= 3'b001;
		rBodyStack[166]:oIcon <= 3'b001;
		rBodyStack[167]:oIcon <= 3'b001;
		rBodyStack[168]:oIcon <= 3'b001;
		rBodyStack[169]:oIcon <= 3'b001;
		rBodyStack[170]:oIcon <= 3'b001;
		rBodyStack[171]:oIcon <= 3'b001;
		rBodyStack[172]:oIcon <= 3'b001;
		rBodyStack[173]:oIcon <= 3'b001;
		rBodyStack[174]:oIcon <= 3'b001;
		rBodyStack[175]:oIcon <= 3'b001;
		rBodyStack[176]:oIcon <= 3'b001;
		rBodyStack[177]:oIcon <= 3'b001;
		rBodyStack[178]:oIcon <= 3'b001;
		rBodyStack[179]:oIcon <= 3'b001;
		rBodyStack[180]:oIcon <= 3'b001;
		rBodyStack[181]:oIcon <= 3'b001;
		rBodyStack[182]:oIcon <= 3'b001;
		rBodyStack[183]:oIcon <= 3'b001;
		rBodyStack[184]:oIcon <= 3'b001;
		rBodyStack[185]:oIcon <= 3'b001;
		rBodyStack[186]:oIcon <= 3'b001;
		rBodyStack[187]:oIcon <= 3'b001;
		rBodyStack[188]:oIcon <= 3'b001;
		rBodyStack[189]:oIcon <= 3'b001;
		rBodyStack[190]:oIcon <= 3'b001;
		rBodyStack[191]:oIcon <= 3'b001;
		rBodyStack[192]:oIcon <= 3'b001;
		rBodyStack[193]:oIcon <= 3'b001;
		rBodyStack[194]:oIcon <= 3'b001;
		rBodyStack[195]:oIcon <= 3'b001;
		rBodyStack[196]:oIcon <= 3'b001;
		rBodyStack[197]:oIcon <= 3'b001;
		rBodyStack[198]:oIcon <= 3'b001;
		rBodyStack[199]:oIcon <= 3'b001;
		rBodyStack[200]:oIcon <= 3'b001;
		rBodyStack[201]:oIcon <= 3'b001;
		rBodyStack[202]:oIcon <= 3'b001;
		rBodyStack[203]:oIcon <= 3'b001;
		rBodyStack[204]:oIcon <= 3'b001;
		rBodyStack[205]:oIcon <= 3'b001;
		rBodyStack[206]:oIcon <= 3'b001;
		rBodyStack[207]:oIcon <= 3'b001;
		rBodyStack[208]:oIcon <= 3'b001;
		rBodyStack[209]:oIcon <= 3'b001;
		rBodyStack[210]:oIcon <= 3'b001;
		rBodyStack[211]:oIcon <= 3'b001;
		rBodyStack[212]:oIcon <= 3'b001;
		rBodyStack[213]:oIcon <= 3'b001;
		rBodyStack[214]:oIcon <= 3'b001;
		rBodyStack[215]:oIcon <= 3'b001;
		rBodyStack[216]:oIcon <= 3'b001;
		rBodyStack[217]:oIcon <= 3'b001;
		rBodyStack[218]:oIcon <= 3'b001;
		rBodyStack[219]:oIcon <= 3'b001;
		rBodyStack[220]:oIcon <= 3'b001;
		rBodyStack[221]:oIcon <= 3'b001;
		rBodyStack[222]:oIcon <= 3'b001;
		rBodyStack[223]:oIcon <= 3'b001;
		rBodyStack[224]:oIcon <= 3'b001;
		rBodyStack[225]:oIcon <= 3'b001;
		rBodyStack[226]:oIcon <= 3'b001;
		rBodyStack[227]:oIcon <= 3'b001;
		rBodyStack[228]:oIcon <= 3'b001;
		rBodyStack[229]:oIcon <= 3'b001;
		rBodyStack[230]:oIcon <= 3'b001;
		rBodyStack[231]:oIcon <= 3'b001;
		rBodyStack[232]:oIcon <= 3'b001;
		rBodyStack[233]:oIcon <= 3'b001;
		rBodyStack[234]:oIcon <= 3'b001;
		rBodyStack[235]:oIcon <= 3'b001;
		rBodyStack[236]:oIcon <= 3'b001;
		rBodyStack[237]:oIcon <= 3'b001;
		rBodyStack[238]:oIcon <= 3'b001;
		rBodyStack[239]:oIcon <= 3'b001;
		rBodyStack[240]:oIcon <= 3'b001;
		rBodyStack[241]:oIcon <= 3'b001;
		rBodyStack[242]:oIcon <= 3'b001;
		rBodyStack[243]:oIcon <= 3'b001;
		rBodyStack[244]:oIcon <= 3'b001;
		rBodyStack[245]:oIcon <= 3'b001;
		rBodyStack[246]:oIcon <= 3'b001;
		rBodyStack[247]:oIcon <= 3'b001;
		rBodyStack[248]:oIcon <= 3'b001;
		rBodyStack[249]:oIcon <= 3'b001;
		rBodyStack[250]:oIcon <= 3'b001;
		rBodyStack[251]:oIcon <= 3'b001;
		rBodyStack[252]:oIcon <= 3'b001;
		rBodyStack[253]:oIcon <= 3'b001;
		rBodyStack[254]:oIcon <= 3'b001;
		rBodyStack[255]:oIcon <= 3'b001;
		rBodyStack[256]:oIcon <= 3'b001;
		rBodyStack[257]:oIcon <= 3'b001;
		rBodyStack[258]:oIcon <= 3'b001;
		rBodyStack[259]:oIcon <= 3'b001;
		rBodyStack[260]:oIcon <= 3'b001;
		rBodyStack[261]:oIcon <= 3'b001;
		rBodyStack[262]:oIcon <= 3'b001;
		rBodyStack[263]:oIcon <= 3'b001;
		rBodyStack[264]:oIcon <= 3'b001;
		rBodyStack[265]:oIcon <= 3'b001;
		rBodyStack[266]:oIcon <= 3'b001;
		rBodyStack[267]:oIcon <= 3'b001;
		rBodyStack[268]:oIcon <= 3'b001;
		rBodyStack[269]:oIcon <= 3'b001;
		rBodyStack[270]:oIcon <= 3'b001;
		rBodyStack[271]:oIcon <= 3'b001;
		rBodyStack[272]:oIcon <= 3'b001;
		rBodyStack[273]:oIcon <= 3'b001;
		rBodyStack[274]:oIcon <= 3'b001;
		rBodyStack[275]:oIcon <= 3'b001;
		rBodyStack[276]:oIcon <= 3'b001;
		rBodyStack[277]:oIcon <= 3'b001;
		rBodyStack[278]:oIcon <= 3'b001;
		rBodyStack[279]:oIcon <= 3'b001;
		rBodyStack[280]:oIcon <= 3'b001;
		rBodyStack[281]:oIcon <= 3'b001;
		rBodyStack[282]:oIcon <= 3'b001;
		rBodyStack[283]:oIcon <= 3'b001;
		rBodyStack[284]:oIcon <= 3'b001;
		rBodyStack[285]:oIcon <= 3'b001;
		rBodyStack[286]:oIcon <= 3'b001;
		rBodyStack[287]:oIcon <= 3'b001;
		rBodyStack[288]:oIcon <= 3'b001;
		rBodyStack[289]:oIcon <= 3'b001;
		rBodyStack[290]:oIcon <= 3'b001;
		rBodyStack[291]:oIcon <= 3'b001;
		rBodyStack[292]:oIcon <= 3'b001;
		rBodyStack[293]:oIcon <= 3'b001;
		rBodyStack[294]:oIcon <= 3'b001;
		rBodyStack[295]:oIcon <= 3'b001;
		rBodyStack[296]:oIcon <= 3'b001;
		rBodyStack[297]:oIcon <= 3'b001;
		rBodyStack[298]:oIcon <= 3'b001;
		rBodyStack[299]:oIcon <= 3'b001;
		rBodyStack[300]:oIcon <= 3'b001;
		rBodyStack[301]:oIcon <= 3'b001;
		rBodyStack[302]:oIcon <= 3'b001;
		rBodyStack[303]:oIcon <= 3'b001;
		rBodyStack[304]:oIcon <= 3'b001;
		rBodyStack[305]:oIcon <= 3'b001;
		rBodyStack[306]:oIcon <= 3'b001;
		rBodyStack[307]:oIcon <= 3'b001;
		rBodyStack[308]:oIcon <= 3'b001;
		rBodyStack[309]:oIcon <= 3'b001;
		rBodyStack[310]:oIcon <= 3'b001;
		rBodyStack[311]:oIcon <= 3'b001;
		rBodyStack[312]:oIcon <= 3'b001;
		rBodyStack[313]:oIcon <= 3'b001;
		rBodyStack[314]:oIcon <= 3'b001;
		rBodyStack[315]:oIcon <= 3'b001;
		rBodyStack[316]:oIcon <= 3'b001;
		rBodyStack[317]:oIcon <= 3'b001;
		rBodyStack[318]:oIcon <= 3'b001;
		rBodyStack[319]:oIcon <= 3'b001;
		rBodyStack[320]:oIcon <= 3'b001;
		rBodyStack[321]:oIcon <= 3'b001;
		rBodyStack[322]:oIcon <= 3'b001;
		rBodyStack[323]:oIcon <= 3'b001;
		rBodyStack[324]:oIcon <= 3'b001;
		rBodyStack[325]:oIcon <= 3'b001;
		rBodyStack[326]:oIcon <= 3'b001;
		rBodyStack[327]:oIcon <= 3'b001;
		rBodyStack[328]:oIcon <= 3'b001;
		rBodyStack[329]:oIcon <= 3'b001;
		rBodyStack[330]:oIcon <= 3'b001;
		rBodyStack[331]:oIcon <= 3'b001;
		rBodyStack[332]:oIcon <= 3'b001;
		rBodyStack[333]:oIcon <= 3'b001;
		rBodyStack[334]:oIcon <= 3'b001;
		rBodyStack[335]:oIcon <= 3'b001;
		rBodyStack[336]:oIcon <= 3'b001;
		rBodyStack[337]:oIcon <= 3'b001;
		rBodyStack[338]:oIcon <= 3'b001;
		rBodyStack[339]:oIcon <= 3'b001;
		rBodyStack[340]:oIcon <= 3'b001;
		rBodyStack[341]:oIcon <= 3'b001;
		rBodyStack[342]:oIcon <= 3'b001;
		rBodyStack[343]:oIcon <= 3'b001;
		rBodyStack[344]:oIcon <= 3'b001;
		rBodyStack[345]:oIcon <= 3'b001;
		rBodyStack[346]:oIcon <= 3'b001;
		rBodyStack[347]:oIcon <= 3'b001;
		rBodyStack[348]:oIcon <= 3'b001;
		rBodyStack[349]:oIcon <= 3'b001;
		rBodyStack[350]:oIcon <= 3'b001;
		rBodyStack[351]:oIcon <= 3'b001;
		rBodyStack[352]:oIcon <= 3'b001;
		rBodyStack[353]:oIcon <= 3'b001;
		rBodyStack[354]:oIcon <= 3'b001;
		rBodyStack[355]:oIcon <= 3'b001;
		rBodyStack[356]:oIcon <= 3'b001;
		rBodyStack[357]:oIcon <= 3'b001;
		rBodyStack[358]:oIcon <= 3'b001;
		rBodyStack[359]:oIcon <= 3'b001;
		rBodyStack[360]:oIcon <= 3'b001;
		rBodyStack[361]:oIcon <= 3'b001;
		rBodyStack[362]:oIcon <= 3'b001;
		rBodyStack[363]:oIcon <= 3'b001;
		rBodyStack[364]:oIcon <= 3'b001;
		rBodyStack[365]:oIcon <= 3'b001;
		rBodyStack[366]:oIcon <= 3'b001;
		rBodyStack[367]:oIcon <= 3'b001;
		rBodyStack[368]:oIcon <= 3'b001;
		rBodyStack[369]:oIcon <= 3'b001;
		rBodyStack[370]:oIcon <= 3'b001;
		rBodyStack[371]:oIcon <= 3'b001;
		rBodyStack[372]:oIcon <= 3'b001;
		rBodyStack[373]:oIcon <= 3'b001;
		rBodyStack[374]:oIcon <= 3'b001;
		rBodyStack[375]:oIcon <= 3'b001;
		rBodyStack[376]:oIcon <= 3'b001;
		rBodyStack[377]:oIcon <= 3'b001;
		rBodyStack[378]:oIcon <= 3'b001;
		rBodyStack[379]:oIcon <= 3'b001;
		rBodyStack[380]:oIcon <= 3'b001;
		rBodyStack[381]:oIcon <= 3'b001;
		rBodyStack[382]:oIcon <= 3'b001;
		rBodyStack[383]:oIcon <= 3'b001;
		rBodyStack[384]:oIcon <= 3'b001;
		rBodyStack[385]:oIcon <= 3'b001;
		rBodyStack[386]:oIcon <= 3'b001;
		rBodyStack[387]:oIcon <= 3'b001;
		rBodyStack[388]:oIcon <= 3'b001;
		rBodyStack[389]:oIcon <= 3'b001;
		rBodyStack[390]:oIcon <= 3'b001;
		rBodyStack[391]:oIcon <= 3'b001;
		rBodyStack[392]:oIcon <= 3'b001;
		rBodyStack[393]:oIcon <= 3'b001;
		rBodyStack[394]:oIcon <= 3'b001;
		rBodyStack[395]:oIcon <= 3'b001;
		rBodyStack[396]:oIcon <= 3'b001;
		rBodyStack[397]:oIcon <= 3'b001;
		rBodyStack[398]:oIcon <= 3'b001;
		rBodyStack[399]:oIcon <= 3'b001;
		rBodyStack[400]:oIcon <= 3'b001;
		rBodyStack[401]:oIcon <= 3'b001;
		rBodyStack[402]:oIcon <= 3'b001;
		rBodyStack[403]:oIcon <= 3'b001;
		rBodyStack[404]:oIcon <= 3'b001;
		rBodyStack[405]:oIcon <= 3'b001;
		rBodyStack[406]:oIcon <= 3'b001;
		rBodyStack[407]:oIcon <= 3'b001;
		rBodyStack[408]:oIcon <= 3'b001;
		rBodyStack[409]:oIcon <= 3'b001;
		rBodyStack[410]:oIcon <= 3'b001;
		rBodyStack[411]:oIcon <= 3'b001;
		rBodyStack[412]:oIcon <= 3'b001;
		rBodyStack[413]:oIcon <= 3'b001;
		rBodyStack[414]:oIcon <= 3'b001;
		rBodyStack[415]:oIcon <= 3'b001;
		rBodyStack[416]:oIcon <= 3'b001;
		rBodyStack[417]:oIcon <= 3'b001;
		rBodyStack[418]:oIcon <= 3'b001;
		rBodyStack[419]:oIcon <= 3'b001;
		rBodyStack[420]:oIcon <= 3'b001;
		rBodyStack[421]:oIcon <= 3'b001;
		rBodyStack[422]:oIcon <= 3'b001;
		rBodyStack[423]:oIcon <= 3'b001;
		rBodyStack[424]:oIcon <= 3'b001;
		rBodyStack[425]:oIcon <= 3'b001;
		rBodyStack[426]:oIcon <= 3'b001;
		rBodyStack[427]:oIcon <= 3'b001;
		rBodyStack[428]:oIcon <= 3'b001;
		rBodyStack[429]:oIcon <= 3'b001;
		rBodyStack[430]:oIcon <= 3'b001;
		rBodyStack[431]:oIcon <= 3'b001;
		rBodyStack[432]:oIcon <= 3'b001;
		rBodyStack[433]:oIcon <= 3'b001;
		rBodyStack[434]:oIcon <= 3'b001;
		rBodyStack[435]:oIcon <= 3'b001;
		rBodyStack[436]:oIcon <= 3'b001;
		rBodyStack[437]:oIcon <= 3'b001;
		rBodyStack[438]:oIcon <= 3'b001;
		rBodyStack[439]:oIcon <= 3'b001;
		rBodyStack[440]:oIcon <= 3'b001;
		rBodyStack[441]:oIcon <= 3'b001;
		rBodyStack[442]:oIcon <= 3'b001;
		rBodyStack[443]:oIcon <= 3'b001;
		rBodyStack[444]:oIcon <= 3'b001;
		rBodyStack[445]:oIcon <= 3'b001;
		rBodyStack[446]:oIcon <= 3'b001;
		rBodyStack[447]:oIcon <= 3'b001;
		rBodyStack[448]:oIcon <= 3'b001;
		rBodyStack[449]:oIcon <= 3'b001;
		rBodyStack[450]:oIcon <= 3'b001;
		rBodyStack[451]:oIcon <= 3'b001;
		rBodyStack[452]:oIcon <= 3'b001;
		rBodyStack[453]:oIcon <= 3'b001;
		rBodyStack[454]:oIcon <= 3'b001;
		rBodyStack[455]:oIcon <= 3'b001;
		rBodyStack[456]:oIcon <= 3'b001;
		rBodyStack[457]:oIcon <= 3'b001;
		rBodyStack[458]:oIcon <= 3'b001;
		rBodyStack[459]:oIcon <= 3'b001;
		rBodyStack[460]:oIcon <= 3'b001;
		rBodyStack[461]:oIcon <= 3'b001;
		rBodyStack[462]:oIcon <= 3'b001;
		rBodyStack[463]:oIcon <= 3'b001;
		rBodyStack[464]:oIcon <= 3'b001;
		rBodyStack[465]:oIcon <= 3'b001;
		rBodyStack[466]:oIcon <= 3'b001;
		rBodyStack[467]:oIcon <= 3'b001;
		rBodyStack[468]:oIcon <= 3'b001;
		rBodyStack[469]:oIcon <= 3'b001;
		rBodyStack[470]:oIcon <= 3'b001;
		rBodyStack[471]:oIcon <= 3'b001;
		rBodyStack[472]:oIcon <= 3'b001;
		rBodyStack[473]:oIcon <= 3'b001;
		rBodyStack[474]:oIcon <= 3'b001;
		rBodyStack[475]:oIcon <= 3'b001;
		rBodyStack[476]:oIcon <= 3'b001;
		rBodyStack[477]:oIcon <= 3'b001;
		rBodyStack[478]:oIcon <= 3'b001;
		rBodyStack[479]:oIcon <= 3'b001;
		rBodyStack[480]:oIcon <= 3'b001;
		rBodyStack[481]:oIcon <= 3'b001;
		rBodyStack[482]:oIcon <= 3'b001;
		rBodyStack[483]:oIcon <= 3'b001;
		rBodyStack[484]:oIcon <= 3'b001;
		rBodyStack[485]:oIcon <= 3'b001;
		rBodyStack[486]:oIcon <= 3'b001;
		rBodyStack[487]:oIcon <= 3'b001;
		rBodyStack[488]:oIcon <= 3'b001;
		rBodyStack[489]:oIcon <= 3'b001;
		rBodyStack[490]:oIcon <= 3'b001;
		rBodyStack[491]:oIcon <= 3'b001;
		rBodyStack[492]:oIcon <= 3'b001;
		rBodyStack[493]:oIcon <= 3'b001;
		rBodyStack[494]:oIcon <= 3'b001;
		rBodyStack[495]:oIcon <= 3'b001;
		rBodyStack[496]:oIcon <= 3'b001;
		rBodyStack[497]:oIcon <= 3'b001;
		rBodyStack[498]:oIcon <= 3'b001;
		rBodyStack[499]:oIcon <= 3'b001;
		rBodyStack[500]:oIcon <= 3'b001;
		rBodyStack[501]:oIcon <= 3'b001;
		rBodyStack[502]:oIcon <= 3'b001;
		rBodyStack[503]:oIcon <= 3'b001;
		rBodyStack[504]:oIcon <= 3'b001;
		rBodyStack[505]:oIcon <= 3'b001;
		rBodyStack[506]:oIcon <= 3'b001;
		rBodyStack[507]:oIcon <= 3'b001;
		rBodyStack[508]:oIcon <= 3'b001;
		rBodyStack[509]:oIcon <= 3'b001;
		rBodyStack[510]:oIcon <= 3'b001;*/
		
		default:oIcon <= 3'b000; /*This will be used in the colorizer to set the priority*/
	endcase
end

endmodule
			

