import "DPI-C" context function int logica_ula(int A, int B, int instru);

class Refmod_ULA extends uvm_component;
  `uvm_component_utils(Refmod_ULA)

  typedef transaction_in tr_type_in;
  typedef transaction_out tr_type_out;

  tr_type_in tr_in;
  tr_type_out tr_out;

  //Banco de registradores
  logic [0:15] registradores [0:3];

  logic [0:15] B;

  uvm_analysis_imp #(tr_type_in, Refmod_ULA) refmod_ula_i_tr_analysis_imp;
  uvm_analysis_port #(tr_type_out) refmod_ula_o_tr_analysis_port;
  
  event begin_record, end_record, begin_refmodtask;
  
//======================= Construtor (Constrói as portas) ==================================
  function new(string name = "Refmod_ULA", uvm_component parent);
    super.new(name, parent);
    refmod_ula_i_tr_analysis_imp = new("refmod_ula_i_tr_analysis_imp", this);
    refmod_ula_o_tr_analysis_port = new("refmod_ula_o_tr_analysis_port", this);
  endfunction

//====================== Build Phase (Constrói o bloco) ====================================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

//======================= Run Phase (Inicia as tasks) ======================================
  virtual task run_phase(uvm_phase phase);
    
    super.run_phase(phase);

  endtask: run_phase

//============ Função para copiar transações do agent ======================
//=======É onde as variáveis da transação são passadas para o refmod=======
  virtual function write ( tr_type_in t);
    tr_in = tr_type_in::type_id::create("tr_in", this);
    tr_in.copy(t);
    tr_out = tr_type_out::type_id::create("tr_out", this);

    registradores[tr_in.addr] = tr_in.data_in​; //Escrita dos registradores
    B = registradores[tr_in.reg_sel​]; //Seleção do regsitrador usado na ULA
    
    $display("A​ : %h data_in​ : %h addr​ : %h reg_sel​ : %h instru​ : %h ", tr_in.A​, tr_in.data_in​, tr_in.addr​, tr_in.reg_sel​, tr_in.instru​); //Mostra os dados durante a execução
        
    begin_tr(tr_out, "rfm"); //waveform da tr_out
    tr_out.data_out_o = logica_ula(tr_in.A, B, tr_in.instru);
    end_tr(tr_out);
    
    $display("data_out : %h", tr_out.data_out_o);

    refmod_ula_o_tr_analysis_port.write(tr_out);

  endfunction

