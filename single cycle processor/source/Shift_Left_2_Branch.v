`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:40:12 PM
// Design Name: 
// Module Name: Shift_Left_2_Branch
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


module Shift_Left_2_Branch(shift_in, shift_out);
input [31:0] shift_in;
output [31:0] shift_out;
assign shift_out[31:0]={shift_in[29:0],2'b00};
endmodule
