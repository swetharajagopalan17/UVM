// Test Class
class environment extends uvm_env;
  
  `uvm_component_utils(environment);
  
  //environment environment_h;
  
  function new(string name="environment", uvm_component p);
    super.new(name, p);
    `uvm_info(get_type_name(),$sformatf("Constructor of %s",name),UVM_LOW);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),$sformatf("..........Build Phase of %s [started]........",get_type_name()),UVM_LOW);
    
    //environment_h = environment::type_id::create("environment_h",this);
  //  `uvm_info(get_type_name(),$sformatf("Build Phase after %m"),UVM_LOW);
    
          `uvm_info(get_type_name(),$sformatf("..........Build Phase of %s [ENDED]........",get_type_name()),UVM_LOW);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Connect Phase of %s",get_type_name()),UVM_LOW);
  endfunction
  
   	function void end_of_elaboration_phase(uvm_phase phase);
    	
      `uvm_info(get_type_name(),$sformatf("End of Elaboration phase of %s",get_type_name()),UVM_LOW);
      
  	endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
    
    `uvm_info(get_type_name(),$sformatf("Start of simulation phase of %s",get_type_name()),UVM_LOW);
  endfunction
  
  
  function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Extract phase of %s",get_type_name()),UVM_LOW);
    endfunction
	
  function void check_phase(uvm_phase phase);
		super.check_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Check phase of %s",get_type_name()),UVM_LOW);
	endfunction
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
      `uvm_info(get_type_name(),$sformatf("Report phase of %s",get_type_name()),UVM_LOW);
	endfunction
	
	function void final_phase(uvm_phase phase);
		super.final_phase(phase);
      `uvm_info(get_type_name(),$sformatf("Final phase of %s",get_type_name()),UVM_LOW);
	endfunction
  
  
endclass
