import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fifo_interface.sv"
`include "sequence_item.sv"
`include "my_sequence.sv"
`include "sequencer.sv"
`include "fifo_driver.sv"
`include "fifo_monitor.sv"
`include "fifo_agent.sv"
`include "fifo_coverage.sv"
`include "fifo_scoreboard.sv"
`include "fifo_environment.sv"
`include "fifo_test.sv"
`include "my_fifo.sv"

  module fifo_top;
    bit clk;
    bit reset;
 
    always #5 clk = ~clk;
 
    initial begin
      clk = 1;
      reset= 0;
      #5;
     reset= 1;
    end
 
    fifo_interface vif(clk, reset);
 
  my_fifo dut(.clk(vif.clk),
                 .rstn(vif.reset),
                 .i_wrdata (vif. i_wrdata ),
                 .i_wren(vif.i_wren),
                 .i_rden(vif.i_rden),
                 .o_full(vif.o_full),
                 .o_empty(vif.o_empty),
                 .o_rddata(vif.o_rddata),.o_alm_full(vif.o_alm_full),
                  .o_alm_empty(vif.o_alm_empty));
 
   initial begin
     uvm_config_db#(virtual fifo_interface)::set(null, "", "vif", vif);
     
  

    $dumpfile("dump.vcd"); 
    $dumpvars;
   run_test("fifo_test");
  end

  endmodule
