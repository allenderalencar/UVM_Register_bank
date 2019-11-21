class bank_sequence extends uvm_sequence #(transaction_in);
    `uvm_object_param_utils(bank_sequence)

     typedef transaction_in transaction_type;

    function new(string name="");
        super.new(name);
    endfunction: new

    task body;
        transaction_in tr;
        forever begin
            tr = transaction_type::type_id::create("tr");
            start_item(tr);
            	assert(tr.randomize());
            finish_item(tr);
        end
    endtask: body
endclass: sequence
