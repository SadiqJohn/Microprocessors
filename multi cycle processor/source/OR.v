`timescale 1ns / 1ps

module OR(
    input PCWE,
    input ANDOut,
    output OROut
    );
    assign OROut = PCWE | ANDOut;
endmodule
