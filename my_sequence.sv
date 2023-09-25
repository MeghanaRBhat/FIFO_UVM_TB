//`include "sequence_item.sv"
class my_sequence extends uvm_sequence#(sequence_item);

sequence_item item;
`uvm_object_utils(my_sequence)

function new(string name = "my_sequence");
 super.new(name);
endfunction



virtual task body();

//ideal
 repeat(10) begin
item= sequence_item::type_id::create("item");
start_item(item);
  assert(item.randomize() with {i_wren==0;i_rden==0;});
 finish_item(item);
 end

//write
repeat(1024) begin
item= sequence_item::type_id::create("item");
start_item(item);
  assert(item.randomize() with {i_wren==1;i_rden==0;});
finish_item(item);
end

//Read
  repeat(1024) begin
item=sequence_item::type_id::create("item");
start_item(item);
assert(item.randomize() with {i_wren==0;i_rden==1;});
finish_item(item);
end

//alternate write read
repeat(1024) begin
item=sequence_item::type_id::create("item");
start_item(item);
// repeat(10) begin
  assert(item.randomize() with {i_wren==1;i_rden==0;});
  assert(item.randomize() with {i_wren==0;i_rden==1;});
finish_item(item);
   //end
 end

//simultaneous write and read
 repeat(1024) begin
item=sequence_item::type_id::create("item");
start_item(item);
 assert(item.randomize() with {i_wren==1;i_rden==1;});
 finish_item(item);
 end
endtask
endclass

