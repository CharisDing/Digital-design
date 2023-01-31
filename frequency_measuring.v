`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/20 08:27:02
// Design Name: 
// Module Name: frequency_measuring
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
//MSB:1->0->1->0->1:2个周期
//MSB：0->1->0->1->0:2个周期

module frequency_measuring(
input frequency_std_clk,reset_n,
input[7:0] data,
output reg[12:0] frequency_measured
//output reg[12:0] cnt
    );
reg[12:0] cnt; 

initial
begin
    cnt <= 13'b0;
    frequency_measured <= 13'b0;
end

always@(posedge data[7])//为了节省仿真时间，下降沿计数
    if(!frequency_std_clk)
        cnt<=cnt+1'b1;
    else
        cnt <= 13'b0;
    
always@(posedge frequency_std_clk)//上升沿清零，cnt赋值给测频变量
    frequency_measured <= cnt;

    
endmodule
