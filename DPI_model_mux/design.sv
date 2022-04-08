// Code your design here
module mux(
  input i0,i1,sel,
  output reg y
);
  
  always@(i0,i1,sel) begin
    if(sel) y = i1;
    else
      y = i0;
  end
  
endmodule
