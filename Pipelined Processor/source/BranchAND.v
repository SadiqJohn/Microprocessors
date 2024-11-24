`timescale 1ns / 1ps

module BranchAND(
    input Branch,
    input Zero,
    output reg PCSelOut
    );    
//    assign PCSelOut = (Branch&&Zero) ? 1 : 0;
    
    initial PCSelOut <= 0;
    always@(*)begin
        if ((Branch&&Zero)==1)  begin
            PCSelOut <= 1;
        end
        else begin
            PCSelOut <= 0;
        end
    end
endmodule
