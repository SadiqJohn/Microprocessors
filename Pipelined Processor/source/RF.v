`timescale 1ns / 1ps

module RF(
    input clk,
    input RFWE, // Register File Write Enable
    input [4:0] RFRA1, // Register File Read Address 1
    input [4:0] RFRA2, // Register File Read Address 2
    input [4:0] RFWA, // Register File Write Address
    input [31:0] RFWD, // Register File Write Data
    output [31:0] RFRD1, // Register Fire Read Data 1
    output [31:0] RFRD2 // Register Fire Read Data 2
    );
    
    reg [31:0] Registers [31:0]; // 32 32-bit registers (8-25 are user variables)
    
    //Initialize Registers
    initial begin 
        //constant value 0
        Registers[0] <= 32'h00000000;
    end
    
//     Read register values onto read data outputs
    assign RFRD1 = Registers[RFRA1];
    assign RFRD2 = Registers[RFRA2];
    
    always@(posedge clk) begin
        if (RFWE) begin // If write is enabled
            Registers[RFWA] = RFWD; // Write data RFWD onto address RFWA
        end
//        else begin
//            RFRD1 = Registers[RFRA1];
//            RFRD2 = Registers[RFRA2];
//        end
    end
endmodule
