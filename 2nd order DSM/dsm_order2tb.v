`timescale 1ns / 1ns

module dsm_order2tb();
  reg clk, reset;
  reg [15:0] alpha;
  wire MSB;

  dsm_order2 dut(.alpha(alpha), .MSB(MSB), .clk(clk), .reset(reset)); 

  initial begin
    $dumpfile("order2_16bit.vcd");
    $dumpvars(0, dsm_order2tb);
    #5 reset <= 1'b1;
    #5 reset <= 1'b0;
    clk = 1'b0;
    alpha = 16'b1100110011001101;
  end

  always #5 clk = ~clk;

  initial begin
    $monitor("Time: %0t, MSB = %b", $time, MSB);
    #10000 $finish;
  end
endmodule
