`timescale 1ns / 1ps

module HU(
    input BranchD,
    input [4:0] rsD,
    input [4:0] rtD,
    input [4:0] rsE,
    input [4:0] rtE,
    input [4:0] RFAE,
    input MtoRFSelE,
    input RFWEE,
    input [4:0] RFAM,
    input RFWEM,
    input [4:0] RFAW,
    input RFWEW,
    output reg Stall,
    output reg ForwardAD,
    output reg ForwardBD,
    output reg Flush,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE
    );
    
    reg LWStall;
    reg BRStall;
//    initial Stall = 1'b0;
//    initial Flush = 1'b0;
    always@(BranchD or rsD or rtD or rsE or rtE or RFAE or MtoRFSelE or RFWEE or RFAM or RFWEM or RFAW or RFWEW)begin
//      always@(*)begin
//        ForwardAE <= 2'b00;
//        ForwardBE <= 2'b00;
    
        // ForwardAE
        if ((rsE!=0) && (RFWEM) && (rsE==RFAM)) begin
            ForwardAE <= 2'b10;
        end
        else if((rsE!=0) && (RFWEW) && (rsE==RFAW)) begin
            ForwardAE <= 2'b01;
        end
        else begin
            ForwardAE <= 2'b00;
        end
        
        // ForwardBE
        if ((rtE!=0) && (RFWEM) && (rtE==RFAM)) begin
            ForwardBE <= 2'b10;
        end
        else if((rtE!=0) && (RFWEW) && (rtE==RFAW)) begin
            ForwardBE <= 2'b01;
        end
        else begin
            ForwardBE <= 2'b00;
        end 
        
        // Stall
        LWStall <= (MtoRFSelE) && ((rtE == rsD) || (rtE == rtD));
        
        ForwardAD <= (rsD != 0) && (rsD == RFAM) && RFWEM;
        ForwardBD <= (rtD != 0) && (rtD == RFAM) && RFWEM;
        
        BRStall <= ((rsD == RFAE) || (rtD == RFAE)) && BranchD && RFWEE || 
                   ((rsD == RFAM) || (rtD == RFAM)) && BranchD && MtoRFSelE;
        
        Stall <= LWStall || BRStall;
        Flush <= Stall; 
    end    
endmodule 
