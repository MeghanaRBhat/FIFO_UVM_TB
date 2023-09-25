VLOG =  /tools/mentor/questasim/questasim/bin/vlog

VSIM = /tools/mentor/questasim/questasim/bin/vsim

all: comp_rtl comp run

comp_rtl:
		$(VLOG) +cover=bcstfex /home/meghanabhat/Desktop/fifo/FIFO_UVM/my_fifo.sv

comp: 
	$(VLOG) +incdir+//home/meghanabhat/Desktop/fifo/FIFO_UVM/uvm-1.1d/src/uvm_pkg.sv +define+UVM_NO_DPI /home/meghanabhat/Desktop/fifo/FIFO_UVM/fifo_interface.sv /home/meghanabhat/Desktop/fifo/FIFO_UVM/fifo_top.sv

run: 
		$(VSIM)   -coverage  -novopt fifo_top +UVM_TESTNAME=fifo_test -l vsim.log -c
		     ##  add wave -r 
report: -vcover report -details top_coverage.ucdb 

