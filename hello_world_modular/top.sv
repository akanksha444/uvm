//top is the entry point 
//we must call the run_test function here

//run test a uvm method, it needs to have access to the uvm library
//hence we must include the packages and macro files

import uvm_pkg::*;
`include "uvm_macros.svh"

module top;
  initial begin
    run_test();
  end
endmodule : top
