`timescale 1ns/1ps

module adder_7seg_tb;
  reg  [1:0] a, b;
  reg        cin;
  wire [1:0] sum;
  wire       cout;
  wire [6:0] seg;

  adder_7seg dut (
    .a(a), .b(b), .cin(cin),
    .sum(sum), .cout(cout), .seg(seg)
  );

  integer k;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, adder_7seg_tb);

    $display("A  B  Cin | Cout Sum | Dec | Seg(abcdefg)");
    for (k = 0; k < 32; k = k + 1) begin
      {a, b, cin} = k[4:0];
      #10;
      $display("%b %b  %b   |  %b   %b  |  %0d  | %b",
               a, b, cin, cout, sum, {cout, sum}, seg);
    end
    $finish;
  end
endmodule