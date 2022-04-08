//There are 3 kinds of scoreboard implementations: in-order, out of order, customized 

//Customized scoreboard implementation
class scoreboard #(type T=packet) extends uvm_scoreboard;
typedef scoreboard#(T) scb_type;
`uvm_component_param_utils(scb_type)
//`uvm_component_param_utils(scoreboard#(T))

//The $typename system function returns a string 
//that represents the resolved type of its argument
const static string type_name = $sformatf("scoreboard#(%0s)",$typename(T));
//const static string type_name = "scoreboard#(packet)";

virtual function string get_type_name();
return type_name;
endfunction

`uvm_analysis_imp_decl(_inp)
`uvm_analysis_imp_decl(_outp)

uvm_analysis_imp_inp #(T,scb_type) mon_in;
uvm_analysis_imp_outp #(T,scb_type) mon_out;

T q_in [$];
bit [31:0] m_matches,mis_matches;

function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
	`uvm_info(get_type_name(),"NEW scoreboard",UVM_NONE);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
mon_in=new("mon_in",this);
mon_out=new("mon_out",this);
endfunction

virtual function void write_inp(T pkt);
T pkt_in;
$cast(pkt_in,pkt.clone());
q_in.push_back(pkt_in);
endfunction

virtual function void write_outp(T pkt);
T ref_pkt;

ref_pkt=q_in.pop_front();
  if(ref_pkt.compare(pkt)) begin
  m_matches++;
  `uvm_info("SCB","Packet matched ",UVM_HIGH);
  end
  else begin
    mis_matches++;
    `uvm_error("SCB",$sformatf("Packet mis_matched expected=%0s received=%0s",ref_pkt.convert2string(),pkt.convert2string()));
end
endfunction

virtual function void extract_phase(uvm_phase phase);
uvm_config_db#(int)::set(null,"uvm_test_top.env","matches",m_matches);
uvm_config_db#(int)::set(null,"uvm_test_top.env","mis_matches",mis_matches);
endfunction

function void report_phase(uvm_phase phase);
    `uvm_info("SCB",$sformatf("Scoreboard completed with matches=%0d mismatches=%0d ",m_matches,mis_matches),UVM_MEDIUM);
endfunction

endclass


/*
//-------------In Order Class-----------------
class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)

uvm_analysis_port #(packet) mon_in;
uvm_analysis_port #(packet) mon_out;
uvm_in_order_class_comparator #(packet) m_comp;

function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
m_comp=uvm_in_order_class_comparator#(packet)::type_id::create("m_comp",this);
mon_in=new("mon_in",this);
mon_out=new("mon_out",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
mon_in.connect(m_comp.before_export);
mon_out.connect(m_comp.after_export);
endfunction

function void report_phase(uvm_phase phase);
    `uvm_info("SCB",$sformatf("Scoreboard completed with matches=%0d mismatches=%0d ",m_comp.m_matches,m_comp.m_mismatches),UVM_MEDIUM);
endfunction

virtual function void extract_phase(uvm_phase phase);
uvm_config_db#(int)::set(null,"uvm_test_top.env","matches",m_comp.m_matches);
uvm_config_db#(int)::set(null,"uvm_test_top.env","mis_matches",m_comp.m_mismatches);
endfunction


endclass
*/
