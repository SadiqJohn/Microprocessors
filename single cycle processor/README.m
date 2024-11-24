# Single-Cycle Processor Implementation

## Overview
This project demonstrates the design and implementation of a single-cycle processor using Verilog. The processor includes modules for ALU operations, control logic, memory management, and other essential components. The design follows a modular approach, enabling scalability and reusability.

---

## Features
1. **Single-Cycle Processor Design**:
   - Implements all major components of a processor within a single clock cycle.
2. **Modular Components**:
   - Each functional unit (e.g., ALU, Program Counter, Register File) is implemented as a standalone module.
3. **Simulation Environment**:
   - Includes a test bench for validating the functionality of the processor.
4. **Seven-Segment Display Driver**:
   - Additional logic for visualizing outputs via a seven-segment display.

---

## Files
### Simulation Files (`sim/`)
- **`Test_bench.v`**:
  - Verilog test bench for simulating the processor design.
  - Tests various scenarios to validate functionality.

### Source Files (`source/`)
- **Processor Components**:
  - `single_cycle_processor.v`: Top-level module integrating all components.
  - `Control.v`: Control unit for decoding and executing instructions.
  - `Program_Counter.v`: Keeps track of the current instruction.
  - `Instruction_Memory.v`: Stores the program instructions.
  - `Data_Memory.v`: Handles read and write operations to memory.
  - `Register_File.v`: Implements registers for data storage.
  - `ALU.v`: Performs arithmetic and logical operations.
  - `Mux_N_bit.v`: Multiplexer for selecting inputs.
- **Additional Components**:
  - `Shift_Left_2_Branch.v` and `Shift_Left_2_Jump.v`: Used for address calculation.
  - `Sign_Extension.v`: Extends immediate values for operations.
- **Utilities**:
  - `ssd_driver.v`: Seven-segment display driver for visualization.
  - `divide_by_100k.v` and `divide_by_500.v`: Clock dividers for timing adjustments.

---

## Skills Demonstrated
- **Digital Design**:
  - Implementation of a single-cycle processor architecture.
  - Design and integration of modular Verilog components.
- **Hardware Simulation**:
  - Use of test benches for functional validation.
- **Processor Functionality**:
  - Instruction fetching, decoding, execution, and memory operations.
- **Timing and Display**:
  - Clock management and output visualization with seven-segment displays.

---

## How to Use
1. Clone the repository and ensure a Verilog simulator (e.g., ModelSim, Xilinx Vivado) is installed.
2. Navigate to the `sim` directory and load `Test_bench.v` into your simulator.
3. Run the simulation to observe the processor's behavior under various test scenarios.

---

## Future Directions
- Extend the processor to support pipelining for increased efficiency.
- Add support for more complex instructions or custom instruction sets.
- Integrate peripheral devices for enhanced functionality.

---

## Author
This project showcases the design and implementation of a single-cycle processor using Verilog, demonstrating foundational concepts in digital logic design and processor architecture.
