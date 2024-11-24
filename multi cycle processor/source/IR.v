`timescale 1ns / 1ps
// Non-Architectural Instruction Register
module IR(
    input clk,
    input IRWE,
    input [31:0] IRIn,
    output reg [31:0] IROut
    );
    
    always@(posedge clk) begin
        if (IRWE) begin
            IROut <= IRIn;
        end
    end
endmodule
