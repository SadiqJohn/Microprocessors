# Multi-Cycle Processor Implementation

## Overview
This project demonstrates the design and implementation of a multi-cycle processor using Verilog. Unlike single-cycle processors, multi-cycle processors divide the execution of instructions across multiple clock cycles, enabling optimized resource usage. The design incorporates modular components for instruction execution, memory access, and control logic.

---

## Features
1. **Multi-Cycle Processor Design**:
   - Implements a processor where instructions are executed over multiple clock cycles.
   - Optimizes hardware usage by reusing components in different cycles.
2. **Modular Architecture**:
   - Individual modules handle specific tasks (e.g., ALU operations, program counter, memory management).
3. **Simulation Environment**:
   - Includes a test bench for validating the design's functionality.
4. **Advanced Control Logic**:
   - Control Unit (CU) orchestrates instruction execution across cycles.

---

## Files
### Simulation Files (`sim/`)
- **`testbench.v`**:
  - Verilog test bench to simulate the multi-cycle processor.
  - Validates the processor's ability to fetch, decode, and execute instructions.

### Source Files (`source/`)
- **Core Processor Components**:
  - `Top.v`: Top-level module integrating all components.
  - `CU.v`: Control Unit for multi-cycle control signal generation.
  - `PC.v`: Program Counter for instruction sequencing.
  - `IR.v`: Instruction Register for holding the current instruction.
  - `MEM.v`: Memory module for instruction and data storage.
  - `RF.v`: Register File for storing general-purpose registers.
  - `ALU.v`: Arithmetic Logic Unit for performing computations.
- **Supporting Modules**:
  - `AdrMux.v`, `ALUIn1Mux.v`, `ALUIn2Mux.v`, `PCSelMux.v`: Multiplexers for input selection.
  - `SE.v`: Sign Extension module for handling immediate values.
  - `ALUDecoder.v`: Decodes control signals for the ALU.
  - `AND.v` and `OR.v`: Logical gates for additional control logic.

---

## Skills Demonstrated
- **Processor Design**:
  - Implementation of a multi-cycle processor architecture.
  - Efficient resource utilization through shared components.
- **Control Logic**:
  - Multi-cycle instruction execution using finite state machines.
- **Hardware Simulation**:
  - Development of test benches for comprehensive validation.
- **Verilog Programming**:
  - Modular and reusable design practices.

---

## How to Use
1. Clone the repository and ensure a Verilog simulator (e.g., ModelSim, Xilinx Vivado) is installed.
2. Navigate to the `sim` directory and load `testbench.v` into your simulator.
3. Run the test bench to simulate the processor's behavior under various scenarios.

---

## Future Directions
- Extend the processor to support pipelining for further efficiency improvements.
- Add support for floating-point operations or custom instruction sets.
- Integrate advanced memory hierarchy with caching mechanisms.

---

## Author
This project demonstrates the design of a multi-cycle processor, showcasing advanced concepts in digital design and processor architecture using Verilog.
