`timescale 1ns / 1ps
// Program Counter
module PC(
    input clk,
    input PCWE, // Program Counter Write Enable
    input [31:0] PCIn,
    output reg [31:0] PCOut
    );
    
    initial begin // Initial PC to 0 on startup
        PCOut = 500;
    end
    
    always@(posedge clk) begin
        if (PCWE) begin
            PCOut <= PCIn; // Assign next PC
        end
    end 
endmodule
