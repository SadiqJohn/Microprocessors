`timescale 1ns / 1ps

module WReg(
    input clk,
    input RFWEM,
    input MtoRFSelM,
    input [31:0] ALUOutM,
    input [31:0] DMRD,
    input [4:0] RFAM,
    output reg RFWEW,
    output reg MtoRFSelW,
    output reg [31:0] ALUOutW,
    output reg [31:0] DMOutW,
    output reg [4:0] RFAW
    );
    
    always @(posedge clk) begin
        RFWEW <= RFWEM;
        MtoRFSelW <= MtoRFSelM;
        ALUOutW <= ALUOutM;
        DMOutW <= DMRD;
        RFAW <= RFAM;
    end
endmodule
