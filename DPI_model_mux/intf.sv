// Inteface
interface mux_if();
  
  logic i0,i1,sel,y;
  
  modport tb(output i0,i1,sel, input y);
  
endinterface
