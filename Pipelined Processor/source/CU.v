`timescale 1ns / 1ps

module CU(
    input [5:0] Op,
    input [5:0] Funct,
    output reg MtoRFSel,
    output reg DMWE,
    output reg Branch,
    output reg [2:0] ALUSel,
    output reg ALUInSel,
    output reg RFDSel,
    output reg RFWE,
    output reg Jump
    );
    
    initial Jump <= 0;
    
    always @(Op or Funct)
        if(Op == 6'b100011) begin // lw Instruction
            RFWE <= 1'b1;
            RFDSel <= 1'b0;
            ALUInSel <= 1'b1;
            Branch <= 1'b0;
            DMWE <= 1'b0; // No value should be written to DM during lw
            MtoRFSel <= 1'b1;
            ALUSel <= 3'b010;
            Jump <= 1'b0;
        end
        else if(Op == 6'b101011) begin // sw Instruction
            RFWE <= 1'b0; // No value should be written to RF during sw
            RFDSel <= 1'bX;
            ALUInSel <= 1'b1;
            Branch <= 1'b0;
            DMWE <= 1'b1;
            MtoRFSel <= 1'bX;
            ALUSel <= 3'b010;
            Jump <= 1'b0;
        end
        else if(Op == 6'b000000) begin // R-Type Instruction
            RFWE <= 1'b1;
            RFDSel <= 1'b1;
            ALUInSel <= 1'b0;
            Branch <= 1'b0;
            DMWE <= 1'b0;
            MtoRFSel <= 1'b0;
            Jump <= 1'b0;
            if (Funct == 6'b100000) begin // Add operation
                ALUSel <= 3'b010;
            end
            else if (Funct == 6'b100010) begin // Subtract operation
                ALUSel <= 3'b110;
            end
            else if (Funct == 6'b000000) begin // Shift Left Logical operation
                ALUSel <= 3'b011;
            end
            else if (Funct == 6'b000100) begin // Shift Left Logical Variable operation
                ALUSel <= 3'b100;
            end
            else if (Funct == 6'b000111) begin // Shift Right Arithmetic Variable operation
                ALUSel <= 3'b101;
            end    
        end
        else if(Op == 6'b000100) begin // BEQ Instruction
            RFWE <= 1'b0; // No value should be written to RF during BEQ
            RFDSel <= 1'bX;
            ALUInSel <= 1'b0;
            Branch <= 1'b1;
            DMWE <= 1'b0; // No value should be written to DM during BEQ
            MtoRFSel <= 1'bX;
            ALUSel <= 3'b110;
            Jump <= 1'b0;
        end
        else if(Op == 6'b001000) begin // ADDI Instruction
            RFWE <= 1'b1;
            RFDSel <= 1'b0;
            ALUInSel <= 1'b1;
            Branch <= 1'b0;
            DMWE <= 1'b0;
            MtoRFSel <= 1'b0;
            ALUSel <= 3'b010;
            Jump <= 1'b0;
        end
        else if(Op == 6'b000010) begin // Jump Instruction
            RFWE <= 1'b0;
            RFDSel <= 1'bX;
            ALUInSel <= 1'bX;
            Branch <= 1'bX;
            DMWE <= 1'b0;
            MtoRFSel <= 1'bX;
            ALUSel <= 3'bXXX;
            Jump <= 1'b1;
        end
endmodule
