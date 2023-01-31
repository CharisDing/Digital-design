`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/24 08:39:38
// Design Name: 
// Module Name: am_modulation
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


module am_modulation(

    input       clk,//10kHz
    input       rst_n,
    input [7:0]step,
    input [7:0]switches,
    output  reg signed  [7:0]  AM_mod
);

wire    [7:0]   cos_s;
wire    signed  [7:0]   cos_c;
wire  signed  [15:0]  AM_mod0;

always@*
AM_mod<= AM_mod0[15:8];

//------------调用出波模块------------//
create_waves        cos_make_inst0(
    .clk            (clk),
    .rst_n      (rst_n),
    
    .step(step),
    .switches(switches),
    
    .cos_s      (cos_s),
    .cos_c      (cos_c)
);
//-----------------------------------//

//------------调用乘法器--------------//
MULT        MULT_inst1(     
  .CLK  (clk),
  .A        (cos_s),
  .B        (cos_c),
  .P        (AM_mod0)
);
       
endmodule
