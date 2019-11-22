class transaction_in extends uvm_sequence_item;

  rand bit   [15:0] dt_A​;
  rand bit   [15:0] data_in​;
  rand bit   [1:0]  addr​;
  rand bit   [1:0]  reg_sel​;
  rand bit   [1:0]  instru​;

  function new(string name = "");
    super.new(name);
  endfunction
//===================================================================
//FACTORY
//===================================================================
  `uvm_object_utils_begin(transaction_in)
  `uvm_field_int(dt_A​, UVM_ALL_ON|UVM_HEX)
  `uvm_field_int(data_in​, UVM_ALL_ON|UVM_HEX)
  `uvm_field_int(addr​, UVM_ALL_ON|UVM_HEX)
  `uvm_field_int(reg_sel​, UVM_ALL_ON|UVM_HEX)
  `uvm_field_int(instru, UVM_ALL_ON|UVM_HEX)
  `uvm_object_utils_end
//===================================================================
//PRINT
//===================================================================
  function string convert2string();
    return $sformatf("{A = %h}, {data_in​ = %h}, {addr = %h}, {reg_sel​ = %h}, {instru = %h}", dt_A, data_in​, addr, reg_sel​, instru);
  endfunction

endclass
