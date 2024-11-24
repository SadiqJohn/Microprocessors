`timescale 1ns / 1ps
// Non-architectural Register
module ABR(
    input clk,
    input [31:0] AIn,
    input [31:0] BIn,
    output reg [31:0] AOut,
    output reg [31:0] BOut
    );
    
    always@(posedge clk)begin
        AOut <= AIn;
        BOut <= BIn;
    end
endmodule
