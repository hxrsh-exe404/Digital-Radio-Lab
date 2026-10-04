`timescale 1ns/1ps

module decoder3x8_tb;
  reg  [2:0] a;
  reg        en;
  wire [7:0] y;

  decoder3x8 dut (.a(a), .en(en), .y(y));

  integer k;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, decoder3x8_tb);

    en = 1;
    $display("EN A2 A1 A0 | Y7..Y0");
    for (k = 0; k < 8; k = k + 1) begin
      a = k[2:0];
      #10;
      $display(" %b  %b  %b  %b  | %b", en, a[2], a[1], a[0], y);
    end

    // Enable disabled check
    en = 0; a = 3'b101;
    #10;
    $display(" %b  %b  %b  %b  | %b (Disabled)", en, a[2], a[1], a[0], y);

    $finish;
  end
endmodule