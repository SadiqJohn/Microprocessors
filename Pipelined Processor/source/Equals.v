`timescale 1ns / 1ps

module Equals(
    input [31:0] First,
    input [31:0] Second,
    output reg EqualD
    );
    
    always@(*) begin
        if (First == Second) begin
            EqualD <= 1'b1;
        end
        else begin
            EqualD <= 1'b0;
        end
    end
endmodule
