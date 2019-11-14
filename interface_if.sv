interface interface_in(input clk_ula, rst);

	logic   valid_ula;
  	logic   valid_reg;
	logic   [15:0] A​;
  	logic   [15:0] data_in​;
 	logic   [1:0]  addr​;
  	logic   [1:0]  reg_sel​;
  	logic   [1:0]  instru​;
	logic   [31:0] data_out;
	logic          valid_out;

	modport mst(input clk_ula, rst, output A, data_in​, addr​, reg_sel​, instru​, input valid_out, data_out);
	modport slv(input clk_ula, rst, A, data_in​, addr​, reg_sel​, instru, output​ valid_out, data_out);
		
endinterface
