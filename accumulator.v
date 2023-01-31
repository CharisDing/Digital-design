`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 10:54:15
// Design Name: 
// Module Name: accumulator
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


module accumulator(                     
input clk,                          //10kHz时钟
input sys_clk,                      //100MHz
input rst,                          //复位
input [7:0]switches,               //拨码开关输入


output wire[7:0]data_sin,                   //rom 输出的数据
output wire[7:0]data_saw,
output wire[7:0]data_squ,
output wire[7:0]data_tri


);
 
reg[7:0] addr_sin;                            //rom 数据地址
reg[7:0] addr_saw;
reg[7:0] addr_squ;
reg[7:0] addr_tri;

//reg sin_clk,squ_clk,tri_clk,saw_clk;

wire s3;
wire [1:0]index;


always@ (posedge clk or negedge rst) 
begin 


if (!rst)
begin
addr_sin<= 8'b0;                                  //复位地址清零
addr_saw<= 8'b0;
addr_squ<= 8'b0;
addr_tri<= 8'b0;
end
else
begin
addr_sin <= addr_sin + switches;                           //地址自增
addr_saw <= addr_saw + switches;                           //地址自增
addr_squ <= addr_squ + switches;                           //地址自增
addr_tri <= addr_tri + switches;                           //地址自增
end 
end

sin_rom your_instance_name0 (         //例化的ROM
.a(addr_sin), // input wire [7 : 0] a
//.clk(sin_clk), // input wire clk
.clk(clk),
.qspo(data_sin) // output wire [7 : 0] qspo
);
 
square_rom your_instance_name1 (         //例化的ROM
.a(addr_squ), // input wire [7 : 0] a
//.clk(squ_clk), // input wire clk
.clk(clk),
.qspo(data_squ) // output wire [7 : 0] qspo
);
 
tri_rom your_instance_name2 (         //例化的ROM
.a(addr_tri), // input wire [7 : 0] a
//.clk(tri_clk), // input wire clk
.clk(clk),
.qspo(data_tri) // output wire [7 : 0] qspo
);

saw_rom your_instance_name3 (         //例化的ROM
.a(addr_saw), // input wire [7 : 0] a
//.clk(saw_clk), // input wire clk
.clk(clk),
.qspo(data_saw) // output wire [7 : 0] qspo
);

button u(
    .s3(s3),
    .sys_clk(sys_clk),
    .reset_n(rst),
    .index(index)
);

endmodule

