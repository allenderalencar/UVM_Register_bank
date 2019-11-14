class exemplo_soma_agent_o extends uvm_agent;
	`uvm_component_param_utils(agent_out)

	typedef transaction_out transaction_type;
	typedef monitor_out monitor_type;

	uvm_analysis_port#(transaction_type) agt_out_tr_analysis_port;
 
	monitor_type monitor;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		agt_out_tr_analysis_port = new("agt_out_tr_analysis_port", this);

		monitor = monitor_type::type_id::create("monitor", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		monitor.mon_out_tr_analysis_port.connect(agt_out_tr_analysis_port);
	endfunction

endclass
