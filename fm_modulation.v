`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/25 18:43:12
// Design Name: 
// Module Name: fm_modulation
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


module fm_modulation(
input clk,//10khz
input reset_n,

input [7:0]switches,
output reg signed  [7:0]cos_c

);

wire signed[7:0]cos_s;
wire    [7:0]   addr_s;
wire    [31:0]   freq_c;
assign freq_c = 32'd42949673+cos_s*32'd429497/2; //(100+cos_s/2)Hz 中心频率164hz,最大频偏64hz
parameter cnt_width = 8'd32;
reg     [cnt_width-1:0] cnt_c = 0;
wire    [7:0]   addr_c;
wire    signed  [7:0]   cos_c_r;
assign  addr_c = cnt_c[cnt_width-1:cnt_width-8];

always @(posedge clk or negedge reset_n) begin
if(!reset_n)
    cnt_c <= 0;
else 
    cnt_c <= cnt_c + freq_c;
    end
    
always @(posedge clk or negedge reset_n) 
if(!reset_n) 
     cos_c <= 0;
else
    cos_c<=cos_c_r;
    
create_waves u0(               //调用低频波形
.clk(clk),
.rst_n(reset_n),
.switches(switches),
.cos_s(cos_s)

);

fm_rom urom(
.clk(clk),
.qspo(cos_c_r),
.a(addr_c)
);
endmodule

