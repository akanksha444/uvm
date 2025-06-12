//stimulus modeling requries:
//transaction class (my_sequence
//atleast a test class where the sequence is randomized as per required logic
//top

`include "uvm_macros.svh"
import uvm_pkg::*;

//----------------------------------------------------

class my_sequence extends uvm_sequence_item;
  //factory registraiton
  `uvm_object_utils(my_sequence)
  
  //member declaration
  rand int unsigned address;
  rand int unsigned data;
  
  //constraint
  constraint a {
                  address <1024;
                  data < 500;
                  data%2 ==0;
                  }
  
  //ovrr const
  function new(string name="my_sequence");
    super.new(name);
  endfunction : new

  function void post_randomize();
    `uvm_info("POST_RAND", "Randomizeation completed", UVM_LOW)
  endfunction : post_randomize

  function void display();
    `uvm_info("DISPLAY", "******************************************", UVM_LOW)
    `uvm_info("DISPLAY", "Randomized Value", UVM_LOW)
    `uvm_info("DISPLAY", $sformatf("address: %0d", this.address), UVM_LOW)
    `uvm_info("DISPLAY", $sformatf("data: %0d", this.data), UVM_LOW)
  endfunction : display
  
endclass : my_sequence

//----------------------------------------------------

class my_test extends uvm_test;
  //fact reg
  `uvm_component_utils(my_test)
  
  //create seq handle
  my_sequence seq;
  
  //overr constructor
  function new(string name="my_test", uvm_component parent);
    super.new(name, parent)l
  endfunction : new
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create seq instance
    seq = my_sequence::type_id::create("seq");
    
  endfunction : build_phase
  
  //run phase
  task run_phase(uvm_phase phase);
    super.run();

    repeat(5) begin
      assert(seq.randomize());
      seq.display();
    end
    
  endtask : run_phase
  
endclass : my_test


module top;
  initial begin
    run_test("my_test");
  end
endmodule : top
