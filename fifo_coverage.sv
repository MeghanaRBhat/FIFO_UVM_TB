class fifo_coverage extends uvm_subscriber #(sequence_item);
//  covergroup cg;
  
    `uvm_component_utils(fifo_coverage)
  
    function new(string name="fifo_coverage", uvm_component parent);
    super.new(name,parent);
    //req=sequence_item::type_id::create("req");
//    cg=new;
  endfunction

  
sequence_item req;
real cove3;
real cove;
covergroup cg;
    option.per_instance=1;
    fifo_write: coverpoint req.i_wren {
      bins i_wren_low={0};
      bins i_wren_high={1};
    }
    fifo_read: coverpoint req.i_rden {
      bins i_rden_low={0};
      bins i_rden_high={1};
    }
   // fifo_writedata: coverpoint req.i_wrdata;
   // fifo_readdata: coverpoint req.o_rddata;
 wren_rden : cross fifo_write,fifo_read; 
 data_in : coverpoint req.i_wrdata {
   bins i_wrdata={[2**127:0]};
 }
 endgroup

 covergroup cg2;

   option.per_instance=1;
   option.auto_bin_max=1024;
data_out: coverpoint req.o_rddata {
  bins o_rddata={[2**127:0]};
}
  full: coverpoint req.o_full {
    bins o_full[]={0,1};
  }
  empty: coverpoint req.o_empty {
    bins o_empty[]={0,1};
  }
  almost_full: coverpoint req.o_alm_full {
    bins o_alm_full[]={0,1};
  }
  almost_empty: coverpoint req.o_alm_empty {
    bins o_alm_empty[]={0,1};
  }
endgroup
cg=new();
cg2=new();
  function void write (sequence_item t);
    req=t;
    cg.sample();
    cg2.sample();
  endfunction

  function void extract_phase(uvm_phase phase);
  super.extract_phase(phase);
cove3=cg.get_inst_coverage();
cove=cg2.get_inst_coverage();
endfunction
  
function void report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info(get_type_name(),$sformatf("input coverage is %0.2f",cove3),UVM_MEDIUM);

  `uvm_info(get_type_name(),$sformatf("output coverage is %0.2f",cove),UVM_MEDIUM);
endfunction
endclass
