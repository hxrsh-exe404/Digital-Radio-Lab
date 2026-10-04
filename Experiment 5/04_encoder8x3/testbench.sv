`timescale 1ns/1ps

module encoder8x3_tb;
  reg  [7:0] d;
  wire [2:0] y;

  encoder8x3 dut (.d(d), .y(y));

  integer k;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, encoder8x3_tb);

    $display("D7..D0   | Y2 Y1 Y0");
    for (k = 0; k < 8; k = k + 1) begin
      d = 8'b1 << k;
      #10;
      $display("%b |  %b  %b  %b", d, y[2], y[1], y[0]);
    end
    $finish;
  end
endmodule