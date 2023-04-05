module Dff(D,clk,async_reset,Q);
input D;  
input clk; 
input async_reset; 
output reg Q; 
always @(posedge clk or posedge async_reset) 
begin
 if(async_reset==1'b1)
  Q <= 1'b0; 
 else 
  Q <= D; 
end 
endmodule 
