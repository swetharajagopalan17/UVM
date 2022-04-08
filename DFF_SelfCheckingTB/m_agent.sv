class master_agent extends uvm_agent;
`uvm_component_utils(master_agent)

sequencer 	seqr;
driver		drv;
iMonitor	iMon;

uvm_analysis_port#(packet) ap;

function new(string name="master_agent", uvm_component parent);
	super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Build Phase of %s",get_type_name()),UVM_LOW);
	ap=new("ap",this);
//if(is_active==UVM_ACTIVE) begin
	seqr=sequencer::type_id::create("seqr",this);
	drv=driver::type_id::create("drv",this);
//end
	iMon=iMonitor::type_id::create("iMon",this);
endfunction 

virtual function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Connect Phase of %s",get_type_name()),UVM_LOW);
//	if(is_active==UVM_ACTIVE) begin
	drv.seq_item_port.connect(seqr.seq_item_export);
//end
        iMon.analysis_port.connect(ap);
endfunction 

endclass
