`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 05:37:15 PM
// Design Name: 
// Module Name: clk_en_gen
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

// Clock enable Generator (division ratio = 2)
module clk_en_gen(
    input clk,
    input arstn,
    input en,
    output clk_en_o,
    output clk_en_180_o
    );
    
  (* keep = "true" *)   reg clk_en_q;
  (* keep = "true" *)   reg clk_en_180_q;
    
always @(posedge clk or negedge arstn)begin
    if(arstn ==0)begin
        clk_en_q <= 0;
        clk_en_180_q <= 0;
    end else begin
        if(en == 1)begin
            clk_en_q <= !clk_en_q;
            clk_en_180_q <= clk_en_q;
        end else begin
            clk_en_q <= 0;
            clk_en_180_q <= 0;
        end
    end
end

assign clk_en_o = clk_en_q;
assign clk_en_180_o = clk_en_180_q;

endmodule
