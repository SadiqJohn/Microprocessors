`timescale 1ns / 1ps

module PCAdder(
    input [31:0] PCOld,
    output [31:0] PCNew
    );
    
    assign PCNew = PCOld + 1;
endmodule
