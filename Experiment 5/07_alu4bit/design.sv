// DESIGN: 4-bit Arithmetic Logic Unit
module alu4bit (
  input      [3:0] a, b,
  input      [2:0] sel,
  output reg [3:0] y,
  output reg       carry,
  output           zero
);
  reg [4:0] t;

  always @(*) begin
    t = 5'b00000;
    case (sel)
      3'b000 : t = {1'b0, a} + {1'b0, b};        // ADD
      3'b001 : t = {1'b0, a} - {1'b0, b};        // SUBTRACT
      3'b010 : t = {1'b0, a & b};                // AND
      3'b011 : t = {1'b0, a | b};                // OR
      3'b100 : t = {1'b0, a ^ b};                // XOR
      3'b101 : t = {1'b0, ~a};                   // NOT A
      3'b110 : t = {1'b0, a} + 5'b00001;         // INCREMENT A
      3'b111 : t = {1'b0, a} - 5'b00001;         // DECREMENT A
      default: t = 5'b00000;
    endcase
    y     = t[3:0];
    carry = t[4];
  end

  assign zero = (y == 4'b0000);
endmodule