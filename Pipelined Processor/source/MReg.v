`timescale 1ns / 1ps

module MReg(
    input clk,
    input RFWEE,
    input MtoRFSelE,
    input DMWEE,
    input [31:0] ALUOut,
    input [31:0] DMdinE,
    input [4:0] RFAE,
    output reg RFWEM,
    output reg MtoRFSelM,
    output reg DMWEM,
    output reg [31:0] ALUOutM,
    output reg [31:0] DMdinM,
    output reg [4:0] RFAM
    );
    
    always @(posedge clk) begin
        RFWEM <= RFWEE;
        MtoRFSelM <= MtoRFSelE;
        DMWEM <= DMWEE;
        ALUOutM <= ALUOut;
        DMdinM <= DMdinE;
        RFAM <= RFAE;
    end
endmodule
