// Program block

program mux_program(mux_if.tb vif);
  
  bit y_exp;
  int matched,mis_matched;
  
  initial begin
    vif.i0 <= 0;
    vif.i1 <= 1;
    vif.sel <= 0;
    
    y_exp = mux_dpi_model(0,1,0);
    #1;
    $display("[DUT] Output y=%0b",vif.y);
    $display("[C-Model] Output y=%0b",y_exp);
    #1;
    
    for(int i=0;i<8;i++) begin
      {vif.i0,vif.i1,vif.sel} = i;
      y_exp = mux_dpi_model(vif.i0,vif.i1,vif.sel);
      #1;
      if(y_exp == vif.y) begin
        matched++;
      end
      else begin
        mis_matched++;
      end
    end
    
    #1;
    $display("Matched =%0d Mis_matched=%0d",matched,mis_matched);
  end
  
endprogram
