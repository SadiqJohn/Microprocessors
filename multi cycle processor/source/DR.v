`timescale 1ns / 1ps
// Data Register
module DR(
    input clk,
    input [31:0] DRIn,
    output reg [31:0] DROut
    );
    
    always@(posedge clk)begin
        DROut <= DRIn;
    end
endmodule
