import uvm_pkg::*;
`include "uvm_macros.svh"

class my_test extends uvm_test;

  //factory registration
  `uvm_component_utils(my_test)

  //overriding constructor
  function new(string name="my_test", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern function void start_of_simulation_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void extract_phase(uvm_phase phase);
  extern function void check_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);
  extern function void final_phase(uvm_phase phase);

endclass : my_test

function void my_test::build_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside build phase", UVM_LOW)
endfunction : build_phase

function void my_test::connect_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside connect phase", UVM_LOW)
endfunction : connect_phase

function void my_test::end_of_elaboration_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside end_of_elaboration phase", UVM_LOW)
endfunction : end_of_elaboration_phase

function void my_test::start_of_simulation_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside start_of_simulation phase", UVM_LOW)
endfunction : start_of_simulation_phase

task run_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside run phase", UVM_LOW)
endfunction : run_phase

function void my_test::extract_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside extract phase", UVM_LOW)
endfunction : extract_phase

function void my_test::check_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside check phase", UVM_LOW)
endfunction : check_phase

function void my_test::report_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside report phase", UVM_LOW)
endfunction : report_phase

function void my_test::final_phase(uvm_phase phse);
  `uvm_info("MY_TEST", "I am inside final phase", UVM_LOW)
endfunction : final_phase
