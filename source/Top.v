`timescale 1ns / 1ps
// Top module
module Top(
    input clk
    );
    
    // Program Counter
    wire [31:0] PCOut; // Output of the Program Counter
    
    // Adr Mux
    wire [31:0] Adr; // Input of Memory
    
    // Memory
    // For R-type
    // Opcode = [31:26], rs = [25:21], rt = [20:16], rd = [15:11], shamt = [10:6], funct = [5:0],
    // For I-type
    // Opcode = [31:26], rs = [25:21], rt = [20:16], immediate = [15:0]
    // For J-type
    // Opcode = [31:26], jump target = [25:0]
    wire [31:0] MRD; // Output of Memory 
    
    // IR
    wire [31:0] IROut;
    
    // DR
    wire [31:0] DROut;
    
    // RFDSelMux
    wire [4:0] RFDSelOut;
    
    //MtoRFSelMux
    wire [31:0] MtoRFSelOut;
    
    // RF
    wire [31:0] RFRD1;
    wire [31:0] RFRD2;
    
    // ABR
    wire [31:0] AOut;
    wire [31:0] BOut;
    
    // SE
    wire [31:0] SImm;

    // ALUIn1Mux
    wire [31:0] ALUIn1MuxOut;
    
    // ALUIn2Mux
    wire [31:0] ALUIn2MuxOut;
    
    // ALU
    wire [31:0] ALUOut;
    wire Zero;
    
    // Gates
    wire ANDOut;
    wire OROut;
    
    // ALUOutR
    wire [31:0] ALUOutROut;
    
    // PCSelMux
    wire [31:0] PCSelOut;

    // Control Unit
    wire MtoRFSel;
    wire RFDSel;
    wire IDSel;
    wire PCSel;
    wire ALUIn1Sel;
    wire [1:0] ALUIn2Sel;
    wire IRWE;
    wire MWE;
    wire PCWE;
    wire Branch;
    wire RFWE;
    wire [1:0] ALUOp;
    
    // ALU Decoder
    wire [2:0] ALUSel;
    
    // Multicycle cycle datapath
    PC ProgramCounter(
        .clk(clk),
        .PCWE(OROut),
        .PCIn(PCSelOut),
        .PCOut(PCOut));
    AdrMux AdrM(
        .Sel(IDSel),
        .In0(PCOut),
        .In1(ALUOutROut),
        .MuxOut(Adr));
    MEM Memory(
        .clk(clk),
        .MWE(MWE),
        .MRA(Adr),
        .MWD(BOut),
        .MRD(MRD));
    IR InstructionRegister(
        .clk(clk),
        .IRWE(IRWE),
        .IRIn(MRD),
        .IROut(IROut));
    DR DataRegister(
        .clk(clk),
        .DRIn(MRD),
        .DROut(DROut));    
    RFDSelMux RFDSelM(
        .Sel(RFDSel),
        .In0(IROut[20:16]),
        .In1(IROut[15:11]),
        .MuxOut(RFDSelOut));
    MtoRFSelMux MtoRFSelM(
        .Sel(MtoRFSel),
        .In0(ALUOutROut),
        .In1(DROut),
        .MuxOut(MtoRFSelOut));
    RF RegisterFile(
        .clk(clk),
        .RFWE(RFWE),
        .RFRA1(IROut[25:21]),
        .RFRA2(IROut[20:16]),
        .RFWA(RFDSelOut),
        .RFWD(MtoRFSelOut),
        .RFRD1(RFRD1),
        .RFRD2(RFRD2));
    ABR ABRegister(
        .clk(clk),
        .AIn(RFRD1),
        .BIn(RFRD2),
        .AOut(AOut),
        .BOut(BOut));
    ALUIn1Mux ALUIn1M(
        .ALUIn1Sel(ALUIn1Sel),
        .ALUIn1In0(PCOut),
        .ALUIn1In1(AOut),
        .ALUIn1MuxOut(ALUIn1MuxOut));
    SE SignExtender(
        .Imm(IROut[15:0]),
        .SImm(SImm));
    ALUIn2Mux ALUIn2M(
        .ALUIn2Sel(ALUIn2Sel),
        .In00(BOut),
        .In01(32'b1),
        .In10(SImm),
        .ALUIn2MuxOut(ALUIn2MuxOut));
    ALU ArithmeticLogicUnit(
        .ALUSel(ALUSel),
        .ALUIn1(ALUIn1MuxOut),
        .ALUIn2(ALUIn2MuxOut),
        .shamt(IROut[10:6]),
        .Zero(Zero),
        .ALUOut(ALUOut));
    AND ANDGate(
        .Branch(Branch),
        .Zero(Zero),
        .ANDOut(ANDOut));
    OR ORGate(
        .PCWE(PCWE),
        .ANDOut(ANDOut),
        .OROut(OROut));
    ALUOutR ArithmeticLogicUnitOutRegister(
        .clk(clk),
        .ALUOutRIn(ALUOut),
        .ALUOutROut(ALUOutROut));       
    PCSelMux PCSelM(
        .PCSel(PCSel),
        .In00(ALUOut),
        .In01(ALUOutROut),
        .In10({PCOut[31:26],IROut[25:0]}),
        .MuxOut(PCSelOut));
        
    CU ControlUnit(
        .clk(clk),
        .Op(IROut[31:26]),
        .MtoRFSel(MtoRFSel),
        .RFDSel(RFDSel),
        .IDSel(IDSel),
        .PCSel(PCSel),
        .ALUIn1Sel(ALUIn1Sel),
        .ALUIn2Sel(ALUIn2Sel),
        .IRWE(IRWE),
        .MWE(MWE),
        .PCWE(PCWE),
        .Branch(Branch),
        .RFWE(RFWE),
        .ALUOp(ALUOp));
    ALUDecoder ALUD(
        .ALUOp(ALUOp),
        .Funct(IROut[5:0]),
        .ALUSel(ALUSel));
endmodule
