module dsm_3(alpha, reset, MSB, clk);
    input [15:0] alpha; //m-1
    input clk, reset;
    output reg MSB;

    wire signed [16:0] vdiff1;  //m 
    wire signed [17:0] vint1; //m+1
    wire signed [16:0] fb; //m 
    
    //diff 1: vdiff1 = alpha - MSB
    assign vdiff1 =  reset ? 17'b0 : ({1'b0, alpha} - fb);  //m+1

    //accum a1 ({1'b0, vdiff1}, vint1, clk, reset);
    acc_delay #(17) a1 (clk, reset, {1'b0, vdiff1}, vint1);   

    always @(posedge clk) 
    if (reset)
    begin
      MSB <= 1'b0;
    end
    else
    begin
       MSB <= vint1[17]; 
    end

    assign fb = {MSB,{(16){1'b0}}};

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

/*      
module accum (in, acc, clk, reset);
input [4:0] in;
input clk, reset;
output [4:0] acc;
reg [4:0] acc;

always@(clk) begin
if(reset)
acc <= 5'b0;
else
acc <= acc + in;
end
endmodule
*/







