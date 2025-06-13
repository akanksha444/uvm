class my_driver extends uvm_driver;
  `uvm_component_utils(my_driver)

  my_tranction t;
  
  function new(string name="my_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    //we dont need to create any object bcz, we dont have to manipulate the data anyways 
    //we only forward the transactions
    forever begin
      get_next_item();
    end
  endtask
endclass

//-----------------------------------------------------------sequencer
// we dont need to exclusively override this class, we have instantated the base class itself in env
//-----------------------------------------------------------env
class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  my_sequencer#(my_transaction) seqr;
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
    phase.raise_objection;
    //start seq on seqr
    seq = my_sequence::type_id::create("seq", this);
    seq.start(env.seqr);
    phase.drop_objection;
  endtask
  
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
