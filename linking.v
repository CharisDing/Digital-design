`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 18:44:40
// Design Name: 
// Module Name: linking
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


module linking(                     
input clk,                          //50M时钟
input rst,                          //复位
output [7:0] data                   //rom 输出的数据
);
 
 
 
reg [7:0] addr;                            //rom 数据地址
always@ (posedge clk or negedge rst) begin 
if (!rst)
addr <= 0;                                  //复位地址清零
else 
addr <= addr + 1;                           //地址自增
end 
sin_rom your_instance_name (         //例化的ROM
.a(addr), // input wire [7 : 0] a
.clk(clk), // input wire clk
.qspo(data) // output wire [7 : 0] qspo
);
 
 
 
endmodule
