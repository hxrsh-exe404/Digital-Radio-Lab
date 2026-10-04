// DESIGN: 1x2 DEMUX
module demux1x2 (
  input  d, s,
  output y0, y1
);
  assign y0 = d & ~s;
  assign y1 = d & s;
endmodule

// DESIGN: 1x4 DEMUX using 1x2 DEMUX
module demux1x4 (
  input  d, s1, s0,
  output y0, y1, y2, y3
);
  wire w0, w1;

  demux1x2 d0 (.d(d),  .s(s1), .y0(w0), .y1(w1));
  demux1x2 d1 (.d(w0), .s(s0), .y0(y0), .y1(y1));
  demux1x2 d2 (.d(w1), .s(s0), .y0(y2), .y1(y3));
endmodule