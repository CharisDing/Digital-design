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
input clk,                          //50Mʱ��
input rst,                          //��λ
output [7:0] data                   //rom ���������
);
 
 
 
reg [7:0] addr;                            //rom ���ݵ�ַ
always@ (posedge clk or negedge rst) begin 
if (!rst)
addr <= 0;                                  //��λ��ַ����
else 
addr <= addr + 1;                           //��ַ����
end 
sin_rom your_instance_name (         //������ROM
.a(addr), // input wire [7 : 0] a
.clk(clk), // input wire clk
.qspo(data) // output wire [7 : 0] qspo
);
 
 
 
endmodule
