// ============ DESIGN: 1-bit Full Adder ============
module full_adder (
  input  a, b, cin,
  output sum, cout
);
  wire x1, a1, a2;

  xor g1 (x1,   a,  b);
  xor g2 (sum,  x1, cin);
  and g3 (a1,   a,  b);
  and g4 (a2,   x1, cin);
  or  g5 (cout, a1, a2);
endmodule

// ============ DESIGN: 2-bit Ripple Carry Adder ============
module adder2bit (
  input  [1:0] a, b,
  input        cin,
  output [1:0] sum,
  output       cout
);
  wire c1;

  full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
  full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1),  .sum(sum[1]), .cout(cout));
endmodule

// ============ DESIGN: 7-segment Decoder (Common Cathode) ============
module seg7_decoder (
  input      [3:0] d,
  output reg [6:0] seg
);
  always @(*) begin
    case (d)
      4'h0 : seg = 7'b1111110;
      4'h1 : seg = 7'b0110000;
      4'h2 : seg = 7'b1101101;
      4'h3 : seg = 7'b1111001;
      4'h4 : seg = 7'b0110011;
      4'h5 : seg = 7'b1011011;
      4'h6 : seg = 7'b1011111;
      4'h7 : seg = 7'b1110000;
      4'h8 : seg = 7'b1111111;
      4'h9 : seg = 7'b1111011;
      4'hA : seg = 7'b1110111;
      4'hB : seg = 7'b0011111;
      4'hC : seg = 7'b1001110;
      4'hD : seg = 7'b0111101;
      4'hE : seg = 7'b1001111;
      4'hF : seg = 7'b1000111;
      default : seg = 7'b0000000;
    endcase
  end
endmodule

// ============ DESIGN: Top Module ============
module adder_7seg (
  input  [1:0] a, b,
  input        cin,
  output [1:0] sum,
  output       cout,
  output [6:0] seg
);
  adder2bit add (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
  seg7_decoder dec (.d({1'b0, cout, sum}), .seg(seg));
endmodule