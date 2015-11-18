`timescale 1ns / 1ps
//`include "VgaMarcs.v"
//`include "VgaController.v"
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:30:52 01/30/2011
// Design Name:   MiniAlu
// Module Name:   D:/Proyecto/RTL/Dev/MiniALU/TestBench.v
// Project Name:  MiniALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MiniAlu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench;

	// Inputs
	reg Clock;
	reg Reset;
	reg W,E,N,S;
	//wire [10:0] Col;
	//wire [10:0] Row;
	// Outputs
	//wire [7:0] oLed;
	//reg wUartTx,wUartRx;
	//wire [3:0] oVgaRed,oVgaGreen,oVgaBlue;
	wire oVgaVsync;
	wire oVgaHsync;
	//wire On;
	wire [3:0] R,G,B;
	// Instantiate the Unit Under Test (UUT)
Main Test
(
	.Clock(Clock), // 32 MHz frequency clock from papilio board.
	.Reset(Reset),	
	.iWest(W),
	.iEast(E),
	.iNorth(N),
	.iSouth(S),
	.oVgaVsync(oVgaVsync),
	.oVgaHsync(oVgaHsync),
	.oRed(R),
	.oGreen(G),
	.oBlue(B)
);

/*VgaController  Puta(
	.Clock(Clock),
	.Reset(Reset),
	.oVideoOn(On),
	.oColCurrent(Col),
	.oRowCurrent(Row),
	.oVgaVsync(oVgaVsync),
	.oVgaHsync(oVgaHsync)
);*/



	always
	begin
		//#(31.25/2)  Clock =  ! Clock;	//32Mhz
		#5  Clock =  ! Clock;	//32Mhz

	end

	initial begin
		// Initialize Inputs
		Clock = 0;
		Reset = 0;

		// Wait 100 ns for global reset to finish
		#20;
		Reset = 1;
		//wUartRx = 0;
		#10000
		
		Reset = 0;
		#1000
		E=1;
		/*#10000
		E=0;
		N=1;*/
	/*	#50
		#50
		#50
		#50
		#50
		#50
		wUartRx = 1;
		#50
		wUartRx = 0 ;
		#50
		wUartRx = 1;*/
        
		// Add stimulus here

	end
      
endmodule

