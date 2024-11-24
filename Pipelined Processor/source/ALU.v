`timescale 1ns / 1ps

module ALU(
    input [2:0] ALUSel, // 3-bit signal that specifies the ALU operation
    input [31:0] ALUIn1, // Register File Read Data 1 from Register File
    input [31:0] ALUIn2, // Signed Immediate from Sign Extender
    input [4:0] shamt,
    output reg [31:0] ALUOut 
    );
    
    always @(ALUSel or ALUIn1 or ALUIn2) begin
        if(ALUSel == 3'b010) begin // lw/sw/add Instruction
            ALUOut <= ALUIn1 + ALUIn2; // Add base address with signed immediate
        end
        else if (ALUSel == 3'b110) begin // sub Instruction
           ALUOut <= ALUIn1 - ALUIn2;  // Subtract
        end
        else if (ALUSel == 3'b011) begin // Logical Shift Left instruction
            ALUOut <= ALUIn2 << shamt;
        end
        else if (ALUSel == 3'b100) begin // Logical Shift Left Variable instruction
            ALUOut <= ALUIn2 << ALUIn1;
        end
        else if (ALUSel == 3'b101) begin // Shift Right Arithmetic Variable instruction
            ALUOut <= ALUIn2 >>> ALUIn1;
        end
    end
endmodule
