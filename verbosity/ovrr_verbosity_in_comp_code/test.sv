import uvm_pkg::*;
`include "uvm_macros.svh"

class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  function new(string name="my_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    //Ovrr the def verbosity inside the compoment code
    set_report_verbosity_level_hier(UVM_DEBUG);
    //above if not set will not display UVM_HIGH, UVM_FULL and UVM_DEBUG messages
    //this simply implies the default verbosity is UVM_MEDIUM
    
    `uvm_info("MY_TEST121", "Verbosity: UVM_NONE", UVM_NONE)
    `uvm_info("MY_TEST121", "Verbosity: UVM_LOW", UVM_LOW)
    `uvm_info("MY_TEST121", "Verbosity: UVM_MEDIUM", UVM_MEDIUM)
    `uvm_info("MY_TEST121", "Verbosity: UVM_HIGH", UVM_HIGH)
    `uvm_info("MY_TEST121", "Verbosity: UVM_FULL", UVM_FULL)
    `uvm_info("MY_TEST121", "Verbosity: UVM_DEBUG", UVM_DEBUG)
  endfunction : build_phase
  
endclass : my_test
