class base_sequence extends uvm_sequence#(packet);
`uvm_object_utils(base_sequence)

function new(string name="base_sequence");
	super.new(name);
endfunction

task body();
int unsigned pkt_id;
	req = packet::type_id::create("pkt");
	repeat(5) begin
		//`uvm_do(req);
		req.randomize();
		start_item(req);
		pkt_id++;
	//	req.print();
		`uvm_info("SEQ",$sformatf("%0s",req.sprint()),UVM_FULL);
		`uvm_info(get_type_name(),$sformatf(" Transaction %0d generated inp = %0d",pkt_id,req.inp),UVM_MEDIUM)
       //get_response(rsp);
	   finish_item(req);
	end 
endtask

endclass
