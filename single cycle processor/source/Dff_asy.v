`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:43:45 PM
// Design Name: 
// Module Name: Dff_asy
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


module Dff_asy(q, d, clk, rst);
input d, clk, rst;
output reg q;
always @ (posedge clk or posedge rst)
if (rst == 1) q <= 0;
else q <= d;
endmodule