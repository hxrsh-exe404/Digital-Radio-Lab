`timescale 1ns/1ps

module gates_tb;
  reg a, b;
  wire y_buf, y_not, y_and, y_or, y_nand, y_nor, y_xor, y_xnor;

  gates dut (
    .a(a), .b(b),
    .y_buf(y_buf), .y_not(y_not), .y_and(y_and), .y_or(y_or),
    .y_nand(y_nand), .y_nor(y_nor), .y_xor(y_xor), .y_xnor(y_xnor)
  );

  integer k;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, gates_tb);

    $display("A B | BUF NOT AND OR NAND NOR XOR XNOR");
    for (k = 0; k < 4; k = k + 1) begin
      {a, b} = k[1:0];
      #10;
      $display("%b %b |  %b   %b   %b   %b    %b    %b   %b    %b",
               a, b, y_buf, y_not, y_and, y_or, y_nand, y_nor, y_xor, y_xnor);
    end
    $finish;
  end
endmodule