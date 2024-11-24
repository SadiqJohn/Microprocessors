`timescale 1ns / 1ps
// Arithmetic Logic Unit
module ALU(
    input [2:0] ALUSel, // 3-bit signal that specifies the ALU operation
    input [31:0] ALUIn1, // Register File Read Data 1 from Register File
    input [31:0] ALUIn2, // Signed Immediate from Sign Extender
    input [4:0] shamt, // Shift Amount
    output reg Zero, // Flag that indicates if ALUOut == 0
    output reg [31:0] ALUOut 
    );
    
    always @(ALUSel or ALUIn1 or ALUIn2) begin
        if(ALUSel == 3'b010) begin // lw/sw/add Instruction
            ALUOut <= ALUIn1 + ALUIn2; // Add base address with signed immediate
            Zero <= 0; // ALUOut =/= 0
        end
        else if (ALUSel == 3'b110) begin // sub Instruction
            if (ALUIn1 == ALUIn2) begin // If ALUIn1 == ALUIn2 set Zero flag to 1
                Zero <= 1;
            end
            else begin
                Zero <= 0; // ALUOut =/= 0
            end
           ALUOut <= ALUIn1 - ALUIn2;  // Subtract
        end
        else if (ALUSel == 3'b011) begin // Logical Shift Left instruction
            ALUOut <= ALUIn2 << shamt;
            Zero <= 0;
        end
        else if (ALUSel == 3'b100) begin // Logical Shift Left Variable instruction
            ALUOut <= ALUIn2 << ALUIn1;
            Zero <= 0;
        end
        else if (ALUSel == 3'b101) begin // Shift Right Arithmetic Variable instruction
            ALUOut <= ALUIn2 >>> ALUIn1;
            Zero <= 0;
        end
    end
endmodule
