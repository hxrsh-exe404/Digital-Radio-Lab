// DESIGN: 2x1 MUX
module mux2x1 (
  input  i0, i1, s,
  output y
);
  assign y = s ? i1 : i0;
endmodule

// DESIGN: 4x1 MUX using 2x1 MUX
module mux4x1 (
  input  i0, i1, i2, i3,
  input  s1, s0,
  output y
);
  wire w0, w1;

  mux2x1 m0 (.i0(i0), .i1(i1), .s(s0), .y(w0));
  mux2x1 m1 (.i0(i2), .i1(i3), .s(s0), .y(w1));
  mux2x1 m2 (.i0(w0), .i1(w1), .s(s1), .y(y));
endmodule