//`include "sequence_item.sv"
//`include "fifo_interface.sv"
class fifo_driver extends uvm_driver #(sequence_item);

virtual fifo_interface vif;

sequence_item item_port;

`uvm_component_utils(fifo_driver)

function new(string name="fifo_driver",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif))
 `uvm_fatal("Driver: ", "No vif is found!")
endfunction

virtual task run_phase(uvm_phase phase);

vif.d_mp.d_cb.i_wren <= 0;
vif.d_mp.d_cb.i_rden<= 0;
vif.d_mp.d_cb.i_wrdata<= 0;

forever begin
seq_item_port.get_next_item(item_port);
if(item_port.i_wren==1)
write_seq(item_port.i_wrdata);
if(item_port.i_rden == 1)
read();
seq_item_port.item_done();
end
endtask

  virtual task write_seq(input [127:0]i_wrdata);
    @(posedge vif.d_mp.d_cb)
vif.d_mp.d_cb.i_wren <= 1;
vif.d_mp.d_cb.i_wrdata <= i_wrdata;
    @(posedge vif.d_mp.d_cb)
vif.d_mp.d_cb.i_wren <= 0;
endtask

  virtual task read();
    @(posedge vif.d_mp.d_cb)
vif.d_mp.d_cb.i_rden <= 1;
    @(posedge vif.d_mp.d_cb)
    vif.d_mp.d_cb.i_rden <= 0;
  endtask
endclass
