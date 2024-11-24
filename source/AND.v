`timescale 1ns / 1ps

module AND(
    input Branch,
    input Zero,
    output ANDOut
    );  
    assign  ANDOut = Branch & Zero;
endmodule
