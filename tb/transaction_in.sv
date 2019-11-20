class transaction_in extends uvm_sequence_item;

  rand bit   [15:0] A​;
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
  `uvm_object_param_utils_begin(transaction_in)
  `uvm_field_int(A​, UVM_UNSIGNED)
  `uvm_field_int(data_in​, UVM_UNSIGNED)
  `uvm_field_int(addr​, UVM_UNSIGNED)
  `uvm_field_int(reg_sel​, UVM_UNSIGNED)
  `uvm_field_int(instru, UVM_UNSIGNED)
  `uvm_object_utils_end
//===================================================================
//PRINT
//===================================================================
  function string convert2string();
    return $sformatf("{A = %d},
      {data_in​ = %d},
      {addr = %d},
      {reg_sel​ = %d},
      {instru = %d}", A, data_in​, addr, reg_sel​, instru);
  endfunction

endclass