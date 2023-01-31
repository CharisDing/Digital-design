`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/26 08:19:13
// Design Name: 
// Module Name: fsk_modulation
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


module fsk_modulation(
input clk,
input rst_n,
input [7:0]switches,
input key,
output reg [7:0]fsk_mode 
    );
    
  wire [31:0]freq_s;
    assign freq_s = 32'd429497*switches;          //�����ź�Ƶ��1Hz*switches,,switches=8'd11001,Ƶ����Ϊ25Hz
    parameter freq_c = 32'd42949673;        //�ز�Ƶ��100Hz
    parameter cnt_width = 8'd32;
    reg     [cnt_width-1:0] cnt_s = 0;
    reg     [cnt_width-1:0] cnt_c = 0;
       wire    [7:0]   addr_s;
        wire   [7:0]   addr_c;
    
        wire    signed  [7:0]   cos_s_r;
        wire    signed  [7:0]   cos_c_r;
        
    reg  [7:0]   cos_s;
    reg  [7:0]   cos_c;
        
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
        
        assign  addr_s = cnt_s[cnt_width-1:cnt_width-8];
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
                cos_s <= cos_s_r;     //���ϴ�СΪ��ֵ��ֱ������
                cos_c <= cos_c_r;
            end
        end  
    
    always @*
    if(key==1)
        fsk_mode<=cos_c;
    else if(key==0)
        fsk_mode<=cos_s;
    
endmodule
