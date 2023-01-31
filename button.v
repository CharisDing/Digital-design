`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/22 16:53:12
// Design Name: 
// Module Name: button
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


module button(
input s3,
input sys_clk,
input reset_n,
output reg[2:0]index
    );
/*always@(posedge s3 or negedge reset_n)
    begin
        if(!reset_n) 
        begin
            index<=3'b000;
        end
        else
        if (s3==1) 
            begin
                #10_000000;
                if(s3==1)
                    index<=index+1'b1;
            end
     end*/
reg [18:0]cnt;
reg cnt_full;
always@(posedge sys_clk or negedge reset_n)
     if(!reset_n) cnt<=19'b0;
     else if (s3==1) cnt<=cnt+1'b1;
     else cnt<=19'b0;

always@(posedge sys_clk or negedge reset_n)
    if(!reset_n) cnt_full<=1'b0;
    else if(cnt==499999)//5*10^5*10^-8=5ms
        cnt_full<=1'b1;
    else if (s3==0) 
        cnt_full<=1'b0;
    else cnt_full<=cnt_full;

always@(posedge sys_clk or negedge reset_n)
    if(!reset_n) index<=3'b000;
    else if (cnt==499999&&cnt_full==1'b0)
        index<=index+1'b1;

   
endmodule