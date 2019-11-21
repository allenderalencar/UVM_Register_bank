typedef virtual interface_if interface_vif;

class driver_in extends uvm_driver #(transaction_in);
    `uvm_component_utils(driver_in)
    interface_vif vif;
    event begin_record, end_record;
    transaction_in tr;

    function new(string name = "driver_in", uvm_component parent = null);
        super.new(name, parent);
    endfunction
//===================================================================
//BUILD PHASE
//===================================================================
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
    endfunction
//===================================================================
//RUN PHASE
//===================================================================
    task run_phase (uvm_phase phase);
        fork
            reset_signals();
            get_and_drive(phase);
        join
    endtask
//===================================================================
//SINAIS NO RESET
//===================================================================
    virtual task reset_signals();
        wait (vif.rst === 0);
        forever begin
            vif.A          <= '0;
            vif.data_in    <= '0;
            vif.addr​       <= '0;
            vif.reg_sel​    <= '0;
            vif.instru     <= '0;
            vif.valid_ula  <= '0;
            vif.valid_reg  <= '0;
            @(negedge vif.rst);
        end
    endtask : reset_signals
//===================================================================
//GET & DRIVE
//===================================================================
    virtual task get_and_drive(uvm_phase phase);
        wait (vif.rst === 0);
        @(posedge vif.rst);
        forever begin
            seq_item_port.get_next_item(tr);
            driver_transfer(tr);
            seq_item_port.item_done();
        end
    endtask : get_and_drive
//===================================================================
//TRANSFERÊNCIA NO DRIVER
//===================================================================
    virtual task driver_transfer(transaction_in tr);
        @(posedge vif.clk);
        $display("",);
        vif.A         <= tr.data;
        vif.valid_ula <= '1;

        //////////////////////////////
        ///continuar isso aqui taok///
        //////////////////////////////

        @(posedge vif.busy_o);
    endtask : driver_transfer

endclass
