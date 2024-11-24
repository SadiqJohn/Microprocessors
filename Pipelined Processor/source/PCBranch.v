`timescale 1ns / 1ps

module PCBranch(
    input [31:0] SImm,
    input [31:0] PCp1,
    output reg [31:0] BranchOut
    );
    always @(SImm or PCp1) begin
        BranchOut <= SImm + PCp1;
    end
endmodule
