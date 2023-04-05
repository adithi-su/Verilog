`timescale 1ns / 1ns
module Dff_tb();

  reg D;
  reg clk;
  reg async_reset;
  wire Q;

  Dff DUT(.D(D), .clk(clk), .async_reset(async_reset), .Q(Q));

  initial begin
    $dumpfile("Dff.vcd");
    $dumpvars(0, Dff_tb);
    D = 1'b0;
    clk = 1'b0;
    async_reset = 1'b0;
    #10 async_reset = 1'b1;
    #10 async_reset = 1'b0;
    #20 D = 1'b1;
    #10 D = 1'b0;
    #20 D = 1'b1;
    #20 $finish;
  end

   always #5 clk = ~clk;
  
  initial begin
    $monitor("reset=%b, clk=%b, D=%b, Q = %b", async_reset, clk, D, Q);
    #200 $finish;
  end

endmodule
