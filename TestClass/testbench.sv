// Code your testbench here
// or browse Examples

  
  import uvm_pkg::*; //step 1 
  //`include "uvm_macros.svh" - needed for Questa or Cadence but optional for Synopsys 

`include "environemnt.sv"
`include "test.sv"

  // Top Module
module top;
  
  // Run Test
  initial begin
    run_test();
  end
  
endmodule: top
