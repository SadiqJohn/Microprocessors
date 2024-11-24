`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:41:39 PM
// Design Name: 
// Module Name: Mux_N_bit
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


module Mux_N_bit(in0, in1, mux_out, control);
parameter N = 32;
input [N-1:0] in0, in1;
output [N-1:0] mux_out;
input control;
assign mux_out=control?in1:in0;
endmodule