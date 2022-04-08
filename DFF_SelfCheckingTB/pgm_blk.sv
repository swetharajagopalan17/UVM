// Program block

program pgm_blk_test(simple_if pif);
  
  import uvm_pkg::*;
  
 
  initial begin
    uvm_config_db#(virtual simple_if.tb)::set(null,"*","drvr_if",pif.tb);
uvm_config_db#(virtual simple_if.tb_iMon)::set(null,"*","iMon_if",pif.tb_iMon);
uvm_config_db#(virtual simple_if.tb_oMon)::set(null,"*","oMon_if",pif.tb_oMon);

run_test();

  end
  

endprogram
