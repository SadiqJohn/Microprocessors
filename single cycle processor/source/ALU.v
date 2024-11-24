`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:42:22 PM
// Design Name: 
// Module Name: ALU
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


module ALU(inA, inB, alu_out, zero, control);
input [31:0] inA, inB;
output [31:0] alu_out;
output zero;
reg zero;
reg [31:0] alu_out;
input [3:0] control;
always @ (control or inA or inB)
begin
case (control)
4'b0000:begin zero<=0; alu_out<=inA&inB; end
4'b0001:begin zero<=0; alu_out<=inA|inB; end
4'b0010:begin zero<=0; alu_out<=inA+inB; end
4'b0110:begin if(inA==inB) zero<=1; else zero<=0; alu_out<=inA-inB;
end
4'b0111:begin zero<=0; if(inA-inB>=32'h8000_0000) alu_out<=32'b1;
else alu_out<=32'b0; end// how to implement signed number
default: begin zero<=0; alu_out<=inA; end
endcase
end
endmodule