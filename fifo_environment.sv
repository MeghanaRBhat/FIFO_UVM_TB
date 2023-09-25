//`include "fifo_coverage.sv"

class fifo_environment extends uvm_env;
fifo_agent agt;
fifo_coverage cov;
fifo_scoreboard score;

`uvm_component_utils(fifo_environment)

function new(string name= "fifo_environment",uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  agt= fifo_agent::type_id::create("agt", this);
  cov = fifo_coverage::type_id::create("cov",this);
  score = fifo_scoreboard::type_id::create("score", this);
endfunction

function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
  agt.mon.item_got_port.connect(score.item_export);
  agt.mon.item_got_port.connect(cov.analysis_export);
//  agt.dri.item_port.connect(score.item_export);
endfunction

endclass
