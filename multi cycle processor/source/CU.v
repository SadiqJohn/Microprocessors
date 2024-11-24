`timescale 1ns / 1ps
// Control Unit
module CU(
    input clk,
    input [5:0] Op,
    output reg MtoRFSel,
    output reg RFDSel,
    output reg IDSel,
    output reg [1:0] PCSel,
    output reg ALUIn1Sel,
    output reg [1:0] ALUIn2Sel,
    output reg IRWE,
    output reg MRE,
    output reg MWE,
    output reg PCWE,
    output reg Branch,
    output reg RFWE,
    output reg [1:0] ALUOp
    );
    
    reg [3:0] state = 4'b0000;
    reg [3:0] nextstate;

    // States
    parameter FETCH = 4'b0000;
	parameter DECODE = 4'b0001;
	parameter MEMADR = 4'b0010;
	parameter MEMREAD = 4'b0011;
	parameter MEMWRITEBACK = 4'b0100;
	parameter DMWE = 4'b0101;
	parameter EXECUTE = 4'b0110;
	parameter ALUWRITEBACK = 4'b0111;
	parameter BRANCH = 4'b1000;
	parameter JUMP = 4'b1001;
	parameter S10 = 4'b1010;
	parameter S11 = 4'b1011;
	
    always@ (posedge clk) begin
//        if (reset) begin // Reset to S0 (Fetch)
//            state <= FETCH;
//        end
//        else begin
            state <= nextstate;
//        end
    end    
    
    always@(state or Op) begin
        case (state)
            FETCH: nextstate = DECODE;
            DECODE: case(Op)
                        6'b100011: nextstate = MEMADR; // LW
                        6'b101011: nextstate = MEMADR; // SW
                        6'b000000: nextstate = EXECUTE; // R-type
                        6'b000100: nextstate = BRANCH; // BEQ
                        6'b000010: nextstate = JUMP; // J-type
                        6'b001000: nextstate = S10;// ADDI
                        //default: nextstate = FETCH;
                    endcase    
            MEMADR: case(Op)
                        6'b100011: nextstate = MEMREAD; // LW
                        6'b101011: nextstate = DMWE; // SW
                        //default: nextstate = FETCH;
                    endcase    
            MEMREAD: nextstate = MEMWRITEBACK;
            MEMWRITEBACK: nextstate = FETCH;
            DMWE: nextstate = FETCH;
            EXECUTE: nextstate = ALUWRITEBACK;
            ALUWRITEBACK: nextstate = FETCH;
            BRANCH: nextstate = FETCH;
            JUMP: nextstate = FETCH;
            S10: nextstate = S11;
            S11: nextstate = FETCH;
            default: nextstate = FETCH;
        endcase
    end
    always@(state or Op) begin
        case(state)
        FETCH: begin
               IDSel = 1'b0;
               ALUIn1Sel = 1'b0;
               ALUIn2Sel = 2'b01;
               ALUOp = 2'b00;
               PCSel = 2'b00;
               IRWE = 1'b1;
               PCWE = 1'b1;
               Branch = 1'b0;
               RFWE = 1'b0;
               MWE = 1'b0;
               end
        DECODE: begin
                PCWE = 1'b0;
                IRWE = 1'b0;
                //
                ALUIn1Sel = 1'b0;
                ALUIn2Sel = 2'b10;
                ALUOp = 2'b00;
                end
        MEMADR: begin
                ALUIn1Sel = 1'b1;
                ALUIn2Sel = 2'b10;
                ALUOp = 2'b00;
                end
        MEMREAD: begin
                 IDSel = 1'b1;
                 end
        MEMWRITEBACK: begin
                      RFDSel = 1'b0;
                      MtoRFSel = 1'b1;
                      RFWE = 1'b1;
                      end
        DMWE: begin
              IDSel = 1'b1;
              MWE = 1'b1;
              end
        EXECUTE: begin
                 ALUIn1Sel = 1'b1;
                 ALUIn2Sel = 2'b00;
                 ALUOp = 2'b10;
                 end
        ALUWRITEBACK: begin
                      RFDSel = 1'b1;
                      MtoRFSel = 1'b0;
                      RFWE = 1'b1;
                      end
        BRANCH: begin
                ALUIn1Sel = 1'b1;
                ALUIn2Sel = 2'b00;
                ALUOp = 2'b01;
                PCSel = 2'b01;
                Branch = 1'b1;
                end
        JUMP: begin
              PCSel = 2'b10;
              PCWE = 1'b1;
              end
        S10: begin
             ALUIn1Sel = 1'b1;
             ALUIn2Sel = 2'b10;
             ALUOp = 2'b00;
             end
        S11: begin
             RFDSel = 1'b0;
             MtoRFSel = 1'b0;
             RFWE = 1'b1;
             end
        endcase
    end
endmodule
