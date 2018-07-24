`timescale 10 ns/1 ns

module div(
  input [31:0] a,
  input [31:0] b,
  input clk,
  output reg [31:0] out
);


reg [31:0] _a;
reg [31:0] _b;
always @(a or b) begin
  _a <= a;
  _b <= b;
end


reg [63:0] temp_a;
reg [63:0] temp_b; 
always @(posedge clk) begin

  temp_a = {32'b0, _a};
  temp_b = {_b,32'b0};

  repeat(32) begin
    temp_a = temp_a << 1;
    if (temp_a[63:32] > b)
        temp_a = temp_a-temp_b+1;
    else
        temp_a = temp_a;
  end

  out = temp_a[31:0]; 

end


endmodule