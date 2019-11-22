class env extends uvm_env;
	`uvm_component_utils(env)

	agent_in   agt_in;
	agent_out  agt_out;

	scoreboard sb;

	cov        cobertura;

	function new(string name, uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
//===================================================================
//BUILD PHASE
//===================================================================
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agt_in   = agent_in::type_id::create("agt_in", this);
		agt_out  = agent_out::type_id::create("agt_out", this);

		sb = scoreboard::type_id::create("sb", this);
		
		cobertura  = cov::type_id::create("cobertura", this);
	endfunction : build_phase
//===================================================================
//CONNECT PHASE
//===================================================================
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
			agt_in.agt_i_tr_analysis_port.connect(sb.to_rfm_analysis_port);
			agt_out.agt_o_tr_analysis_port.connect(cobertura.resp_port);
			agt_out.agt_o_tr_analysis_port.connect(sb.to_comp_analysis_port);
	endfunction : connect_phase
//===================================================================
//ELABORATION END
//===================================================================
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
	endfunction : end_of_elaboration_phase

endclass 
