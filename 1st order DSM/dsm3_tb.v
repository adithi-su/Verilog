`timescale 1ns / 1ns

module dsm3_tb();
  reg clk, reset;
  reg [15:0] alpha;
  wire MSB;

  dsm_3 dut(.alpha(alpha), .MSB(MSB), .clk(clk), .reset(reset));

  initial begin
    $dumpfile("order1_16.vcd");
    $dumpvars(0, dsm3_tb);
    #5 reset <= 1'b1;
    #5 reset <= 1'b0;
    clk = 1'b0;
    alpha = 16'b1111111111111111;
  end

  always #5 clk = ~clk;

  initial begin
    $monitor("Time: %0t, MSB = %b", $time, MSB);
    #10000 $finish;
  end
endmodule
