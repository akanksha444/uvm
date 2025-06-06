
//********************************************************//
//******Answers to all the questions are provided in******//
//******************hello_uvm_aio.md file*****************//
//********************************************************//

//----------------------------------------------------
// 1) What must the most basic UVM program contain?
// 2) Why do we have to import uvm_pkg::*
// 3) Why do we have to include "uvm_macros.svh"
// 4) What does the extension .svh mean?
//
//----------------------------------------------------

import uvm_pkg::*;
`include "uvm_macros.svh"

//---------------------------------------------------------------------
// 5) Do we have to define test class and object in every uvm program?
// 
//---------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////TEST///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

class hello_test extends uvm_test;
  //factory registration
  `uvm_component_utils(hello_test)

  //overriding constructor
  function new(string name="hello_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------------------------------------
  // 6) How is uvm reporting (eg: `uvm_info) different from $display?
  // 7) How many phases are there for components?
  //
  //---------------------------------------------------------------------

  //defining phase methods
  function void build_phase(uvm_phase phase);
    $display("****************************Build phase begins********************************");
    `uvm_info("HELLO_WORLD", "Hello, UVM world!", UVM_LOW)
    $display("****************************Build phase ends**********************************");
  endfunction : build_phase

endclass : hello_test

//---------------------------------------------------------------------
// 8) How is the hierarchy in UVM testbench?
// 9) What does the run_test() do?
// 10) What is the use of top?
//
//---------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////TOP MODULE////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
module top;
  initial begin
    run_test();
  end
endmodule : top

//---------------------------------------------------------------------
// 11) How to execute this code in the terminal?
//---------------------------------------------------------------------
