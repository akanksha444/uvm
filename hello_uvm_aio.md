# Hello UVM AIO - Answers

---

## 1) What must the most basic UVM program contain?

- A class that extends `uvm_test`
- The macro `\`uvm_component_utils` for factory registration
- A `top` module that calls `run_test()`
- Import of UVM package and inclusion of macros

---

## 2) Why do we have to import `uvm_pkg::*`?

Because all UVM classes, types, and utilities (like `uvm_test`, `uvm_env`, `uvm_sequence`, etc.) are defined inside the `uvm_pkg`. Importing `uvm_pkg::*` gives us access to all of them.

---

## 3) Why do we have to include `"uvm_macros.svh"`?

This file contains useful UVM macros such as:
- `\`uvm_info` (for reporting)
- `\`uvm_component_utils` (for factory registration)
These macros are essential for logging and component creation.

---

## 4) What does the extension `.svh` mean?

`.svh` stands for **SystemVerilog Header**. It is used for files meant to be included via `\`include`, typically containing macros, typedefs, or parameter definitions—not meant to be compiled directly.

---

## 5) Do we have to define test class and object in every UVM program?

Yes, at least one test class that extends `uvm_test` must be defined to drive the simulation using `run_test()`. This is the entry point of a UVM testbench.

---

## 6) How is UVM reporting (e.g., `\`uvm_info`) different from `$display`?

- `\`uvm_info` is part of UVM's built-in reporting system, which allows filtering messages by verbosity and severity levels.
- `$display` is a simple Verilog print statement with no control over logging hierarchy or message suppression.

---

## 7) How many phases are there for components?

UVM components follow multiple simulation phases. Some of the important ones include:
- `build_phase`
- `connect_phase`
- `end_of_elaboration_phase`
- `start_of_simulation_phase`
- `run_phase` (the main time-consuming phase)
- `extract_phase`, `check_phase`, `report_phase`, `final_phase`

There are **12 standard phases**, but you typically implement only the relevant ones.

---

## 8) How is the hierarchy in UVM testbench?

A typical UVM testbench follows this hierarchical structure:

- `top` (Verilog module)
  - calls `run_test()`
    - `uvm_root` (automatic in UVM)
      - `test` (extends `uvm_test`)
        - `env` (extends `uvm_env`)
          - `agent` (extends `uvm_agent`)
            - `sequencer` (extends `uvm_sequencer`)
            - `driver` (extends `uvm_driver`)
            - `monitor` (extends `uvm_monitor`)
          - `scoreboard` (extends `uvm_scoreboard`)

---

## 9) What does the `run_test()` do?

- `run_test()` is the entry point of any UVM test.
- It creates the top-level test class (via factory), executes the UVM phases in order, and manages simulation control and reporting.

---

## 10) What is the use of `top`?

- `top` is the Verilog module used to launch the UVM simulation.
- It contains the `initial begin run_test(); end` block which kicks off the UVM framework.

---

## 11) How to execute this code in the terminal?

### If using Synopsys VCS:
```bash
vcs -full64 -sverilog -ntb_opts uvm-1.2 $(TOP_FILE) -o simv
./simv +UVM_TESTNAME=$(TEST_NAME)

### If using Mentor Questa:
```bash
vlog -sv +acc=rn hello_uvm.sv
vsim -c top +UVM_TESTNAME=$(TEST_NAME) -do "run -all"

