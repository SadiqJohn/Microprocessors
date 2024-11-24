`timescale 1ns / 1ps

module EReg(
    input clk,
    input CLR,
    input RFWED,
    input MtoRFSelD,
    input DMWED,
    input [2:0] ALUSelD,
    input ALUInSelD,
    input RFDSelD,
    input [31:0] RFRD1,
    input [31:0] RFRD2,
    input [4:0] rsD,
    input [4:0] rtD,
    input [4:0] rdD,
    input [31:0] SImmD,
    input [4:0] shamtD,
    output reg RFWEE,
    output reg MtoRFSelE,
    output reg DMWEE,
    output reg [2:0] ALUSelE,
    output reg ALUInSelE,
    output reg RFDSelE,
    output reg [31:0] ForwardAE00,
    output reg [31:0] ForwardBE00,
    output reg [4:0] rsE,
    output reg [4:0] rtE,
    output reg [4:0] rdE,
    output reg [31:0] SImmE,
    output reg [4:0] shamtE
    );
    
    always @(posedge clk) begin
        if (CLR) begin
            ForwardAE00 <= 32'b00000000000000000000000000000000;
            ForwardBE00 <= 32'b00000000000000000000000000000000;
            rsE <= 5'b00000;
            rtE <= 5'b00000;
            rdE <= 5'b00000;
            SImmE <= 32'b00000000000000000000000000000000;
            shamtE <= 5'b00000;
        end
        else begin
            RFWEE <= RFWED;
            MtoRFSelE <= MtoRFSelD;
            DMWEE <= DMWED;
            ALUSelE <= ALUSelD;
            ALUInSelE <= ALUInSelD;
            RFDSelE <= RFDSelD;
            ForwardAE00 <= RFRD1;
            ForwardBE00 <= RFRD2;
            rsE <= rsD;
            rtE <= rtD;
            rdE <= rdD;
            SImmE <= SImmD;
            shamtE <= shamtD;
        end
    end
endmodule
