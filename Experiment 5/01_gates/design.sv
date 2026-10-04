// DESIGN: Basic Logic Gates
module gates (
  input  a, b,
  output y_buf, y_not, y_and, y_or,
  output y_nand, y_nor, y_xor, y_xnor
);
  assign y_buf  = a;
  assign y_not  = ~a;
  assign y_and  = a & b;
  assign y_or   = a | b;
  assign y_nand = ~(a & b);
  assign y_nor  = ~(a | b);
  assign y_xor  = a ^ b;
  assign y_xnor = ~(a ^ b);
endmodule