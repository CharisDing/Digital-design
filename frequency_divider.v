`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/18 20:21:38
// Design Name: 
// Module Name: frequency_divider
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


module frequency_divider(
input sys_clk,
input reset_n,
output reg accumulator_scanner_clk,
      reg frequency_std_clk
    );
parameter NUM_DIV1 = 200_000_000;//True:200_000_000
parameter NUM_DIV2 =10_000;

reg[28:0] cnt1,cnt2;      //cnt1:0.5Hz计数，cnt2:10kHz计数
always@ (posedge sys_clk)

if(cnt1<NUM_DIV1/2-1) //cnt<99_999_999=10^8,10^8*10ns=1s
    begin
        cnt1<=cnt1+1'b1;
        frequency_std_clk<=frequency_std_clk;
        
        if(cnt2<NUM_DIV2/2-1)//cnt<4999,5*10^3*10^-8=5*10^-5
            begin
                cnt2<=cnt2+1'b1;
                accumulator_scanner_clk<=accumulator_scanner_clk;
            end
            
        else
            begin
                cnt2<=29'd0;
                accumulator_scanner_clk<= ~accumulator_scanner_clk;
            end
    end

else
if(!reset_n)
    begin
        cnt1<=29'd0;
        cnt2<=29'd0;
        frequency_std_clk<=0;
        accumulator_scanner_clk<=0;
    end

else
    begin
        cnt1<=29'd0;
        cnt2<=29'd0;
        frequency_std_clk<= ~frequency_std_clk;
    end
    
endmodule
