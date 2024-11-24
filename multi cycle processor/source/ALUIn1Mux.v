`timescale 1ns / 1ps

module ALUIn1Mux(
    input ALUIn1Sel,
    input [31:0] ALUIn1In0,
    input [31:0] ALUIn1In1,
    output [31:0] ALUIn1MuxOut
    );
    assign ALUIn1MuxOut = ALUIn1Sel ? ALUIn1In1 : ALUIn1In0;
endmodule
