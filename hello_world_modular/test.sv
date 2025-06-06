//there should be atleast one test component 

import uvm_pkg::*
`include "uvm_macros.svh"
  
class my_test extends uvm_test;
  //factory regisration must be done immediately
  `uvm_component_utils(my_test)

  //overriding constructor
  function new(string name="my_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  //the other programs can be written inside different phases
  function void build_phase(uvm_phase phase);
    `uvm_info("MY_TEST", "Hello World! I am inside the build phase", UVM_LOW);
  endfunction : build_phase

endclass : my_test
