module clock_divider
#(
  parameter DEF_FREQ=27000000
)(
  input clk,
  input rst,
  output reg out_clk
);
localparam COUNT_UP_TO = DEF_FREQ/2- 1;

reg [$clog2(COUNT_UP_TO)-1:0] counter;
always @ (posedge clk or negedge rst) begin
  if (!rst) begin
    counter <= 0;
    out_clk <= 0;
  end
  else begin
    counter <= counter + 1;
    if (counter == COUNT_UP_TO) begin
      counter <= 0;
      out_clk <= ~out_clk;
    end
  end
end

endmodule
