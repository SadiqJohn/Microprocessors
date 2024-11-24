`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:47:03 PM
// Design Name: 
// Module Name: Ring_4_counter
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


module Ring_4_counter(clock, reset, Q);
input clock, reset;
output reg [3:0]Q;
always @(posedge clock or posedge reset)
begin
if (reset == 1) Q <= 4'b1110;
else
begin
Q[3] <= Q[0];
Q[2] <= Q[3];
Q[1] <= Q[2];
Q[0] <= Q[1];
end
end
endmodule