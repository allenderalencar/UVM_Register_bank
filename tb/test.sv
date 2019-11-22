class test extends uvm_test;
  env envir;
  sequence_in seq;

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
    envir = env::type_id::create("envir", this);
    seq = sequence_in::type_id::create("seq", this);
  endfunction
//===================================================================
//RUN PHASE
//===================================================================
  task run_phase(uvm_phase phase);
    seq.start(envir.agt_in.sqr);
  endtask: run_phase
endclass
