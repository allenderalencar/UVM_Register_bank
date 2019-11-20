class transaction_out extends uvm_sequence_item;

	rand logic unsigned [31:0] data_out; //o exemplo tinha o rand
	rand logic unsigned        valid_out;
//===================================================================
//FACTORY
//===================================================================
	`uvm_object_utils_begin(transaction_out)
		`uvm_field_int(data_out, UVM_ALL_ON|UVM_HEX)
		`uvm_field_int(valid_out, UVM_ALL_ON|UVM_HEX)
	`uvm_object_utils_end


	function new(string name = "transaction_out");
		super.new(name);	
	endfunction : new

	function string convert2string();
		return $sformatf("{data_out = %h}, {valid_out = %h}"

				,data_out, valid_out);
	endfunction

	function void do_copy(uvm_object rhs);
        transaction_out rhs_;

        if(!$cast(rhs_, rhs)) begin
          `uvm_fatal("do_copy", "cast of rhs object failed")
        end
        super.do_copy(rhs);
        data_out = rhs_.data_out;
    endfunction : do_copy

endclass : transaction_out
