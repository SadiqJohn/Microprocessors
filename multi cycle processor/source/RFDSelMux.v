`timescale 1ns / 1ps

module RFDSelMux(
    input Sel,
    input [4:0] In0,
    input [4:0] In1,
    output [4:0] MuxOut
    );
    assign MuxOut = Sel ? In1 : In0;
endmodule
