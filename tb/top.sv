module top;

	`include "uvm_macros.svh"
	import 		uvm_pkg::*;
	import 		bank_pkg::*;
	parameter 	min_trans = 100;

	logic clk;
	logic rst;
	interface_if dut_if (.clk(clk), .rst(rst));

	datapath dut (
		.clk_ula(dut_if.clk),
		.clk_reg(dut_if.clk),
		.rst(dut_if.rst),

		.valid_reg(dut_if.valid_reg),
		.addr(dut_if.addr),
		.data_in(dut_if.data_in),

		.reg_sel(dut_if.reg_sel),

		.valid_ula(dut_if.valid_ula),
		.instru(dut_if.instru),
		.A(dut_if.A),
		.data_out(dut_if.data_out),
		.valid_out(dut_if.valid_out)
	);

	initial begin
		clk = 0;
		rst = 1;
		#10 rst = 0;
		#10 rst = 1;
	end

	always #3 clk = ~clk;

	initial begin
		`ifdef XCELIUM
			$recordvars();
		`endif
		`ifdef VCS
			$vcdpluson;
		`endif
		`ifdef QUESTA
			$wlfdumpvars();
			set_config_int("*", "recording_detail", 1);
		`endif

		uvm_config_db#(interface_vif)::set(uvm_root::get(), "*", "vif", dut_if);
		uvm_config_db#(int)::set(uvm_root::get(), "*", "min_trans", min_trans);

		run_test("test");
	end

endmodule
