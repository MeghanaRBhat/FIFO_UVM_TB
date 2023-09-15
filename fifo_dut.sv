module SYN_FIFO(
  input wire clk,             // Clock signal
  input wire reset,             // Reset signal
  input wire i_wren,        // Write enable
  input wire i_rden,         // Read enable
  input wire [127:0] i_wrdata, // Input data
  output reg [127:0] o_rddata, // Output data
  output wire o_full,           // Full signal
  output wire o_alm_full,    // Almost Full signal (4 spaces left)
  output wire o_empty,          // Empty signal
  output wire o_alm_empty    // Almost Empty signal (2 spaces filled)
);

 

  // FIFO parameters
  parameter DEPTH = 10;
  parameter WIDTH = 128;

 

  // Internal FIFO storage
  reg [WIDTH-1:0] fifo[0:DEPTH-1];
  reg [9:0] write_ptr;
  reg [9:0] read_ptr;
  wire [9:0] fifo_count = write_ptr - read_ptr;
  wire almost_full_condition = (fifo_count >= (DEPTH - 4));
  wire almost_empty_condition = (fifo_count <= 2);

 

  // Full and Empty signals
  assign o_full = (fifo_count >= (DEPTH - 1));
  assign o_alm_full = (almost_full_condition && !o_full);
  assign o_empty = (fifo_count == 1);
  assign o_alm_empty = (almost_empty_condition && !o_empty);

 

  always @(posedge clk ) begin
    if (!reset) begin
      write_ptr <= 0;
      read_ptr <= 0;
    end else if (i_wren) begin
      fifo[write_ptr] <= i_wrdata;
      write_ptr <= write_ptr + 1;
    end

 

    if (!reset) begin
      read_ptr <= 0;
    end else if (i_rden) begin
      read_ptr <= read_ptr + 1;
    end
  end

 

  // Assign data_out outside of procedural blocks
// assign o_rddata = (i_rden) ? fifo[read_ptr] : 128'b0;
  always@(*) begin
    //if(!reset)
  if(i_rden)
    o_rddata=fifo[read_ptr];
  end

endmodule
