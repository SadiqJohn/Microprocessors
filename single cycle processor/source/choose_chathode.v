`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:48:55 PM
// Design Name: 
// Module Name: choose_chathode
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


module choose_chathode(tho, hun, ten, one, AN, CA);
input [6:0]tho;
input [6:0]hun;
input [6:0]ten;
input [6:0]one;
input [3:0]AN;
output [6:0]CA;
assign CA = (AN==4'b1110) ? one : 7'bzzzzzzz,
CA = (AN==4'b1101) ? ten : 7'bzzzzzzz,
CA = (AN==4'b1011) ? hun : 7'bzzzzzzz,
CA = (AN==4'b0111) ? tho : 7'bzzzzzzz;
endmodule