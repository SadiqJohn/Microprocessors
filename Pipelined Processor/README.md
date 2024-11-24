# Pipelined Processor Implementation

## Overview
This project demonstrates the design and implementation of a pipelined processor using Verilog. Pipelining enhances instruction throughput by dividing instruction execution into multiple stages, with each stage executing in parallel. The design incorporates advanced control and forwarding mechanisms to handle hazards and dependencies.

---

## Features
1. **Pipelined Processor Design**:
   - Implements a 5-stage instruction pipeline (Fetch, Decode, Execute, Memory, Writeback).
   - Optimized for high instruction throughput.
2. **Hazard Detection and Forwarding**:
   - Includes hazard detection and forwarding units to handle data and control hazards.
3. **Modular Architecture**:
   - Each pipeline stage is implemented as an independent module for scalability.
4. **Simulation Environment**:
   - Provides a test bench for validating the processor's functionality under various conditions.

---

## Files
### Simulation Files (`sim/`)
- **`Testbench.v`**:
  - Verilog test bench to simulate the pipelined processor.
  - Validates instruction throughput and hazard management.

### Source Files (`source/`)
- **Core Processor Components**:
  - `Top.v`: Top-level module integrating all pipeline stages.
  - `CU.v`: Control Unit for signal generation across the pipeline.
  - `PC.v`: Program Counter for instruction sequencing.
  - `IM.v`: Instruction Memory for storing program instructions.
  - `DM.v`: Data Memory for handling read and write operations.
  - `RF.v`: Register File for general-purpose registers.
  - `ALU.v`: Arithmetic Logic Unit for executing operations.
  - `SE.v`: Sign Extension module for handling immediate values.
- **Pipeline Stages**:
  - `DReg.v`, `EReg.v`, `MReg.v`, `WReg.v`: Registers for passing data between pipeline stages.
  - `PCAdder.v`, `PCBranch.v`: Modules for branch and jump calculations.
- **Hazard Handling**:
  - `HU.v`: Hazard Unit for detecting and resolving pipeline hazards.
  - `ForwardADMux.v`, `ForwardAEMux.v`, `ForwardBDMux.v`, `ForwardBEMux.v`: Forwarding units for resolving data hazards.
- **Multiplexers and Control Logic**:
  - `3Mux.v`, `Mux.v`: Multiplexers for signal and data routing.
  - `BranchAND.v`, `BranchMux.v`, `JumpMux.v`: Modules for branch and jump control.

---

## Skills Demonstrated
- **Processor Design**:
  - Implementation of a pipelined processor architecture.
  - Handling of hazards and dependencies using forwarding and stalling mechanisms.
- **Control and Data Flow**:
  - Instruction sequencing through a 5-stage pipeline.
  - Integration of control signals for branching and jumps.
- **Hardware Simulation**:
  - Comprehensive test bench for validating processor functionality.
- **Verilog Programming**:
  - Modular design with reusable and scalable components.

---

## How to Use
1. Clone the repository and ensure a Verilog simulator (e.g., ModelSim, Xilinx Vivado) is installed.
2. Navigate to the `sim` directory and load `Testbench.v` into your simulator.
3. Run the simulation to observe the processor's pipelined execution and hazard handling.

---

## Future Directions
- Extend the pipeline to include more advanced stages (e.g., cache access).
- Implement support for floating-point operations and custom instruction sets.
- Enhance the hazard unit to support out-of-order execution.

---

## Author
This project demonstrates the design of a pipelined processor, showcasing advanced digital design techniques and Verilog-based implementation.
