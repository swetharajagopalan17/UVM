class slave_agent extends uvm_agent;
`uvm_component_utils(slave_agent)

oMonitor oMon;

uvm_analysis_port#(packet) ap;

function new (string name="slave_agent",uvm_component parent);
	super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Build Phase of %s",get_type_name()),UVM_LOW);
	
	ap=new("ap",this);
	
	oMon=oMonitor::type_id::create("oMon",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
`uvm_info(get_type_name(),$sformatf("Connect Phase of %s",get_type_name()),UVM_LOW);

        oMon.analysis_port.connect(ap);
endfunction 

endclass
