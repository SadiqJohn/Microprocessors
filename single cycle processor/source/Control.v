`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:37:27 PM
// Design Name: 
// Module Name: Control
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


module Control(OpCode, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp,
MemWrite, ALUSrc, RegWrite);
input [5:0] OpCode;
output RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc,
RegWrite;
output [1:0] ALUOp;
assign
RegDst=(~OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(~OpCode[1])&(~OpCode
[0]);//000000
assign
Jump=(~OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(OpCode[1])&(~OpCode[0]
);//000010
assign
Branch=(~OpCode[5])&(~OpCode[4])&(~OpCode[3])&(OpCode[2])&(~OpCode[1])&(~OpCode[
0]);//000100
assign
MemRead=(OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(OpCode[1])&(OpCode[0
]);//100011
assign
MemtoReg=(OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(OpCode[1])&(OpCode[
0]);//100011
assign
MemWrite=(OpCode[5])&(~OpCode[4])&(OpCode[3])&(~OpCode[2])&(OpCode[1])&(OpCode[0
]);//101011
assign
ALUSrc=((~OpCode[5])&(~OpCode[4])&(OpCode[3])&(~OpCode[2])&(~OpCode[1])&(~OpCode
[0])) |
((~OpCode[5])&(~OpCode[4])&(OpCode[3])&(OpCode[2])&(~OpCode[1])&(~OpCode[0])) |
((OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(OpCode[1])&(OpCode[0])) |
(((OpCode[5])&(~OpCode[4])&(OpCode[3])&(~OpCode[2])&(OpCode[1])&(OpCode[0]))); //001000,001100,100011,101011
assign
RegWrite=(~OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(~OpCode[1])&(~OpCode[0]) |
((~OpCode[5])&(~OpCode[4])&(OpCode[3])&(~OpCode[2])&(~OpCode[1])&(~OpCode[0])) |
((~OpCode[5])&(~OpCode[4])&(OpCode[3])&(OpCode[2])&(~OpCode[1])&(~OpCode[0])) |
((OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(OpCode[1])&(OpCode[0]));//000000,001000,001100,100011
assign
ALUOp[1]=((~OpCode[5])&(~OpCode[4])&(~OpCode[3])&(~OpCode[2])&(~OpCode[1])&(~OpCode[0]))|
((~OpCode[5])&(~OpCode[4])&(OpCode[3])&(OpCode[2])&(~OpCode[1])&(~OpCode[0]));//000000, 001100(andi)
assign ALUOp[0]=
((~OpCode[5])&(~OpCode[4])&(~OpCode[3])&(OpCode[2])&(~OpCode[1])&(~OpCode[0]))|
((~OpCode[5])&(~OpCode[4])&(OpCode[3])&(OpCode[2])&(~OpCode[1])&(~OpCode[0]));//000100,001100(andi)
endmodule