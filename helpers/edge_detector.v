`include "clock_divider.v"

module  edge_detector(
  input gclk,
  input rst,
  input sig,
  output edge_sig,
  output ref_clk
);

wire clk;

clock_divider clku0(
  .clk(gclk),
  .rst(rst),
  .out_clk(clk)
);

reg sig_d;

always @ (posedge clk or negedge rst) begin
  if (!rst) begin
    sig_d <= 0;
  end
  else begin
    sig_d <= sig;
  end
end

assign ref_clk = clk;
assign edge_sig = sig & ~sig_d;
endmodule
