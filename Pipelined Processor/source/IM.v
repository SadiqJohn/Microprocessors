`timescale 1ns / 1ps

module IM(
    input [31:0] IMA, // Instruction Memory Address
    output reg [31:0] IMRD // Instruction Memory Read Data
    );
    
    reg [31:0] Instruction [31:0]; // 32 32-bit Instructions
    
    initial begin // Set the Instructions to be tested
        $readmemb("InstructionsE.mem", Instruction);
    end
    
    always @ (IMA) begin
        IMRD <= Instruction[IMA]; // Read the 32-bit instruction onto the read data output (IMRD)
    end
endmodule
