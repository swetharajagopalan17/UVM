// Code your design here

module dut(clk,inp,outp);
  
  input clk;
  input [7:0] inp;
  output reg [7:0] outp;
  
  always@(posedge clk) begin
      outp <= inp;
  end
  
endmodule
