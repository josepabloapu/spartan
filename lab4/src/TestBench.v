`timescale 1ns / 1ps

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

	// Outputs
	wire [7:0] oLed;
	reg wUartTx,wUartRx;

	// Instantiate the Unit Under Test (UUT)
	MiniAlu uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.oUartTx(wUartTx),
		.iUartRx(wUartRx),
		.oLed(oLed)
	);
	
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
		#100;
		Reset = 1;
		wUartRx = 0;
		#50
		
		Reset = 0;
		#50
		#50
		#50
		#50
		#50
		#50
		wUartRx = 1;
		#50
		wUartRx = 0 ;
		#50
		wUartRx = 1;
        
		// Add stimulus here

	end
      
endmodule

