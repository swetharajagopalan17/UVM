// Code your testbench here
// or browse Examples

import "DPI-C" function int unsigned mux_dpi_model(input int unsigned i0,i1,sel);

`include "intf.sv"
`include "pgm_blk.sv"

module top;
  
  mux_if mux_if_inst();
  
  mux DUT(
    .i0(mux_if_inst.i0),
    .i1(mux_if_inst.i1),
    .sel(mux_if_inst.sel),
    .y(mux_if_inst.y)
  );
  
  mux_program pgm_inst(mux_if_inst);
  
endmodule
