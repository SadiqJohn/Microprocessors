`timescale 1ns / 1ps

module Top(
    input clk
    );
    
    // PC
    wire [31:0] PCF;
    
    // Instruction Memory
    // For R-type
    // Opcode = [31:26], rs = [25:21], rt = [20:16], rd = [15:11], shamt = [10:6], funct = [5:0],
    // For I-type
    // Opcode = [31:26], rs = [25:21], rt = [20:16], immediate = [15:0]
    // For J-type
    // Opcode = [31:26], jump target = [25:0]
    wire [31:0] Instr; // Output of Instruction Memory
    
    // PCAdder
    wire [31:0] PCp1F;
    
    // BranchMux
    wire [31:0] BranchOut;
    
    // JumpMux 
    wire [31:0] JumpOut;
    
    // DReg
    wire [31:0] InstrD;
    wire [31:0] PCp1D;
    
    // Control Unit
    wire MtoRFSelD;
    wire DMWED;
    wire BranchD;
    wire [2:0] ALUSelD;
    wire ALUInSelD;
    wire RFDSelD;
    wire RFWED;
    wire JumpD;
    
    // RF
    wire [31:0] RFRD1;
    wire [31:0] RFRD2;
    
    // ForwardAD Mux
    wire [31:0] ForwardADOut;
    
    // ForwardBD Mux
    wire [31:0] ForwardBDOut;
    
    // Equals
    wire EqualD;
    
    // BranchAnd
    wire PCSelD;
    
    // Sign Extend
    wire [31:0] SImmD;
    
    // PC Branch
    wire [31:0] PCBranchD;
    
    // EReg
    wire RFWEE;
    wire MtoRFSelE;
    wire DMWEE;
    wire BranchE;
    wire [2:0] ALUSelE;
    wire ALUInSelE;
    wire RFDSelE;
    wire [31:0] ForwardAE00;
    wire [31:0] ForwardBE00;
    wire [4:0] rsE;
    wire [4:0] rtE;
    wire [4:0] rdE;
    wire [31:0] SImmE;
    wire [4:0] shamtE;
    
    // ForwardAE
    wire [31:0] ForwardAEOut;
    
    // ForwardBE
    wire [31:0] ForwardBEOut;
    
    // ALU
    wire [31:0] ALUOut;
    
    // ALUIn2Mux
    wire [31:0] ALUIn2E;
    
    // RFDMux
    wire [4:0] RFAE;
    
    // MReg
    wire RFWEM;
    wire MtoRFSelM;
    wire DMWEM;
    wire [31:0] ALUOutM;
    wire [31:0] DMdinM;
    wire [4:0] RFAM;
    
    // DM
    wire [31:0] DMRD;
    
    // WReg
    wire RFWEW;
    wire MtoRFSelW;
    wire [31:0] ALUOutW;
    wire [31:0] DMOutW;
    wire [4:0] RFAW;
    
    // MtoRFMux
    wire [31:0] ResultW;
    
    // HazardUnit
    wire Stall;
    wire ForwardAD;
    wire ForwardBD;
    wire Flush;
    wire [1:0] ForwardAE;
    wire [1:0] ForwardBE;
    
    // F Stage
    PC ProgramCounter(
        .clk(clk),
        .EN(Stall),
        .PCIn(JumpOut),
        .PCOut(PCF));
    IM InstructionMemory(
        .IMA(PCF),
        .IMRD(Instr));
    PCAdder ProgramCounterAdder(
        .PCOld(PCF),
        .PCNew(PCp1F));  
    Mux BranchMux(
        .Sel(PCSelD),
        .In_0(PCp1F),
        .In_1(PCBranchD),
        .Mux_Out(BranchOut));
    Mux JumpMux(
        .Sel(JumpD),
        .In_0(BranchOut),
        .In_1({PCp1F[31:26],InstrD[25:0]}),
        .Mux_Out(JumpOut));
    
    // D Stage
    DReg D(
        .clk(clk),
        .EN(Stall),
        .CLR(PCSelD),
        .IMRD(Instr),
        .PCp1F(PCp1F),
        .InstrD(InstrD),
        .PCp1D(PCp1D));
    CU ControlUnit(
        .Op(InstrD[31:26]),
        .Funct(InstrD[5:0]),
        .MtoRFSel(MtoRFSelD),
        .DMWE(DMWED),
        .Branch(BranchD),
        .ALUSel(ALUSelD),
        .ALUInSel(ALUInSelD),
        .RFDSel(RFDSelD),
        .RFWE(RFWED),
        .Jump(JumpD));       
    RF RegisterFile(
        .clk(clk),
        .RFWE(RFWEW),
        .RFRA1(InstrD[25:21]), // base address: rs
        .RFRA2(InstrD[20:16]), // destination register: rt
        .RFWA(RFAW), // destination register: rt (lw/sw), rd (R-type)
        .RFWD(ResultW),
        .RFRD1(RFRD1),
        .RFRD2(RFRD2));
    Mux ForwardADMux(
        .Sel(ForwardAD),
        .In_0(RFRD1),
        .In_1(ALUOutM),
        .Mux_Out(ForwardADOut));
    Mux ForwardBDMux(
        .Sel(ForwardBD),
        .In_0(RFRD2),
        .In_1(ALUOutM),
        .Mux_Out(ForwardBDOut)); 
    Equals Eq(
        .First(ForwardADOut),
        .Second(ForwardBDOut),
        .EqualD(EqualD));  
    BranchAND BranchA(
        .Branch(BranchD),
        .Zero(EqualD),
        .PCSelOut(PCSelD));        
    SE SignExtend(
        .Imm(InstrD[15:0]), // 16-bit immediate
        .SImm(SImmD));
    PCBranch PCB(
        .SImm(SImmD),
        .PCp1(PCp1D),
        .BranchOut(PCBranchD));
        
    // E Stage    
    EReg E(
        .clk(clk),
        .CLR(Flush),
        .RFWED(RFWED),
        .MtoRFSelD(MtoRFSelD),
        .DMWED(DMWED),
        .ALUSelD(ALUSelD),
        .ALUInSelD(ALUInSelD),
        .RFDSelD(RFDSelD),
        .RFRD1(RFRD1),
        .RFRD2(RFRD2),
        .rsD(InstrD[25:21]),
        .rtD(InstrD[20:16]),
        .rdD(InstrD[15:11]),
        .SImmD(SImmD),
        .shamtD(InstrD[10:6]),
        .RFWEE(RFWEE),
        .MtoRFSelE(MtoRFSelE),
        .DMWEE(DMWEE),
        .ALUSelE(ALUSelE),
        .ALUInSelE(ALUInSelE),
        .RFDSelE(RFDSelE),
        .ForwardAE00(ForwardAE00),
        .ForwardBE00(ForwardBE00),
        .rsE(rsE),
        .rtE(rtE),
        .rdE(rdE),
        .SImmE(SImmE),
        .shamtE(shamtE));
    in3Mux ForwardAEMux(
        .Sel(ForwardAE),
        .In_00(ForwardAE00),
        .In_01(ResultW),
        .In_10(ALUOutM),
        .Mux_Out(ForwardAEOut));
    in3Mux ForwardBEMux(
        .Sel(ForwardBE),
        .In_00(ForwardBE00),
        .In_01(ResultW),
        .In_10(ALUOutM),
        .Mux_Out(ForwardBEOut));
    Mux ALUIn2Mux(
        .Sel(ALUInSelE),
        .In_0(ForwardBEOut),
        .In_1(SImmE),
        .Mux_Out(ALUIn2E));
    ALU ArithmeticLogicUnit(
        .ALUSel(ALUSelE), // One of the outputs of Control Unit
        .ALUIn1(ForwardAEOut), // Output 1 of Register File
        .ALUIn2(ALUIn2E), // Output of Sign Extend module
        .shamt(shamtE),
        .ALUOut(ALUOut));
    Mux RFDMux(
        .Sel(RFDSelE),
        .In_0(rtE),
        .In_1(rdE),
        .Mux_Out(RFAE));
    
    // M Stage    
    MReg M(
        .clk(clk),
        .RFWEE(RFWEE),
        .MtoRFSelE(MtoRFSelE),
        .DMWEE(DMWEE),
        .ALUOut(ALUOut),
        .DMdinE(ForwardBEOut),
        .RFAE(RFAE),
        .RFWEM(RFWEM),
        .MtoRFSelM(MtoRFSelM),
        .DMWEM(DMWEM),
        .ALUOutM(ALUOutM),
        .DMdinM(DMdinM),
        .RFAM(RFAM));
    DM DataMemory(
        .clk(clk),
        .DMWE(DMWEM),
        .DMA(ALUOutM), // Output of ALU
        .DMWD(DMdinM),
        .DMRD(DMRD));  
    
    // W Stage
    WReg W(
        .clk(clk),
        .RFWEM(RFWEM),
        .MtoRFSelM(MtoRFSelM),
        .ALUOutM(ALUOutM),
        .DMRD(DMRD),
        .RFAM(RFAM),
        .RFWEW(RFWEW),
        .MtoRFSelW(MtoRFSelW),
        .ALUOutW(ALUOutW),
        .DMOutW(DMOutW),
        .RFAW(RFAW));
    Mux MtoRFMux(
        .Sel(MtoRFSelW),
        .In_0(ALUOutW),
        .In_1(DMOutW),
        .Mux_Out(ResultW));
    HU HazardUnit(
        .BranchD(BranchD),
        .rsD(InstrD[25:21]),
        .rtD(InstrD[20:16]),
        .rsE(rsE),
        .rtE(rtE),
        .RFAE(RFAE),
        .MtoRFSelE(MtoRFSelE),
        .RFWEE(RFWEE),
        .RFAM(RFAM),
        .RFWEM(RFWEM),
        .RFAW(RFAW),
        .RFWEW(RFWEW),
        .Stall(Stall),
        .ForwardAD(ForwardAD),
        .ForwardBD(ForwardBD),
        .Flush(Flush),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE));
    
endmodule
