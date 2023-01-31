`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/21 11:55:03
// Design Name: 
// Module Name: DDS_top
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


module DDS_top(
input sys_clk,                           //frequency divider
input reset_n,                           //frequency divider
output accumulator_scanner_clk,          //frequency divider
       frequency_std_clk,                //frequency divider
      
input [7:0]switches,                      //accumulator
output reg[7:0]data,                           //top

output reg ILE=1,                         //accumulator
output reg CS=0,                         //accumulator
output reg WR1=0,                         //accumulator
output reg WR2=0,                         //accumulator
output reg XFER=0,                         //accumulator

output [6:0]sseg,                               //display
output [3:0]sel,                                 //display

output [6:0]sseg_left,                               //display_left
output [3:0]sel_left,                                 //display_left

input s3,                                            //button
output [2:0]index,
input filter_s0,                                    //filter
input s4                                           //fsk_modulation
    );

wire [12:0]frequency_measured;                  //frequency_measuring
wire [12:0]frequency_calculated;               //frequency_calculating

wire [7:0]data_sin;                         //accumulator
wire [7:0]data_saw;                         //accumulator
wire [7:0]data_squ;                         //accumulator
wire [7:0]data_tri;                         //accumulator

wire [7:0]AM_mod;
wire [7:0]cos_c;
wire [7:0]fsk_mode;
reg key;
wire [7:0]filter_out;

always@*
    if(index==3'b000)
        begin
            data<=8'b0000_0000;
            if(filter_s0)
                begin
                    #50_000_000
                    if(filter_s0)
                        data<=filter_out;
                end
            else
                data<=data_sin;
         end
    else if(index==3'b001)
        begin
            data<=8'b0000_0000;
            data<=data_saw; 
         end       
    else if(index==3'b010)
        begin
            data<=8'b0000_0000;
            data<=data_squ;
        end
    else if(index==3'b011)
        begin
            data<=8'b0000_0000;
            data<=data_tri;    
        end
    else if(index==3'b100)
        begin
             data<=8'b0000_0000;
             data<=AM_mod+8'd128;   
        end    
    else if(index==3'b101)
        begin
            data<=8'b0000_0000;
            data<=cos_c+8'd128;   
        end     
    else if(index==3'b110)
        begin
            data<=8'b0000_0000;
            data<=fsk_mode+8'd128;
        end
        
initial         //fsk
key=0;
always@*
    if(s4==1)
    begin
        #50_000_000
        if(s4==1)
            key<=s4;
    end
    
    else if(s4==0)
    begin
        #50_000_000
        if(s4==0)
            key<=s4;
    end    
    
    
frequency_divider u0(
    .sys_clk(sys_clk),
    .reset_n(reset_n),
    .accumulator_scanner_clk(accumulator_scanner_clk),
    .frequency_std_clk(frequency_std_clk)
    );
    
accumulator u1(
    .clk (accumulator_scanner_clk) ,
    .sys_clk(sys_clk),
    .rst (reset_n) ,
    .data_sin (data_sin) ,
    .data_saw (data_saw) ,
    .data_squ (data_squ) ,
    .data_tri (data_tri) ,
    .switches(switches)
    );
    
frequency_measuring u2(
    .frequency_std_clk(frequency_std_clk),
    .reset_n(reset_n),
    .data(data),
    .frequency_measured(frequency_measured)
    );

frequency_calculating u3(
    .FSW(switches),
    .frequency_calculated(frequency_calculated)
);

display u4(
    .display_clk(accumulator_scanner_clk),
    .reset_n(reset_n),
    .num_bin(frequency_measured),
    .sseg(sseg),
    .sel(sel)
);

display_left u5(
    .display_clk(accumulator_scanner_clk),
    .reset_n(reset_n),
    .num_bin(frequency_calculated),
    .sseg_left(sseg_left),
    .sel_left(sel_left)
);

button u6(
    .s3(s3),
    .sys_clk(sys_clk),
    .reset_n(reset_n),
    .index(index)
);

am_modulation u7(
    .clk(accumulator_scanner_clk),
    .rst_n(reset_n),
    .AM_mod(AM_mod),
    .switches(switches)
);

fm_modulation u8(
    .clk(accumulator_scanner_clk),
    .reset_n(reset_n),
    .cos_c(cos_c),
    .switches(switches)    
);

fsk_modulation u9(
    .clk(accumulator_scanner_clk),
    .rst_n(reset_n),
    .switches(switches),
    .key(key),
    .fsk_mode(fsk_mode)
);

lowpass_filter u10(
    .clk(accumulator_scanner_clk),
    .sys_clk(sys_clk),
    .switches(switches),
    .reset_n(reset_n),
    .filter_out(filter_out)
);
endmodule
