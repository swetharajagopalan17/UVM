class driver extends uvm_driver#(packet);
	`uvm_component_utils(driver)
	
	virtual simple_if.tb vif;
	bit [31:0] pkt_id;
	
	function new(string name="driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(),$sformatf("Build Phase of %s",get_type_name()),UVM_LOW);
		uvm_config_db#(virtual simple_if.tb)::get(this,"","drvr_if",vif);
assert(vif != null) else 
    `uvm_fatal(get_type_name(),"Virtual interface in driver is NULL ");
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	`uvm_info(get_type_name(),$sformatf("-->RUN Phase of %s",get_type_name()),UVM_FULL);
	forever begin
		seq_item_port.get_next_item(req);
		pkt_id++;
		`uvm_info(get_type_name(),$sformatf(" Received Transaction %0d from TLM inp = %0d",pkt_id,req.inp),UVM_MEDIUM)
		//req.print();
		`uvm_info("Drv",$sformatf("%0s",req.sprint()),UVM_FULL);
		@(vif.cb);
		vif.cb.inp <= req.inp;
		
		seq_item_port.item_done();
	end
	endtask
	
endclass
