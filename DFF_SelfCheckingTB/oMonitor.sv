class oMonitor extends uvm_monitor;
`uvm_component_utils(oMonitor)

virtual simple_if.tb_oMon vif;
// This TLM port is used to connect the monitor to the scoreboard
uvm_analysis_port #(packet) analysis_port;

packet pkt;
bit [15:0] pkt_id;

function new(string name="oMonitor", uvm_component parent);
	super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Build Phase of %s",get_type_name()),UVM_LOW);
	if (!uvm_config_db#(virtual simple_if.tb_oMon)::get(this, "", "oMon_if", vif)) begin
   `uvm_fatal("CFGERR", "oMonitor DUT interface not set");
end
//create TLM port
    analysis_port=new("analysis_port",this);
endfunction

// The job of the monitor is to passively monitor the physical signals,
// interprete and report the activities that it sees.  In this case, to
// re-construct the packet that it sees on the DUT's input port as specified

virtual task run_phase(uvm_phase phase);
	`uvm_info(get_type_name(),$sformatf("-->RUN Phase of %s",get_type_name()),UVM_FULL);
	forever begin 
		@(vif.cb_oMon.outp);
		pkt = packet::type_id::create("oMon_pkt",this);
		pkt.inp = vif.cb_oMon.outp;
		pkt_id++;
		`uvm_info(get_type_name(),$sformatf(" Data pkt %0d received outp = %0d",pkt_id,pkt.inp),UVM_MEDIUM)
		analysis_port.write(pkt);
	end 
	endtask


endclass
