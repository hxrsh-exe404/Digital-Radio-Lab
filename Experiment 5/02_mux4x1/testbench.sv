`timescale 1ns/1ps

module mux4x1_tb;
  reg i0, i1, i2, i3, s1, s0;
  wire y;

  mux4x1 dut (
    .i0(i0), .i1(i1), .i2(i2), .i3(i3),
    .s1(s1), .s0(s0),
    .y(y)
  );

  integer k;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, mux4x1_tb);

    // Fixed data inputs: i0=1, i1=0, i2=1, i3=1
    i0 = 1; i1 = 0; i2 = 1; i3 = 1;

    $display("S1 S0 | Y");
    for (k = 0; k < 4; k = k + 1) begin
      {s1, s0} = k[1:0];
      #10;
      $display(" %b  %b  | %b", s1, s0, y);
    end
    $finish;
  end
endmodule