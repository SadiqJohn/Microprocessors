`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:34:48 PM
// Design Name: 
// Module Name: Register_File
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


module Register_File(read_addr_1, read_addr_2, write_addr, read_data_1,
read_data_2, write_data, RegWrite, clk, reset);
input [4:0] read_addr_1, read_addr_2, write_addr;
input [31:0] write_data;
input clk, reset, RegWrite;
output [31:0] read_data_1, read_data_2;
reg [31:0] Regfile [31:0];
integer k;
assign read_data_1 = Regfile[read_addr_1];
assign read_data_2 = Regfile[read_addr_2];
always @(posedge clk or posedge reset) // Ou combines the block of reset into the block of posedge clk
    begin
        if (reset==1'b1)
        begin
        for (k=0; k<32; k=k+1)
        begin
        Regfile[k] = 32'b0;
        end
        end
        else if (RegWrite == 1'b1) Regfile[write_addr] = write_data;
    end
endmodule
