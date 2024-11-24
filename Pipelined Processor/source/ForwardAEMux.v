`timescale 1ns / 1ps

module ForwardAEMux(
    input [1:0] Sel,
    input [31:0] In_00,
    input [31:0] In_01,
    input [31:0] In_10,
    output reg [31:0] Mux_Out
    );
    
    always@(*) begin
        if (Sel == 2'b00) begin
            Mux_Out <= In_00;
        end
        else if (Sel == 2'b01) begin
            Mux_Out <= In_01;
        end
        else if (Sel == 2'b10) begin
            Mux_Out <= In_10;
        end
    end
endmodule
