class scoreboard extends uvm_scoreboard;

  typedef transaction_in tr_i;
  typedef transaction_out tr_o;
  typedef uvm_in_order_class_comparator #(tr_o) comp_type;
  refmod Refmod;
  comp_type Comparator;

  uvm_analysis_port #(tr_o) to_comp_analysis_port;
  uvm_analysis_port #(tr_i) to_rfm_analysis_port;

  `uvm_component_utils(scoreboard)

  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    to_comp_analysis_port = new("to_comp_analysis_port", this);
    to_rfm_analysis_port = new("to_rfm_analysis_port", this);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    Refmod = refmod::type_id::create("Refmod", this);
    Comparator = comp_type::type_id::create("Comparator", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    to_rfm_analysis_port.connect(Refmod.refmod_ula_i_tr_analysis_imp);
    to_comp_analysis_port.connect(Comparator.before_export);
    Refmod.refmod_ula_o_tr_analysis_port.connect(Comparator.after_export);
  endfunction
endclass 
