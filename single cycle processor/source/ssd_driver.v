`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:47:54 PM
// Design Name: 
// Module Name: ssd_driver
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


module ssd_driver(in_BCD, out_SSD);
input [3:0] in_BCD; // input in Binary-Coded Decimal
output [6:0] out_SSD; // output to Seven-Segment Display
reg [6:0] out_SSD;
always @(in_BCD) begin
case (in_BCD)
0:out_SSD=7'b0000001;
1:out_SSD=7'b1001111;
2:out_SSD=7'b0010010;
3:out_SSD=7'b0000110;
4:out_SSD=7'b1001100;
5:out_SSD=7'b0100100;
6:out_SSD=7'b0100000;
7:out_SSD=7'b0001111;
8:out_SSD=7'b0000000;
9:out_SSD=7'b0000100;
10:out_SSD=7'b0001000;
11:out_SSD=7'b1100000;
12:out_SSD=7'b0110001;
13:out_SSD=7'b1000010;
14:out_SSD=7'b0110000;
15:out_SSD=7'b0111000;
default out_SSD = 7'b1111111; // no ssd
endcase
end
endmodule