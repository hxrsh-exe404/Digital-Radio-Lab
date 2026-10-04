`timescale 1ns/1ps

module alu4bit_tb;
  reg  [3:0] a, b;
  reg  [2:0] sel;
  wire [3:0] y;
  wire       carry, zero;

  alu4bit dut (
    .a(a), .b(b), .sel(sel),
    .y(y), .carry(carry), .zero(zero)
  );

  integer k;

  task run_all;
    begin
      for (k = 0; k < 8; k = k + 1) begin
        sel = k[2:0];
        #10;
        $display("%b  | %b %b | %b   |  %b   |  %b", sel, a, b, y, carry, zero);
      end
    end
  endtask

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu4bit_tb);

    $display("SEL  |  A    B   |  Y   | Carry | Zero");

    a = 4'b1010; b = 4'b0011; run_all;   // A = 10, B = 3
    $display("-----------------------------------------");
    a = 4'b0110; b = 4'b1001; run_all;   // A = 6,  B = 9
    $display("-----------------------------------------");
    a = 4'b1111; b = 4'b0001; run_all;   // A = 15, B = 1
    $finish;
  end
endmodule