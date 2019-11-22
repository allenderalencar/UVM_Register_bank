class agent_out extends uvm_agent;
	`uvm_component_param_utils(agent_out)

	typedef transaction_out transaction_type;
	typedef monitor_out monitor_type;
//===================================================================
//FACTORY
//===================================================================
	uvm_analysis_port#(transaction_type) agt_o_tr_analysis_port;
 //===================================================================
//INSTANCIAÇÃO DO MONITOR_OUT
//===================================================================
	monitor_type monitor;


	function new(string name, uvm_component parent);
		super.new(name, parent);
		agt_o_tr_analysis_port = new("agt_o_tr_analysis_port", this);
	endfunction
//===================================================================
//BUILD PHASE
//===================================================================
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);


		monitor = monitor_type::type_id::create("monitor", this);
	endfunction
//===================================================================
//CONNECT PHASE
//===================================================================
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		monitor.mon_out_tr_analysis_port.connect(agt_o_tr_analysis_port);
	endfunction

endclass
