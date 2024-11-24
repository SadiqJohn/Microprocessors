`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:28:43 PM
// Design Name: 
// Module Name: Program_Counter
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

// rising-edge synchronous program counter
// output range: decimal 0 to 63 (== I-MEM height)
// data I/O width: 64 = 2^6. Actually, 32 = 2^5; 5+2 offset = 7 bits
// async reset: set program counter to 0 asynchronously

module Program_Counter(clk, reset, PC_in, PC_out);
input clk, reset;
input [7:0] PC_in;
output [7:0] PC_out;
reg [7:0] PC_out;
always @ (posedge clk or posedge reset)
begin
if(reset==1'b1)
PC_out<=0;
else
PC_out<=PC_in;
end
endmodule
