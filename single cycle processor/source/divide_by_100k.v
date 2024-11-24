`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 11:02:37 PM
// Design Name: 
// Module Name: divide_by_100k
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


module divide_by_100k(clock, reset, clock_out); // modified to divide-by-4 for simulation
parameter N = 17;
input clock, reset;
wire load, asyclock_out;
wire [N-1:0] Dat;
output clock_out;
reg [N-1:0] Q;
assign Dat = 0;
assign load = Q[1] & Q[0]; // modified to load = 3 (DEC) for simulation
always @ (posedge reset or posedge clock)
begin
if (reset == 1'b1) Q <= 0;
else if (load == 1'b1) Q <= Dat;
else Q <= Q + 1;
end
assign asyclock_out = load;
Dff_asy Unit_Dff
(.q(clock_out), .d(asyclock_out), .clk(clock), .rst(reset));
endmodule