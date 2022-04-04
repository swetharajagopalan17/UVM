// Code your design here
import uvm_pkg::*;

class packet extends uvm_sequence_item;

  rand logic [31:0] addr;
  rand logic [31:0] data;
  
  `uvm_object_utils_begin(packet)
  `uvm_field_int(addr, UVM_ALL_ON)
  `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end
  
  constraint valid {
    addr inside {[0:15]};
    data inside {[20:100]};
  }
  
  function new(string name="packet");
    super.new(name);
  endfunction
  
  virtual function string convert2string();
    return $sformatf(" addr = %0d data = %0d",addr,data);
  endfunction
  
endclass
