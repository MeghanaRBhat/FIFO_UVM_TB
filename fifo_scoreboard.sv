class fifo_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(sequence_item, fifo_scoreboard) item_export;
  `uvm_component_utils(fifo_scoreboard)

function new(string name = "fifo_scoreboard", uvm_component parent);
  super.new(name, parent);
  item_export = new("item_export", this);
endfunction

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction

  bit [127:0] queue[$];

function void write(input sequence_item item_got);
  bit [127:0] data;

  if(item_got.i_wren == 'b1)begin
    if(queue.size()<1024) begin
   queue.push_back(item_got.i_wrdata); 
   item_got.o_full=1;
   if(queue.size==1020 && queue.size<1024)
     item_got.o_alm_full=1;
   `uvm_info("write Data", $sformatf("i_wren: %0b i_rden: %0b      i_wrdata : %0h o_full: %0b o_alm_full: %0b,o_empty : %0b",item_got.i_wren, item_got.i_rden,item_got.i_wrdata , item_got.o_full,item_got.o_alm_full,item_got.o_empty), UVM_LOW);
 
 end
  end
 
  if (item_got.i_rden == 'b1)begin
      if(queue.size() >= 1)begin
        data = queue.pop_front();
       if(queue.size()==0)   
          item_got.o_empty=1;
        if(queue.size==2)
          item_got.o_alm_empty=1;
          `uvm_info("Read Data", $sformatf("data: %0h o_rddata: %0h o_empty: %0b o_alm_empty: %0b",data, item_got.o_rddata, item_got.o_empty,item_got.o_alm_empty), UVM_LOW);
        if(data == item_got.o_rddata)begin
          $display("Pass");
        end
        else begin
          $display("Fail!");
        
        end
      end
    end
  endfunction
endclass
