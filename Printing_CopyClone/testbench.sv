// Code your testbench here
// or browse Examples
program test;
  
  packet pkt1,pkt2,pkt3;
  
  initial begin
    pkt1=packet::type_id::create("pkt_1");
    pkt1.randomize();
    pkt1.print();
    //$display(pkt1.convert2string());
   // `uvm_info("pkt_1_info",pkt1.convert2string(),UVM_MEDIUM)
   // `uvm_info("Pkt_1_sprint",pkt1.sprint(),UVM_MEDIUM)
    
    /*
    Printing methods: 
    print cannot be used inside uvm_info so we need sprintf
    both print and sprintf print info in a bulky format so c2s is better
    c2s needs to be overridden inside your class to be called inside test program
    */
    
    pkt2=packet::type_id::create("pkt_2");
    pkt2.copy(pkt1);
    pkt2.print();
    
    if(pkt1.compare(pkt2)) begin
      `uvm_info("Compare","Transaction Matched.....",UVM_MEDIUM)
    end
    else begin
      `uvm_info("Mis_Match","Transaction Mis_Matched.....",UVM_MEDIUM)
    end
    
    
    $cast(pkt3,pkt1.clone());
   // pkt3.print();
    `uvm_info("Pkt_3_sprint",pkt3.sprint(),UVM_MEDIUM)
    
  end
  
endprogram


// class uvm_sequence_item exteds uvm_object
// class packet extends uvm_sequence_item

//Copying vs cloning: 
//Hierarchy --> uvm_object --> uvm_sequence_item --> packet 
//clone needs casting because clone returns type uvm_object and we're assigning the object to the packet handle so that'll cause issues at compile time 
//copy - does not copy name but clone copies obj name as well
//both clone and copy create objects at diff locations so their mem addr will be diff
