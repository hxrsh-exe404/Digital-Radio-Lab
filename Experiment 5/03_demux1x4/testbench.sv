`timescale 1ns/1ps

module demux1x4_tb;
  reg  d, s1, s0;
  wire y0, y1, y2, y3;

  demux1x4 dut (
    .d(d), .s1(s1), .s0(s0),
    .y0(y0), .y1(y1), .y2(y2), .y3(y3)
  );

  integer k;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, demux1x4_tb);

    d = 1;
    $display("D S1 S0 | Y0 Y1 Y2 Y3");
    for (k = 0; k < 4; k = k + 1) begin
      {s1, s0} = k[1:0];
      #10;
      $display("%b  %b  %b  |  %b  %b  %b  %b", d, s1, s0, y0, y1, y2, y3);
    end
    $finish;
  end
endmodule