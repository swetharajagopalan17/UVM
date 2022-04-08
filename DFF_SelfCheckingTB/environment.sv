class environment extends uvm_env;
`uvm_component_utils(environment)

real tot_cov_score;
bit [31:0] m_matches,mis_matches;

master_agent m_agent;
slave_agent	 s_agent;
//scoreboard	 scb;	
scoreboard #(packet)	scb; // For customized scoreboard	
coverage cov_comp;

function new(string name="environment",uvm_component parent=null);
	super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Build Phase of %s",get_type_name()),UVM_LOW);
	m_agent=master_agent::type_id::create("m_agent",this);
	
	s_agent=slave_agent::type_id::create("s_agent",this);
	
	//scb = scoreboard::type_id::create("scb",this);
	scb = scoreboard#(packet)::type_id::create("scb",this);
	
	cov_comp=coverage::type_id::create("cov_comp",this);
endfunction 

virtual function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Connect Phase of %s",get_type_name()),UVM_LOW);
	m_agent.ap.connect(scb.mon_in);
	s_agent.ap.connect(scb.mon_out);
	m_agent.ap.connect(cov_comp.analysis_export);
endfunction

function void extract_phase(uvm_phase phase);

uvm_config_db#(real)::get(this,"","cov_score",tot_cov_score);    
uvm_config_db#(int)::get(this,"","matches",m_matches);    
uvm_config_db#(int)::get(this,"","mis_matches",mis_matches);    
endfunction

function void report_phase(uvm_phase phase);

if(mis_matches != 0) begin
  `uvm_info("","******************************************",UVM_NONE);
  `uvm_info("FAIL","Test Failed due to mis_matched packets in scoreboard",UVM_NONE); 
  `uvm_info("FAIL",$sformatf("matched_pkt_count=%0d mis_matched_pkt_count=%0d ",m_matches,mis_matches),UVM_NONE); 
  `uvm_fatal("FAIL","******************Test FAILED ***************");
end
else begin
  `uvm_info("PASS","******************Test PASSED ***************",UVM_NONE);
 
  `uvm_info("PASS",$sformatf("matched_pkt_count=%0d mis_matched_pkt_count=%0d ",m_matches,mis_matches),UVM_NONE); 
  `uvm_info("PASS",$sformatf("Coverage=%0f%%",tot_cov_score),UVM_NONE); 
  `uvm_info("PASS","******************************************",UVM_NONE);
  end
endfunction


endclass 
