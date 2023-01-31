`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/24 13:41:27
// Design Name: 
// Module Name: create_waves
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


module create_waves(
input   clk,//10kHz
    input   rst_n,
    input [7:0]switches,
    
    input [7:0]step,
    
    output  reg [7:0]   cos_s,
    output  reg signed  [7:0]   cos_c
    );

wire [31:0]freq_s;
assign freq_s = 32'd429497*switches;          //调制信号频率1Hz*switches
parameter freq_c = 32'd42949673;        //载波频率100Hz
parameter cnt_width = 8'd32;
reg     [cnt_width-1:0] cnt_s = 0;
reg     [cnt_width-1:0] cnt_c = 0;
   wire    [7:0]   addr_s;
    wire   [7:0]   addr_c;

    wire    signed  [7:0]   cos_s_r;        //调制信号
    wire    signed  [7:0]   cos_c_r;        //载波信号
    

    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  begin
            cnt_s <= 0;
            cnt_c <= 0;
        end
        else    begin
            cnt_s <= cnt_s + freq_s;
            cnt_c <= cnt_c + freq_c;
        end
    end
    
    assign  addr_s = cnt_s[cnt_width-1:cnt_width-8];//取32-24位
    assign  addr_c = cnt_c[cnt_width-1:cnt_width-8];
    
    carrier_modulating_rom         ROM_inst(
        .clka   (clk),
        .addra  (addr_s),
        .douta  (cos_s_r),
        .clkb   (clk),
        .addrb  (addr_c),
        .doutb  (cos_c_r)
    );
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  begin
            cos_s <= 0;
            cos_c <= 0;
        end
        else    begin
            cos_s <= cos_s_r + 8 'd128;     //加上大小为峰值的直流分量
            cos_c <= cos_c_r;
        end
    end
endmodule
