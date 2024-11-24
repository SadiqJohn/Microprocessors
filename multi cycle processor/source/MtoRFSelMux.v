`timescale 1ns / 1ps

module MtoRFSelMux(
    input Sel,
    input [31:0] In0,
    input [31:0] In1,
    output [31:0] MuxOut
    );
    assign MuxOut = Sel ? In1 : In0;
endmodule
