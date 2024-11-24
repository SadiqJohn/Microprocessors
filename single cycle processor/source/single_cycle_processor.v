`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 10:20:15 PM
// Design Name: 
// Module Name: single_cycle_processor
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


module single_cycle_processor
(clkFast, reset, SwitchSelector, switchRun, Cathode, AN,
LEDIndicator, reg_read_data_1);
input clkFast, reset; // clkFast (5m[6] Hz) feeds clock divider
input switchRun; // decide run(1) or check reg file(0)
input [4:0] SwitchSelector; // select $0 to $31 for output
output [6:0] Cathode; // SSD
output [3:0] AN;
output LEDIndicator; // output clkNormal for user reference
output [31:0] reg_read_data_1; // moved here for simulation
// PC signals
wire [7:0] PC_in, PC_out;
wire [31:0] PC_original, PC_out_unsign_extended, PC_plus4;
// I-MEM signals
wire [31:0] instruction;
// Register File signals
wire [4:0] reg_write_addr;
wire [31:0] reg_write_data, reg_read_data_2; // reg_read_data_1 moved to output for simulation
// D-MEM signals
wire [7:0] D_MEM_addr;
wire [31:0] D_MEM_read_data;
// control signals
wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
wire [3:0] ALU_control_out;
// branch
wire [31:0] extended_immidiate;
wire [31:0] shifted_immidiate;
wire [31:0] Branch_out;
wire [31:0] Branch_result;
wire Branch_decided, zero;
// jump
wire [27:0] jump_base28;
wire [31:0] jump_addr;
// ALU
wire [31:0] ALU_inB, ALU_out;
// SSD display & clock slow-down
wire clkSSD, clkNormal, clkRF, clk;
// clkFast: 5m Hz
// clkSSD: 500 Hz for ring counter
// clkNormal: 1 Hz
wire [3:0] tho; // Binary-Coded-Decimal 0-15
wire [3:0] hun;
wire [3:0] ten;
wire [3:0] one;
wire [6:0] thossd;
wire [6:0] hunssd;
wire [6:0] tenssd;
wire [6:0] onessd;
// multi-purpose I-MEM read_addr_1
wire [4:0] multi_purpose_read_addr;
wire multi_purpose_RegWrite;
// reg to resolve always block technicals
reg clkRF_reg, clk_reg, multi_purpose_RegWrite_reg;
reg [4:0] multi_purpose_read_addr_reg;
reg [3:0] tho_reg, hun_reg, ten_reg, one_reg;
assign D_MEM_addr = ALU_out[7:0];
assign PC_in = PC_original[7:0];
assign PC_out_unsign_extended = {26'b0000_0000_0000_0000_0000_0000, PC_out}; // from 7 bits to 32 bits
assign jump_addr = {PC_plus4[31:28], jump_base28}; // jump_addr = (PC+4) [31:28] joined with jump_base28[27:0]
// output processor clock (1 Hz or freeze) to a LED
assign LEDIndicator = clk;
Program_Counter Unit1
(.clk(clk), .reset(reset), .PC_in(PC_in), .PC_out(PC_out));
Instruction_Memory Unit2
(.read_addr(PC_out), .instruction(instruction), .reset(reset));
Register_File Unit3
(   .read_addr_1(multi_purpose_read_addr), .read_addr_2(instruction[20:16]), 
    .write_addr(reg_write_addr), .read_data_1(reg_read_data_1), 
    .read_data_2(reg_read_data_2), 
    .write_data(reg_write_data), .RegWrite(multi_purpose_RegWrite), 
    .clk(clkRF), .reset(reset)
    );
Data_Memory Unit4
(.addr(D_MEM_addr), .write_data(reg_read_data_2), .read_data(D_MEM_read_data), .
clk(clk), .reset(reset), .MemRead(MemRead), .MemWrite(MemWrite));
Control Unit5
(.OpCode(instruction[31:26]), .RegDst(RegDst), .Jump(Jump),
 .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), 
 .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc),
  .RegWrite(RegWrite)
  );
ALUControl Unit6
(.ALUOp(ALUOp), .funct(instruction[5:0]), .out_to_ALU(ALU_control_out));
Sign_Extension Unit7
(.sign_in(instruction[15:0]), .sign_out(extended_immidiate));
Shift_Left_2_Branch Unit8
(.shift_in(extended_immidiate), .shift_out(shifted_immidiate));
Shift_Left_2_Jump Unit9
(.shift_in(instruction[25:0]), .shift_out(jump_base28));
Mux_N_bit #(5) Unit10 (.in0(instruction[20:16]), .in1(instruction[15:11]),
.mux_out(reg_write_addr), .control(RegDst));
Mux_N_bit #(32) Unit11
(.in0(reg_read_data_2), .in1(extended_immidiate), .mux_out(ALU_inB), .control(ALUSrc));
Mux_N_bit #(32) Unit12
(.in0(ALU_out), .in1(D_MEM_read_data), .mux_out(reg_write_data), .control(MemtoReg));
Mux_N_bit #(32) Unit13
(.in0(PC_plus4), .in1(Branch_out), .mux_out(Branch_result), .control(Branch_decided));
Mux_N_bit #(32) Unit14
(.in0(Branch_result), .in1(jump_addr), .mux_out(PC_original), .control(Jump));
ALU Unit15
(.inA(reg_read_data_1), .inB(ALU_inB), .alu_out(ALU_out), .zero(zero), .control(ALU_control_out));
ALU_add_only Unit16
(.inA(PC_out_unsign_extended), .inB(32'b0100), .add_out(PC_plus4)); // PC + 4
ALU_add_only Unit17
(.inA(PC_plus4), .inB(shifted_immidiate), .add_out(Branch_out));
and (Branch_decided, zero, Branch);
// SSD Display
divide_by_100k Unit_Clock500HZ
(.clock(clkFast), .reset(reset), .clock_out(clkSSD));
divide_by_500 Unit_Clock1HZ
(.clock(clkSSD), .reset(reset), .clock_out(clkNormal));
Ring_4_counter Unit_Ring_Counter (.clock(clkSSD), .reset(reset), .Q(AN));
ssd_driver Unit_SSDTHO (.in_BCD(tho), .out_SSD(thossd));
ssd_driver Unit_SSDHUN (.in_BCD(hun), .out_SSD(hunssd));
ssd_driver Unit_SSDTEN (.in_BCD(ten), .out_SSD(tenssd));
ssd_driver Unit_SSDONE (.in_BCD(one), .out_SSD(onessd));
choose_chathode Unit_CHOOSE
(.tho(thossd), .hun(hunssd), .ten(tenssd), .one(onessd), .AN(AN), .CA(Cathode));
assign clkRF = clkRF_reg;
assign clk = clk_reg;
assign multi_purpose_read_addr = multi_purpose_read_addr_reg;
assign multi_purpose_RegWrite = multi_purpose_RegWrite_reg;
assign tho = tho_reg;
assign hun = hun_reg;
assign ten = ten_reg;
assign one = one_reg;
always @(switchRun or clkSSD) begin
if (switchRun) begin
// sys status 1: run single-cycle processor
clkRF_reg <= clkNormal; // 1 Hz
clk_reg <= clkNormal; // 1 Hz
multi_purpose_read_addr_reg <= instruction[25:21]; // regfile-port1 reads from instruction
// reg-file protection measure; explained in "else"
multi_purpose_RegWrite_reg <= RegWrite;
// output PC to SSD, but since PC only has 6 bits
tho_reg <= PC_out_unsign_extended[15:12]; // always 0! Project #2 Team #3
hun_reg <= PC_out_unsign_extended[11:8]; // always 0
ten_reg <= PC_out_unsign_extended[7:4];
one_reg <= PC_out_unsign_extended[3:0];
end
else begin
// sys status 2: pause processor; inspect Reg File content
clkRF_reg <= clkSSD; // 500 Hz
clk_reg <= 1'b0; // freeze at 0
multi_purpose_read_addr_reg <= SwitchSelector; // reg-fileport1 reads from SwitchSelector
// Reg-file is not freezed in time, this protects against RFdata-overwrite
multi_purpose_RegWrite_reg <= 1'b0;
// output reg file content to SSD, but only the lower 16 bits(we only have 4 SSD)
tho_reg <= reg_read_data_1[15:12];
hun_reg <= reg_read_data_1[11:8];
ten_reg <= reg_read_data_1[7:4];
one_reg <= reg_read_data_1[3:0];
end
end
endmodule

