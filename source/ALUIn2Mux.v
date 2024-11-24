`timescale 1ns / 1ps

module ALUIn2Mux(
    input [1:0] ALUIn2Sel, // 2-bit Select
    input [31:0] In00, 
    input [31:0] In01,
    input [31:0] In10,
    output reg [31:0] ALUIn2MuxOut
    );
    
    always@(ALUIn2Sel or In00 or In10)begin
        if(ALUIn2Sel == 2'b00)begin
            ALUIn2MuxOut <= In00;
        end
    
        else if(ALUIn2Sel == 2'b01)begin
            ALUIn2MuxOut <= In01;
        end

        else if(ALUIn2Sel == 2'b10)begin
            ALUIn2MuxOut <= In10;
        end
    end
endmodule
