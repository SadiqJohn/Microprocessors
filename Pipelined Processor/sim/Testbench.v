`timescale 1ns / 1ps

module Testbench;
    parameter WL = 32;
    reg clk;
    
    Top #(.WL(WL)) UUT (.clk(clk));
    
    initial clk <= 0; // initialize clock signal to 0 (low)
    always #5 clk <= ~clk; // Every 5ns alternate clock bit (clk cycle 10ns long)
    
    initial begin
        #2000; // run for 300ns
        $finish;
    end
endmodule
