IFS = ./tb/interface_if.sv 


PKGS = ./tb/bank_pkg.sv

RTL = ./rtl/datapath.sv \
./rtl/ula.sv \
./rtl/rb.sv \
./rtl/mux.sv 

RUN_ARGS_COMMON = -access +r -input ./shm.tcl \
     	          +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

sim: clean
	g++ -g -fPIC -Wall -std=c++0x ./tb/refmod.cpp -shared -o ./tb/test.so
	xrun -64bit -uvm $(PKGS) $(IFS) $(RTL) ./tb/top.sv -sv_lib ./tb/test.so \
		+UVM_TESTNAME=test -covtest test $(RUN_ARGS_COMMON)

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ simvision* xcelium.d simv.daidir *.so *.o *.err

view_waves:
	simvision waves.shm &
