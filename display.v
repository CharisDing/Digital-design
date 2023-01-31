`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/20 15:38:28
// Design Name: 
// Module Name: display
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


module display(
input display_clk,reset_n,//display_clk=10kHz
//input [3:0] in3,in2,in1,in0,
input [12:0]num_bin,
output reg[6:0] sseg,
output reg[3:0] sel
    );
reg [3:0]in3,in2,in1,in0,in;//4位二进制数表示一位十进制数, in3为最高位
//reg [3:0]num_dec;
reg[1:0] regN=0;

always@(posedge display_clk,posedge reset_n)
    if(!reset_n)
        regN <= 0;
    else
        regN <= regN + 1'b1;




always@*
    case(regN)
        2'b00:begin in<=in0;sel=4'b0001;end
        2'b01:begin in<=in1;sel=4'b0010;end
        2'b10:begin in<=in2;sel=4'b0100;end
        2'b11:begin in<=in3;sel=4'b1000;end
        default:in<=in0;
    endcase
    
always@*
    begin
        in3<=num_bin/10'b1111101000;//1000
        in2<=(num_bin-in3*1000)/7'b1100100;
        in1<=(num_bin-in3*1000-in2*100)/4'b1010;
        in0<=num_bin-in3*1000-in2*100-in1*10;
    end
    
always@*
    begin
        case(in)
            4'd0:sseg[6:0]=7'b0111111;//3f
            4'd1:sseg[6:0]=7'b0000110;//06
            4'd2:sseg[6:0]=7'b1011011;//5b
            4'd3:sseg[6:0]=7'b1001111;//4f
            4'd4:sseg[6:0]=7'b1100110;//66     
            4'd5:sseg[6:0]=7'b1101101;//6d
            4'd6:sseg[6:0]=7'b1111101;//7d
            4'd7:sseg[6:0]=7'b0000111;//07
            4'd8:sseg[6:0]=7'b1111111;//7f
            4'd9:sseg[6:0]=7'b1101111;//6f
            default:sseg[6:0]=7'b0111111;//3f
        endcase
    end    
endmodule
