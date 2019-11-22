class monitor_in extends uvm_monitor;

    interface_vif  vif;
    transaction_in tr ;
    uvm_analysis_port #(transaction_in) agt_i_tr_analysis_port;
    `uvm_component_utils(monitor_in)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        agt_i_tr_analysis_port = new ("agt_i_tr_analysis_port", this);
    endfunction
// ===================================================================
// BUILD PHASE
// ===================================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")

            tr = transaction_in::type_id::create("tr", this);
        end
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
                        // tr.data_in = vif.data_in;
                        agt_i_tr_analysis_port.write(tr);
                        @(negedge vif.clk);
                        end_tr(tr);
                    end
            end
        end
    endtask
endclass