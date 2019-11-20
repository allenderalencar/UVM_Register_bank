class monitor_out extends uvm_monitor;
	
	transaction_out tr;
	interface_vif vif;
	
	event begin_record, end_record;
	
	uvm_analysis_port #(transaction_out) mon_out_tr_analysis_port; 
	
	// NomeDoModulo_NomeDaTransacao_tr_NomeDaPorta
//===================================================================
//FACTORY
//===================================================================
	`uvm_component_utils(monitor_out)

	function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_out_tr_analysis_port = new("mon_out_tr_analysis_port", this);
    endfunction
//===================================================================
//BUILD PHASE
//===================================================================
    virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		assert (uvm_config_db#(interface_vif)::get(this, "", "vif", vif))
			else `uvm_fatal("NO_VIF", "monitor_out: falha no get da interface_vif");

		tr = transaction_out::type_id::create("tr",this);	
	endfunction : build_phase
//===================================================================
//RUN PHASE
//===================================================================
	virtual task run_phase(uvm_phase phase);
		super.run_phase (phase);
		fork
			monitoramento();
			record_tr();
		join
	endtask : run_phase
//===================================================================
//MONITORAMENTO
//===================================================================
	virtual task monitoramento();
		forever
		begin
			@(posedge vif.clk iff((vif.valid_o == 1'b1) && (vif.ready_o == 1'b1)));
			->begin_record;
			tr.data_out_o = vif.data_out_o;
			->end_record;
			mon_out_tr_analysis_port.write(tr);
		end
	endtask : monitoramento
//===================================================================
//RECORD
//===================================================================
	virtual task record_tr();
		forever 
		begin 	
			@begin_record;
			begin_tr(tr, "monitor_out: tr");
			@end_record;
			end_tr(tr);
		end
	endtask : record_tr
	
endclass : monitor_out
