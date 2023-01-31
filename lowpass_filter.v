`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/26 17:22:31
// Design Name: 
// Module Name: lowpass_filter
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


module lowpass_filter(
 clk,
 sys_clk,
 switches,
 reset_n,
 filter_out
 );

input   clk; //10khz
input sys_clk;//100mhz
input [7:0]switches;//²¦Âë¿ª¹Ø
input   reset_n; 
//input   [7:0] filter_in; //double
output  [7:0] filter_out; //double
wire [7:0]data_sin;

  parameter coeff1 = 0.0000000000000000E+00; //double
  parameter coeff2 = 2.1216880999512355E-02; //double
  parameter coeff3 = 1.4522744031161058E-01; //double
  parameter coeff4 = 3.3355567868887714E-01; //double
  parameter coeff5 = 3.3355567868887714E-01; //double
  parameter coeff6 = 1.4522744031161058E-01; //double
  parameter coeff7 = 2.1216880999512355E-02; //double
  parameter coeff8 = 0.0000000000000000E+00; //double

// Signal
reg [7:0]delay_pipeline [0:7] ; // double
/*real product7; // double
real product6; // double
real product5; // double
real product4; // double
real product3; // double
real product2; // double
real sum1; // double
real sum2; // double
real sum3; // double
real sum4; // double
real sum5; // double
real output_typeconvert; // double
real output_register; // double*/
reg [7:0]product7; // double
reg [7:0]product6; // double
reg [7:0]product5; // double
reg [7:0]product4; // double
reg [7:0]product3; // double
reg [7:0]product2; // double
reg [7:0]sum1; // double
reg [7:0]sum2; // double
reg [7:0]sum3; // double
reg [7:0]sum4; // double
reg [7:0]sum5; // double
reg [7:0]output_typeconvert; // double
reg [7:0]output_register;
// Block Statements
always @( posedge clk or negedge reset_n)
begin: Delay_Pipeline_process
if (!reset_n) begin
delay_pipeline[0] <= 8'b0;
delay_pipeline[1] <= 8'b0;
delay_pipeline[2] <= 8'b0;
delay_pipeline[3] <= 8'b0;
delay_pipeline[4] <= 8'b0;
delay_pipeline[5] <= 8'b0;
delay_pipeline[6] <= 8'b0;
delay_pipeline[7] <= 8'b0;
end
else begin
//delay_pipeline[0] <= $bitstoreal(filter_in);
delay_pipeline[0] <= data_sin;//$bitstoreal(data_sin);
delay_pipeline[1] <= delay_pipeline[0];
delay_pipeline[2] <= delay_pipeline[1];
delay_pipeline[3] <= delay_pipeline[2];
delay_pipeline[4] <= delay_pipeline[3];
delay_pipeline[5] <= delay_pipeline[4];
delay_pipeline[6] <= delay_pipeline[5];
delay_pipeline[7] <= delay_pipeline[6];
end
end // Delay_Pipeline_process


always @* product7 <= delay_pipeline[6]/41; // coeff7;

always @* product6 <= delay_pipeline[5]/14; // coeff6;

always @* product5 <= delay_pipeline[4]/7;// * coeff5;

always @* product4 <= delay_pipeline[3]/7;// * coeff4;

always @* product3 <= delay_pipeline[2]/14;// * coeff3;

always @* product2 <= delay_pipeline[1]/41; // coeff2;

always @* sum1 <= product2 + product3;

always @* sum2 <= sum1 + product4;

always @* sum3 <= sum2 + product5;

always @* sum4 <= sum3 + product6;

always @* sum5 <= sum4 + product7;

always @* output_typeconvert <= sum5;


always @ (posedge sys_clk or negedge reset_n)
begin: Output_Register_process
if (!reset_n) begin
output_register <= 8'b0;
end
else begin
output_register <= output_typeconvert;
end
end // Output_Register_process

// Assignment Statements
//assign filter_out = $realtobits(output_register);
assign filter_out = output_register;

accumulator u0(
.data_sin(data_sin),
.clk(clk),
.sys_clk(sys_clk),
.rst(reset_n),
.switches(switches)

);

endmodule 