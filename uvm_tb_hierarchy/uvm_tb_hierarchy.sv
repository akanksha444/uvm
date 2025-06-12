`include "uvm_macros.svh"
import uvm_pkg::*;

//----------------------------------------------------------------------------
class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)
  
  function new(string name="my_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("my_monitor", "A new monitor object is created", UVM_LOW)
//   `uvm_info("FULL_NAME", get_full_name(), UVM_LOW)
  endfunction : new

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    `uvm_info("my_monitor", "I am inside monitor build phase", UVM_LOW)
 endfunction : build_phase
  
endclass : my_monitor
//----------------------------------------------------------------------------
class my_driver extends uvm_driver;
  `uvm_component_utils(my_driver)
  
  function new(string name="my_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("my_driver", "A new driver object is created", UVM_LOW)
//    `uvm_info("FULL_NAME", get_full_name(), UVM_LOW)
  endfunction : new

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    `uvm_info("my_driver", "I am inside driver build phase", UVM_LOW)
 endfunction : build_phase
  
endclass : my_driver
//----------------------------------------------------------------------------
class my_sequencer extends uvm_sequencer;
  `uvm_component_utils(my_sequencer)
  
  function new(string name="my_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("my_sequencer", "A new sequencer object is created", UVM_LOW)
//    `uvm_info("FULL_NAME", get_full_name(), UVM_LOW)
  endfunction : new

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    `uvm_info("my_sequencer", "I am sequencer agent build phase", UVM_LOW)
 endfunction : build_phase
  
endclass : my_sequencer
//----------------------------------------------------------------------------
class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)
  
  my_sequencer seq;
  my_driver drv;
  my_monitor mon;
  
  function new(string name="my_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MY_AGENT", "A new agent object is created", UVM_LOW)
//    `uvm_info("FULL_NAME", get_full_name(), UVM_LOW)
  endfunction : new

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    `uvm_info("MY_AGENT", "I am inside agent build phase", UVM_LOW)

   //build the drv, mon, seq
    seq = my_sequencer::type_id::create("seq", this);
    drv = my_driver::type_id::create("drv", this);
    mon = my_monitor::type_id::create("mon", this);
 endfunction : build_phase
  
endclass : my_agent
//----------------------------------------------------------------------------
class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  
  my_agent agnt;
  
  function new(string name="my_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MY_ENV", "A new env object is created", UVM_LOW)
//    `uvm_info("FULL_NAME", get_full_name(), UVM_LOW)
  endfunction : new

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    `uvm_info("MY_ENV", "I am inside env build phase", UVM_LOW)

   //build the agent
    agnt = my_agent::type_id::create("agnt", this);
 endfunction : build_phase
  
endclass : my_env
//----------------------------------------------------------------------------
class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  my_env env;
  
  function new(string name="my_test", uvm_component parent);
    super.new(name, parent);
     `uvm_info("MY_TEST", "A new test object is created", UVM_LOW)
//    `uvm_info("FULL_NAME", get_full_name(), UVM_LOW)
  endfunction : new

 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   `uvm_info("MY_TEST", "I am inside test build phase", UVM_LOW)

   //build the env
   env = my_env::type_id::create("env", this);
 endfunction : build_phase
               
endclass : my_test
//----------------------------------------------------------------------------
module top;
  initial begin
    run_test("my_test");
  end
endmodule
