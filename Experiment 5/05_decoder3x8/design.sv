// DESIGN: 3x8 Decoder
module decoder3x8 (
  input      [2:0] a,
  input            en,
  output reg [7:0] y
);
  always @(*) begin
    y = 8'b00000000;
    if (en)
      y[a] = 1'b1;
  end
endmodule