class test extends uvm_test;
  env env;
  sequence seq;

//===================================================================
//FACTORY
//===================================================================
  `uvm_component_utils(test)


  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
//===================================================================
//BUILD PHASE
//===================================================================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = env::type_id::create("env", this);
    seq = sequence::type_id::create("seq", this);
  endfunction
//===================================================================
//RUN PHASE
//===================================================================
  task run_phase(uvm_phase phase);
    fork
      seq.start(env.agent_in.sequencer);
    join
  endtask: run_phase

endclass : test