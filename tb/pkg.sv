package exemplo_soma_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::*;

`include "./transaction_in.sv"
`include "./transaction_out.sv"
`include "./sequence_in.sv"

`include "./driver_in.sv"
`include "./driver_out.sv"
`include "./monitor_in.sv"
`include "./monitor_out.sv"
`include "./agent_in.sv"
`include "./agent_out.sv"

`include "./refmod.sv"
`include "./cov.sv"
`include "./scoreboard.sv"
`include "./env.sv"
`include "./test.sv" //SE LIGUE SA SEQUÊNCIA QUE SÃO COLOCADOS !!!!!!!!! 
								  //SE ALGUEM CHAMA ALGO, ESSE ALGO DEVE ESTAR ACIMA DESSE ALGUEM !!!!!!

endpackage : exemplo_soma_pkg