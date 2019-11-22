class monitor_in extends uvm_monitor;

    interface_vif  vif;
    transaction_in tr ;
    uvm_analysis_port #(transaction_in) agt_i_tr_analysis_port;
    `uvm_component_utils(monitor_in)

    event begin_record, end_record;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        agt_i_tr_analysis_port = new ("agt_i_tr_analysis_port", this);
    endfunction
// ===================================================================
// BUILD PHASE
// ===================================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        tr = transaction_in::type_id::create("tr", this);
    endfunction
// ===================================================================
// RUN PHASE
// ===================================================================
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        fork
            collect_transactions(phase);
        join
    endtask
// ===================================================================
// COLETAR TRANSAÇÕES
// ===================================================================
    virtual task collect_transactions(uvm_phase phase);
        wait (vif.rst === 0);
        @(posedge vif.rst);
        forever begin

            @(posedge vif.clk) begin
                if(!vif.valid_out)
                    begin
                        @(posedge vif.valid_out);
                        begin_tr(tr, "req");
                            tr.dt_A​ = vif.A​;
                            tr.data_in​ = vif.data_in​;
                            tr.addr​ = vif.addr​;
                            tr.reg_sel​ = vif.reg_sel​;
                            tr.instru​ = vif.instru​;
                        agt_i_tr_analysis_port.write(tr);
                        @(negedge vif.clk);
                        end_tr(tr);
                    end
            end
        end
    endtask/*
    virtual task  monitor_in::collect_transactions(uvm_phase phase);
    wait(!vif.rst );
        @(posedge vif.rst);

    forever begin :receive_data
        @(posedge vif.valid_ula  or posedge vif.valid_reg);

        -> begin_record;

         this.tr.dt_A = vif.A ;
         this.tr.reg_sel = vif.reg_sel ;
         this.tr.dt_in = vif.data_in ;
         this.tr.addr = vif.addr ;
         this.tr.instru = vif.instru;
     @(posedge vif.clk_reg or posedge vif.clk_ula);
         item_collected_port.write(tr_in);

         @(posedge vif.clk_reg or posedge vif.clk_ula);
            -> end_record;
    end:receive_data
    endtask : collect_transactions*/
endclass