module dsm_order2 (alpha, reset, MSB, clk);
    input [15:0] alpha; // m = 3, [m-1:0]
    input clk, reset;
    output reg MSB;

    wire signed [16:0] vdiff1;  // m 
    wire signed [17:0] vint1;  // m+1
    wire signed [16:0] fb; // m
    wire signed [18:0] vdiff2; // m + 2
    wire signed [19:0] vint2; // m + 3
    
    
    //diff 1: vdiff1 = alpha - fb
    assign vdiff1 =  reset ? 17'b0 : ({1'b0, alpha} - fb);

    //accum a1 ({1'b0, vdiff1}, vint1, clk, reset);
    acc_delay #(17) a1 (clk, reset, {1'b0, vdiff1}, vint1);  //m+1

    //diff 2: vdiff2 = vint1 - fb
    assign vdiff2 = reset ? 19'b0 : ({1'b0, vint1} - {fb, {(2){1'b0}}});

    //int2 
    acc_delay #(19) a2 (clk, reset, {1'b0, vdiff2}, vint2); // m+3

    always @(posedge clk) 
    if (reset)
    begin
      MSB <= 1'b0;
    end
    else
    begin
       MSB <= vint2[19]; 
    end

    assign fb = {MSB,{(16){1'b0}}}; //m 

endmodule

module acc_delay #(parameter N=4) ( //N=4
  input clk, reset,
  input signed [N:0] in,
  output reg signed [N:0] out
);
  reg signed [N:0] reg_out = 0;
  always @(posedge clk) begin
    if (reset) begin
      reg_out <= 0;
      out <= 0;
    end
    else begin
      out <= in + reg_out;
      reg_out <= out;
    end
  end
endmodule
