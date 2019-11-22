

class sequence_in extends uvm_sequence #(transaction_in);

	`uvm_object_utils(sequence_in)

	static real transaction_id;

	function new (string name = "sequence_in");
			super.new(name);
	endfunction : new


	task body;
		transaction_in tr_in;

		forever begin 
			tr_in = transaction_in::type_id::create("tr_in");
			start_item(tr_in);
			assert(tr_in.randomize());
			transaction_id++;
			finish_item(tr_in);
		end 
	endtask : body
endclass : sequence_in



