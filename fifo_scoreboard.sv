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

int queue[$];

function void write(input sequence_item item_got);
 bit [7:0] data;
 if(item_got.i_wren == 1)begin
   queue.push_back(item_got.i_wrdata);
   `uvm_info("write Data", $sformatf("i_wren: %0b i_rden: %0b      i_wrdata : %0h o_full: %0b",item_got.i_wren, item_got.i_rden,item_got.i_wrdata , item_got.o_full), UVM_LOW);
    end
 else if (item_got.i_rden == 'b1)begin
      if(queue.size() >= 1)begin
        data = queue.pop_front();
        `uvm_info("Read Data", $sformatf("data: %0h o_rddata: %0h o_empty: %0b",data, item_got.o_rddata, item_got.o_empty), UVM_LOW);
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
