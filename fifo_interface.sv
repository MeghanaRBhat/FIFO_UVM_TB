interface fifo_interface (input bit clk,reset);
logic i_wren;
logic [127: 0] i_wrdata;
logic  i_rden ;
logic o_alm_full;
logic o_full;
logic [127: 0] o_rddata;
logic o_alm_empty;
logic o_empty;

clocking d_cb @(posedge clk);
 default input #1 output #1;
output i_wren;
output i_wrdata;
output i_rden;
 input reset;

endclocking

clocking m_cb @(posedge clk);
default input #1 output #1;
input i_wren;
input i_wrdata;
input i_rden;
input o_alm_full;
input o_full;
input o_rddata;
input o_alm_empty;
input o_empty;
endclocking

  modport d_mp (input clk,reset, clocking d_cb);
  modport m_mp (input clk,reset, clocking m_cb);
endinterface

