`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/20 11:11:37
// Design Name: 
// Module Name: frequency_calculating
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module frequency_calculating(
input [7:0]FSW,//     1<FSW<128,  FSW=switches
output reg[12:0]frequency_calculated
    );
    
parameter accumulator_scanner_clk=10000;//10kHz
parameter num=256;

always
    begin
        frequency_calculated=FSW*accumulator_scanner_clk/num;
        #10;
    end
endmodule
