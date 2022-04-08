// Packet class

class packet extends uvm_sequence_item;
  
  rand bit [7:0] inp;
  bit [7:0] prev_inp;
  
 // constraint valid{
 //   inp inside {[0:10]};
 // }
  
  constraint vaild2{
    inp != prev_inp; 
  }
  
  `uvm_object_utils_begin(packet)
  `uvm_field_int(inp, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="packet");
	super.new(name);
  endfunction 
  
  virtual function string convert2string();
	return $sformatf(" inp=%0d",inp);
  endfunction 
  
  function void post_randomize();
    prev_inp = inp;
  endfunction
  
    function void my_copy(packet A);
    inp = A.inp;
  endfunction
  
endclass
