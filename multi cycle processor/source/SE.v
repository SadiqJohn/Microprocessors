`timescale 1ns / 1ps
// Sign Extender
module SE(
    input [15:0] Imm, // Immediate
    output [31:0] SImm // Signed Immediate
    );
    
    assign SImm[15:0] = Imm[15:0]; // First 16 bits of extended Immediate are equal to unextended Immediate
    assign SImm[32:16] = Imm[15]?16'b1111_1111_1111_1111:16'b0; // Remaining 16 bits of extended Immediate are equal to the MSB of unextended Immediate 
endmodule
