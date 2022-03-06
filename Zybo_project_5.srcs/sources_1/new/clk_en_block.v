`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 09:08:35 PM
// Design Name: 
// Module Name: clk_en_block
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_en_block(
    input clk,
    input arstn,
    input en_i,
    output clk_en_o,
    output clk_div_o
    );
    parameter BITWIDTH = 8;
    
  (* keep = "true" *)   reg [BITWIDTH-1:0]cnt_q;
  (* keep = "true" *)   reg clk_en_q;
  (* keep = "true" *)   reg clk_div_q;
  
 always@(posedge clk or negedge arstn   )begin
    if(arstn==0)begin
        cnt_q <= 0;
    end else if(en_i==1)begin
        cnt_q <= cnt_q+1;
    end else begin
        cnt_q <= 0;
    end
 end
 
// clk enable signal
always@(posedge clk or negedge arstn )begin
     if(arstn==0)begin
        clk_en_q <= 1'b0;        
     end else if(cnt_q == {BITWIDTH{1'b1}} )begin
        clk_en_q <= 1'b1;        
     end else begin
        clk_en_q <= 1'b0;
     end
 end
assign clk_en_o = clk_en_q;
// clk div signal
assign clk_div_o = cnt_q[BITWIDTH-1];

endmodule
