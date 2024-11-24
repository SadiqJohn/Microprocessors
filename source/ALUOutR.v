`timescale 1ns / 1ps
// Arithmetic Logic Unit Register
module ALUOutR(
    input clk,
    input [31:0] ALUOutRIn,
    output reg [31:0] ALUOutROut
    );
    
    always@(posedge clk)begin
        ALUOutROut <= ALUOutRIn;
    end
endmodule
