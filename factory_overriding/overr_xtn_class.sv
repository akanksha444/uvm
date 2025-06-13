`include "uvm_macros.svh"
import uvm_pkg::*;

class write_xtn extends uvm_sequence_item;
  `uvm_object_utils(write_xtn)

  rand bit [31:0] data;
  rand bit [11:0] address;

  static int no_of_trans;
  
  constraint a { 
                data > 0;
                data < 2048;
  }

  function new(string name="write_xtn");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("# of trans", no_of_trans, 32, UVM_DEC);
    printer.print_field_int("data", data, 32, UVM_DEC);
    printer.print_field_int("address", address, 12, UVM_DEC);
  endfunction : do_print

  function void post_randomize();
    no_of_trans++;
  endfunction : post_randomize
endclass : write_xtn

class short_xtn extends write_xtn;
  `uvm_object_utils(short_xtn)

  constraint c{
    address inside {[0:16]};
  }
  function new(string name="short_xtn");
    super.new(name);
  endfunction
endclass


module top;
  write_xtn t;
  uvm_factory factory = uvm_factory::get();  
  function void shuffle();
    t = write_xtn::type_id::create("t");
    t.randomize();
    t.print();
  endfunction
  
  initial begin

    repeat(5) shuffle();
    factory.set_type_override_by_type(write_xtn::get_type(), short_xtn::get_type());
    repeat(5) shuffle();
  end
endmodule : top
