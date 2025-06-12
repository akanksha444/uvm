`include "uvm_macros.svh"
import uvm_pkg::*;

//----------------------------------------------------

class my_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(my_sequence_item)

  rand int unsigned address;
  rand int unsigned data;

  constraint a {
    address < 1024;
    data < 500;
    data % 2 == 0;
  }

  function new(string name = "my_sequence_item");
    super.new(name);
  endfunction

  function void post_randomize();
    `uvm_info("POST_RAND", "Randomization completed", UVM_LOW)
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("data", data, 32);
    printer.print_field_int("address", address, 32);
  endfunction
endclass

//----------------------------------------------------

class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  my_sequence_item seq;

  function new(string name = "my_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = my_sequence_item::type_id::create("seq");
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    repeat (5) begin
      assert(seq.randomize());
      seq.print();
    end
    phase.drop_objection(this);
  endtask
endclass

//----------------------------------------------------

module top;
  initial begin
    run_test("my_test");
  end
endmodule
