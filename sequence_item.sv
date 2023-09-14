class sequence_item extends uvm_sequence_item;
rand bit i_wren;
rand bit [127: 0] i_wrdata;
rand bit  i_rden ;
bit o_alm_full;
bit o_full;
bit [127: 0] o_rddata;
bit o_alm_empty;
bit o_empty;


`uvm_object_utils_begin(sequence_item)
`uvm_field_int(i_wren, UVM_ALL_ON)
`uvm_field_int(i_rden, UVM_ALL_ON)
`uvm_field_int(i_wrdata, UVM_ALL_ON)
`uvm_field_int(o_rddata, UVM_ALL_ON)
`uvm_field_int(o_full, UVM_ALL_ON)
`uvm_field_int(o_empty, UVM_ALL_ON)
`uvm_field_int(o_alm_full, UVM_ALL_ON)
`uvm_field_int(o_alm_empty, UVM_ALL_ON)

`uvm_object_utils_end

 function new(string name = "sequence_item");
    super.new(name);
    endfunction
    endclass
