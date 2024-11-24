`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2021 05:40:45 AM
// Design Name: 
// Module Name: Mux
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
module Mux(
    input Sel,
    input [31:0] In_0,
    input [31:0] In_1,
    output [31:0] Mux_Out
    );
    assign Mux_Out = Sel ? In_1 : In_0;
endmodule

