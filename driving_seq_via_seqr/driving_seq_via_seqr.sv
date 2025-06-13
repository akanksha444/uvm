`include "uvm_macros.svh"
import uvm_pkg::*;

//-----------------------------------------------------------sequence_item
class my_transaction extends uvm_sequence_item;
  rand bit[7:0] data;

  `uvm_object_utils(my_transaction)

  function new(string name="my_transaction");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("data", data, 8);
  endfunction
endclass 

//-----------------------------------------------------------sequence
class my_sequence extends uvm_sequence#(my_transaction);
  `uvm_object_utils(my_sequence)
  my_transaction req;
  
  function new(string name ="my_sequence");
    super.new(name);
  endfunction

  virtual task body();
    req = my_transaction::type_id::create("req");
    repeat (3) begin
    start_item(req);
    assert(req.randomize());
    finish_item(req);
    end
  endtask
endclass

//-----------------------------------------------------------driver
class my_driver extends uvm_driver#(my_transaction);
  `uvm_component_utils(my_driver)

  my_transaction req;
  
  function new(string name="my_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    //we dont need to create any object bcz, we dont have to manipulate the data anyways 
    //we only forward the transactions
    forever begin
      seq_item_port.get_next_item(req);
      req.print();	
      `uvm_info("DRV", $sformatf("Driving data: %0d", req.data), UVM_LOW)
      seq_item_port.item_done();
    end
  endtask
endclass

//-----------------------------------------------------------sequencer
// we dont need to exclusively override this class, we have instantated the base class itself in env
//-----------------------------------------------------------env
class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  uvm_sequencer#(my_transaction) seqr;
  my_driver drv;
  
  function new(string name="my_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create the seqr and drv
    seqr = uvm_sequencer#(my_transaction)::type_id::create("seqr", this);
    drv = my_driver::type_id::create("drv", this);    
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //connect the driver and seqr
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass

//-----------------------------------------------------------test
class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  my_env env;
  my_sequence seq;

  function new(string name="my_test", uvm_component parent=null);
               super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create env obj
    env = my_env::type_id::create("env", this);
  endfunction
               
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    //start seq on seqr
    seq = my_sequence::type_id::create("seq", this);
    seq.start(env.seqr);
    phase.drop_objection(this);
  endtask

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass

//-----------------------------------------------------------top
module top;
  initial begin
    run_test("my_test");
  end
endmodule

//use the below commands to run the simulation on VCS
//vcs -full64 -sverilog -ntb_opts uvm-1.2 file_name.sv -o simv
//./simv
