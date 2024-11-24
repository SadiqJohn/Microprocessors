`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:43:08 PM
// Design Name: 
// Module Name: ALU_add_only
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


module ALU_add_only(inA, inB, add_out);
input [31:0] inA, inB;
output [31:0] add_out;
assign add_out=inA+inB;
endmodule