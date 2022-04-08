class test extends uvm_test;
`uvm_component_utils(test)


environment env;
base_sequence seq;

function new(string name="test",uvm_component phase);
	super.new(name,phase);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Build Phase of %s",get_type_name()),UVM_LOW);
	
	
	seq = base_sequence::type_id::create("seq_pkt",this);
	env = environment::type_id::create("env",this);
	
endfunction

virtual function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	print();
endfunction


virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
	`uvm_info(get_type_name(),$sformatf("-->RUN Phase of %s",get_type_name()),UVM_FULL);
	phase.phase_done.set_drain_time(this,20);
	
	seq.start(env.m_agent.seqr);
	//#20;
phase.drop_objection(this);
	endtask

endclass
