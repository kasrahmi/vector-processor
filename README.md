# vector-processor

![GitHub](https://img.shields.io/github/license/kasrahmi/vector-processor)
![GitHub last commit](https://img.shields.io/github/last-commit/kasrahmi/vector-processor)

## Overview

This project implements a vector processor in Verilog, designed to handle 512-bit arrays of integers. The processor comprises three main components: an Arithmetic Logic Unit (ALU) capable of addition and multiplication, a Register File (RF) with four 512-bit registers (A1 to A4), and a Memory Interface for loading/storing data from/to an external memory.

## Modules

### ALU (Arithmetic Logic Unit)

The ALU module (`alu.v`) performs arithmetic operations on two 512-bit inputs. It supports addition and multiplication operations based on the ALUOp signal.

### Register File (RF)

The Register File module (`rf.v`) manages four 512-bit registers (`A1` to `A4`). It supports simultaneous read and write operations, controlled by address and enable signals.

### Memory Interface

The Memory module (`memory.v`) interfaces with an external memory array (`data_memory`). It supports loading data into memory (`store` operation) and retrieving data from memory (`load` operation). The memory depth is 512 locations with each location storing 32 bits.

### Vector Processor (VECTOR_PROCESSOR)

The top-level module (`vector_processor.v`) integrates the ALU, RF, and Memory modules. It executes instructions (`control_load`, `control_store`, `control_add_mull`) to perform load, store, add, and multiply operations on 512-bit vector data.

## Functionality

The vector processor supports the following operations:
- **Load (`load`)**: Loads data from memory into registers A1 and A2 based on specified addresses.
- **Store (`store`)**: Stores data from register A3 into memory at the specified address.
- **Addition (`add`)**: Performs addition on registers A1 and A2, storing the low and high 512 bits of the result in registers A3 and A4, respectively.
- **Multiplication (`mul`)**: Performs multiplication on registers A1 and A2, storing the low and high 512 bits of the result in registers A3 and A4, respectively.

## Directory Structure

|-- alu.v // ALU module
|-- rf.v // Register File module
|-- memory.v // Memory module
|-- vector_processor.v // Top-level module integrating ALU, RF, and Memory
|-- tb.v // Testbench module
|-- file.txt // Initialization file for memory
|-- README.md // This file


## Usage

To simulate the vector processor:
1. Clone the repository.
2. Compile the Verilog files (`alu.v`, `rf.v`, `memory.v`, `vector_processor.v`, `tb.v`).
3. Initialize memory with data from `file.txt`.
4. Run the simulation using your preferred Verilog simulation tool (e.g., ModelSim, Xilinx Vivado).

## Testbench

The testbench (`tb.v`) verifies the functionality of the vector processor using various test cases. It ensures correct behavior across different operations and edge cases, validating both functional correctness and performance.

## Contributions

Contributions to enhance functionality, optimize performance, or improve documentation are welcome. To contribute:
- Fork the repository.
- Create a new branch (`git checkout -b feature-improvement`).
- Make your changes and commit them (`git commit -am 'Add feature'`).
- Push to the branch (`git push origin feature-improvement`).
- Create a new Pull Request.

  
## Contact

For questions, feedback, or further inquiries, please contact [Your Name](mailto:a.kasrahmi@gmail.com).
