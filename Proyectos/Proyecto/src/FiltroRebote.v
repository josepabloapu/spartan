
`timescale 1ns / 1ps

module FiltroRebote
(
	input 	wire Clock,
	input 	wire  [3:0] iPushBtn,
	output 	reg   [3:0] oPushBtn
);
reg [23:0]	rReboteCount = 23'd0;	//counter for debouncer
reg [3:0]	rShiftPb0 = 4'd0, rShiftPb1 = 4'd0, rShiftPb2 = 4'd0, rShiftPb3 = 4'd0;

parameter Simulate = 0;
parameter ContRebote = Simulate ? 21'd5
								: 23'd3000000;

always @(posedge Clock)
begin
	if(ContRebote == rReboteCount)
		rReboteCount <= 23'd0;
	else
		rReboteCount <= rReboteCount+1'b1;
end

always @(posedge Clock) 
begin
	if(ContRebote == rReboteCount)
	begin
		rShiftPb0 <= (rShiftPb0 << 1) | iPushBtn[0];
		rShiftPb1 <= (rShiftPb1 << 1) | iPushBtn[1];
		rShiftPb2 <= (rShiftPb2 << 1) | iPushBtn[2];
		rShiftPb3 <= (rShiftPb3 << 1) | iPushBtn[3];
	end
	case(rShiftPb0) 
		4'b0000: oPushBtn[0] <= 0; 
		4'b1111: oPushBtn[0] <= 1; 
	endcase
	
	case(rShiftPb1) 
		4'b0000: oPushBtn[1] <= 0; 
		4'b1111: oPushBtn[1] <= 1; 
	endcase
	case(rShiftPb2) 
		4'b0000: oPushBtn[2] <= 0; 
		4'b1111: oPushBtn[2] <= 1; 
	endcase
	case(rShiftPb3) 
		4'b0000: oPushBtn[3] <= 0; 
		4'b1111: oPushBtn[3] <= 1; 
	endcase
end	
endmodule
