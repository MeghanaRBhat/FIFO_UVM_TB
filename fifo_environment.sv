//`include "fifo_agent.sv"
//`include "fifo_scoreboard.sv"

class fifo_environment extends uvm_env;
fifo_agent agt;
fifo_scoreboard score;

`uvm_component_utils(fifo_environment)

function new(string name = "fifo_environment", uvm_component parent);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  agt= fifo_agent::type_id::create("agt", this);
  score = fifo_scoreboard::type_id::create("score", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
  agt.mon.item.connect(score.item_export);
 endfunction

endclass
