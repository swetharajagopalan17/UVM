
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "intf.sv"
`include "packet.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "iMonitor.sv"
`include "m_agent.sv"
`include "oMonitor.sv"
`include "s_agent.sv"
`include "scoreboard.sv"
`include "coverage.sv"
`include "environment.sv"
`include "test.sv"
//`include "test2.sv"
`include "pgm_blk.sv"
module top;
  
  bit clk;
  
  always #5 clk = ~clk;
  
  simple_if intf_inst(clk);
  
  dut DFF(
    .clk(clk),
    .inp(intf_inst.inp),
    .outp(intf_inst.outp)
  );
  
  pgm_blk_test tb_inst(intf_inst);
  
  
  
endmodule
