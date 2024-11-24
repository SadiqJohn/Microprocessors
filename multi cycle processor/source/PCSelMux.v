`timescale 1ns / 1ps

module PCSelMux(
    input PCSel,
    input [31:0] In00,
    input [31:0] In01,
    input [31:0] In10,
    output reg [31:0] MuxOut
    );
    
    always@(PCSel or In00 or In01 or In10)begin
        if(PCSel == 2'b00)begin
            MuxOut <= In00;
        end
    
        else if(PCSel == 2'b01)begin
            MuxOut <= In01;
        end

        else if(PCSel == 2'b10)begin
            MuxOut <= In10;
        end
    end
    
endmodule
