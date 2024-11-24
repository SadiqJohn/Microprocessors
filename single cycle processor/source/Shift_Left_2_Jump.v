`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:41:01 PM
// Design Name: 
// Module Name: Shift_Left_2_Jump
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


module Shift_Left_2_Jump(shift_in, shift_out);
input [25:0] shift_in;
output [27:0] shift_out;
assign shift_out[27:0]={shift_in[25:0],2'b00};
endmodule