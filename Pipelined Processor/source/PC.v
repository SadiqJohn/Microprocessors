`timescale 1ns / 1ps

module PC(
    input clk,
    input EN,
    input [31:0] PCIn, // Program Counter (next instruction)
    output reg [31:0] PCOut // Program Counter (current instruction)
    );
    
    initial begin // Initial PC to 0 on startup
        PCOut <= 0;
    end
    
    always @(posedge clk) begin
        if (EN == 1) begin
            PCOut <= PCOut;
        end
        else begin
            PCOut <= PCIn;
        end
    end
endmodule
