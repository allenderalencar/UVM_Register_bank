package bank_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::*;

`include "./tb/transaction_in.sv"
`include "./tb/transaction_out.sv"
`include "./tb/sequence_in.sv"

`include "./tb/driver_in.sv"
`include "./tb/monitor_in.sv"
`include "./tb/monitor_out.sv"
`include "./tb/agent_in.sv"
`include "./tb/agent_out.sv"

`include "./tb/refmod.sv"
`include "./tb/cov.sv"
`include "./tb/scoreboard.sv"
`include "./tb/env.sv"
`include "./tb/test.sv" 
//Attetion, the sequence should be done with dependencies 
//To be refenrencied, it shoud be instantiated before

endpackage : bank_pkg

