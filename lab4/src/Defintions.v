`timescale 1ns / 1ps
`ifndef DEFINTIONS_V
`define DEFINTIONS_V
`define WIDTH 16	
//UART defines
`define UART_WORD_OUT_SZ      8
`define UART_BAUD_RATE_CNT_SZ 5
//UART commands
`define UART_WRITE 1'b1
`define UART_READ  1'b0

`default_nettype none	
`define NOP   4'd0
`define LED   4'd2
`define BLE   4'd3
`define STO   4'd4
`define ADD   4'd5
`define JMP   4'd6

`define R0 8'd0
`define R1 8'd1
`define R2 8'd2
`define R3 8'd3
`define R4 8'd4
`define R5 8'd5
`define R6 8'd6
`define R7 8'd7

`define COLOR_BLACK   12'b000000000000
`define COLOR_BLUE    12'b000000001111
`define COLOR_GREEN   12'b000011110000
`define COLOR_CYAN    12'b000011111111
`define COLOR_RED     12'b111100000000
`define COLOR_MAGENTA 12'b111100001111
`define COLOR_YELLOW  12'b111111110000
`define COLOR_WHITE   12'b111111111111

`endif
