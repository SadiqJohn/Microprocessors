`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:50:22 PM
// Design Name: 
// Module Name: Test_bench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Test_bench();
reg clkFast;
reg reset;
reg [4:0] SwitchSelector;
reg switchRun;
reg clkread;
integer count;
// Outputs
wire [31:0]reg_read_data_1;
// Instantiate the Unit Under Test (UUT)
single_cycle_processor uut (
.clkFast(clkFast),
.reset(reset),
.SwitchSelector(SwitchSelector),
.switchRun(switchRun),
.reg_read_data_1(reg_read_data_1));
initial begin
// Initialize Inputs
count = 0;
clkFast = 0;
reset = 1;
switchRun = 0;
SwitchSelector = 5'd0;
clkread = 0;
#4 reset=0;
#3000;
#50 $stop;
end
always begin #1 clkFast=~clkFast; end
always begin #200 clkread = ~clkread; end
always @(posedge clkread)
begin
$display ("Time: %d", count);
SwitchSelector = 5'd16;
#10 $display ("[$s0] = %h", reg_read_data_1);
SwitchSelector = 5'd17;
#10 $display ("[$s1] = %h", reg_read_data_1);
SwitchSelector = 5'd18;
#10 $display ("[$s2] = %h", reg_read_data_1);
SwitchSelector = 5'd19;
#10 $display ("[$s3] = %h", reg_read_data_1);
SwitchSelector = 5'd20;
#10 $display ("[$s4] = %h", reg_read_data_1);
SwitchSelector = 5'd21;
#10 $display ("[$s5] = %h", reg_read_data_1);
SwitchSelector = 5'd22;
#10 $display ("[$s6] = %h", reg_read_data_1);
SwitchSelector = 5'd23;
#10 $display ("[$s7] = %h", reg_read_data_1);
SwitchSelector = 5'd8;
#10 $display ("[$t0] = %h", reg_read_data_1);
SwitchSelector = 5'd9;
#10 $display ("[$t1] = %h", reg_read_data_1);
SwitchSelector = 5'd10;
#10 $display ("[$t2] = %h", reg_read_data_1);
SwitchSelector = 5'd11;
#10 $display ("[$t3] = %h", reg_read_data_1);
SwitchSelector = 5'd12;
#10 $display ("[$t4] = %h", reg_read_data_1);
SwitchSelector = 5'd13;
#10 $display ("[$t5] = %h", reg_read_data_1);
SwitchSelector = 5'd14;
#10 $display ("[$t6] = %h", reg_read_data_1);
SwitchSelector = 5'd15;
#10 $display ("[$t7] = %h", reg_read_data_1);
SwitchSelector = 5'd24;
#10 $display ("[$t8] = %h", reg_read_data_1);
SwitchSelector = 5'd25;
#10 $display ("[$t9] = %h", reg_read_data_1);
#2 switchRun = 1;
#32 switchRun = 0;
count = count + 1;
end
endmodule