`timescale 1ns / 1ps

module DReg(
    input clk,
    input EN,
    input CLR,
    input [31:0] IMRD,
    input [31:0] PCp1F,
    output reg [31:0] InstrD,
    output reg [31:0] PCp1D
    );
    
    always @(posedge clk) begin
        if (CLR) begin
            InstrD <= 32'b00000000000000000000000000100000;
        end
        else if (EN == 1) begin
            InstrD <= InstrD;
            PCp1D <= PCp1D;
        end     
        else begin
            InstrD <= IMRD;
            PCp1D <= PCp1F;
        end
    end
endmodule
