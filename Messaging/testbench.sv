program  test;
  
  import uvm_pkg::*;//step 1 
  `include "uvm_macros.svh"
  
  class hello_uvm extends uvm_test;////step 2 , implement test class
    `uvm_component_utils(hello_uvm)
    
    function new (string name="hello_uvm",uvm_component parent=null);
      super.new(name,parent);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this,"Obection raised from hello_uvm class");
      `uvm_info("Test_ID","Hello UVM world!!!!!!!!!!!!!!!!!!!!!!!",UVM_MEDIUM)
	  
	  
	  `uvm_info("DEBUG","I am printing UVM_DEBUG",UVM_DEBUG)
	  `uvm_info("FULL","I am printing UVM_FULL",UVM_FULL)
	  `uvm_info("HIGH","I am printing UVM_HIGH",UVM_HIGH)
	  `uvm_info("MEDIUM","I am printing UVM_MEDIUM",UVM_MEDIUM)
	  `uvm_info("LOW","I am printing UVM_LOW",UVM_LOW)
	  `uvm_info("NONE","I am printing UVM_NONE",UVM_NONE)
	  
	  
      phase.drop_objection(this,"Obection dropped from hello_uvm class");
    endtask
    
      
  endclass
  
  initial run_test("hello_uvm");//step 3 call this method
  
endprogram
