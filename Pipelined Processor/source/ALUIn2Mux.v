`timescale 1ns / 1ps

module ALUIn2Mux(
    input Sel,
    input [31:0] In_0,
    input [31:0] In_1,
    output [31:0] Mux_Out
    );
    assign Mux_Out = Sel ? In_1 : In_0;
endmodule
