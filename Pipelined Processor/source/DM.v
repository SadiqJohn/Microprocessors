`timescale 1ns / 1ps

module DM(
    input clk,
    input DMWE, // Data Memory Write Enable
    input [31:0] DMA, // Data Memory Address
    input [31:0] DMWD, // Data Memory Write Data
    output [31:0] DMRD // Data Memory Read Data
    );
        
    reg [31:0] Memory [400:0]; // 32-bit memory
    
    initial begin
        Memory[0] <= 17; // h'00000011
        Memory[1] <= 31; // h'00000000
        Memory[2] <= -5; // h'00000000
        Memory[3] <= -2; // h'00000000
        Memory[4] <= 250; // h'00000000      
    end
    
    assign DMRD = (!DMWE) ? Memory[DMA] : 32'bX; // If data memory write not enabled, write memory to register, else don't care
    
    always @(posedge clk) begin
        if (DMWE) begin // If write is enabled
            Memory[DMA] <= DMWD; // Write data DMWD onto address DMA 
        end
    end
endmodule
