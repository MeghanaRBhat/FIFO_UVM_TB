//`include "sequence_item.sv"
//`include "my_sequence.sv"
//`include "sequencer.sv"
//`include "fifo_driver.sv"
//`include "fifo_monitor.sv"
//`include "fifo_test.sv"

class fifo_agent extends uvm_agent;
sequencer seqr;
fifo_driver dri;
fifo_monitor mon;

`uvm_component_utils(fifo_agent)

function new(string name = "fifo_agent", uvm_component parent);
 super.new(name, parent);
 endfunction

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(get_is_active() == UVM_ACTIVE) begin
      seqr = sequencer::type_id::create("seqr", this);
      dri = fifo_driver::type_id::create("dri", this);
    end
      mon = fifo_monitor::type_id::create("mon", this);
  endfunction

virtual function void connect_phase(uvm_phase phase);
  if(get_is_active() == UVM_ACTIVE)
    dri.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass




