`timescale 1ns / 1ps

module ALUDecoder(
    input [1:0] ALUOp,
    input [5:0] Funct,
    output reg [2:0] ALUSel
    );
    
    always@(ALUOp or Funct) begin
        if (ALUOp == 2'b00) begin // LW, SW, ADD
            ALUSel <= 3'b010;
        end
        else if (ALUOp == 2'b01) begin // SUB, BEQ
            ALUSel <= 3'b110;
        end
        else if (ALUOp == 2'b10) begin // R-type 
            if (Funct == 6'b100000) begin // Add
                ALUSel <= 3'b010;
            end
            else if (Funct == 6'b100010) begin // Sub
                ALUSel <= 3'b110;
            end
            else if (Funct == 6'b000000) begin // SLL
                ALUSel <= 3'b011;
            end
            else if (Funct == 6'b000100) begin // SLLV
                ALUSel <= 3'b100;
            end
            else if (Funct == 6'b000111) begin // SRAV
                ALUSel <= 3'b101;
            end
        end
    end
endmodule
