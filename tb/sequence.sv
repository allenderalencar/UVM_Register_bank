class sequence extends uvm_sequence #(transaction_in);
    `uvm_object_utils(sequence)

    function new(string name="sequence");
        super.new(name);
    endfunction: new

    task body;
        transaction_in tr;
        forever begin
            tr = tr_ansaction_in::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize());
            finish_item(tr);
        end
    endtask: body
endclass: sequence
