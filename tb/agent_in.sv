class agent_in extends uvm_agent;

    typedef uvm_sequencer#(transaction_in) sequencer;
    sequencer   sqr;
    driver_in   drv;
    monitor_in  mon;

    uvm_analysis_port #(transaction_in) agt_i_tr_analysis_port;
//===================================================================
//FACTORY
//===================================================================
    `uvm_component_utils(agent_in)

    function new(string name = "agent_in", uvm_component parent = null);
        super.new(name, parent);
        agt_i_tr_analysis_port = new("agt_i_tr_analysis_port", this);
    endfunction
//===================================================================
//BUILD PHASE
//===================================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon = monitor_in::type_id::create("mon", this);
        sqr = sequencer::type_id::create("sqr", this);
        drv = driver_in::type_id::create("drv", this);

    endfunction
//===================================================================
//CONNECT PHASE
//===================================================================
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.agt_i_tr_analysis_port.connect(agt_i_tr_analysis_port);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction

endclass: agent_in