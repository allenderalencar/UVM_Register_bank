class transaction_out extends uvm_sequence_item;

	rand logic unsigned [31:0] data_out_o; //o exemplo tinha o rand
//===================================================================
//FACTORY
//===================================================================
	`uvm_object_utils_begin(transaction_out)
		`uvm_field_int(data_out_o, UVM_ALL_ON|UVM_HEX)
	`uvm_object_utils_end


	function new(string name = "transaction_out");
		super.new(name);	
	endfunction : new

	function string convert2string();
		return $sformatf("{data_out_o = %h}"

				,data_out_o);
	endfunction

endclass : transaction_out
