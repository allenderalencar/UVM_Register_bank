class env extends uvm_env;
	`uvm_component_utils(env)

	agent_in   agent_in;
	agent_out  agent_out;

	scoreboard scoreboard;

	cov        cobertura;

	function new(string name, uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
//===================================================================
//BUILD PHASE
//===================================================================
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_in   = agent_in::type_id::create("agent_in", this);
		agent_out  = agent_out::type_id::create("agent_out", this);

		scoreboard = scoreboard::type_id::create("scoreboard", this);
		
		cobertura  = cov::type_id::create("cobertura", this);
	endfunction : build_phase
//===================================================================
//CONNECT PHASE
//===================================================================
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
			agent_in.agt_i_tr_analysis_port.connect(scoreboard.to_rfm_analysis_port);
			agent_out.agt_o_tr_analysis_port.connect(cobertura.resp_port);
			agent_out.agt_o_tr_analysis_port.connect(scoreboard.to_comp_analysis_port);
	endfunction : connect_phase
//===================================================================
//ELABORATION END
//===================================================================
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
	endfunction : end_of_elaboration_phase

endclass : environment
