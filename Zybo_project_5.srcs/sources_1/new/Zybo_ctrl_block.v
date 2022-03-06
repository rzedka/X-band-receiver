`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2019 03:45:49 PM
// Design Name: 
// Module Name: Zybo_ctrl_block
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


module Zybo_ctrl_block(
    input clk,
    input arstn,
    input pll_locked,
    output [15:0] freq_preset_o,
    output freq_preset_en_o
    );
        
     (* keep = "true" *)    reg [15:0] fr_preset;
     (* keep = "true" *)    reg fr_preset_en;
     (* keep = "true" *)    reg pll_locked_q;
     (* keep = "true" *)   reg pll_locked_qq;
        
        
    always @(posedge clk or negedge arstn)begin
        if(arstn ==0)begin
            fr_preset <= 16'b0;
            fr_preset_en <= 0;
            pll_locked_q <= 0;
            pll_locked_qq <= 0;
        end else begin
            fr_preset <= 16'd2304; // @ 18310.5 Hz offset 
            pll_locked_q <= pll_locked;
            pll_locked_qq <= pll_locked_q;
            fr_preset_en <= pll_locked_qq^pll_locked_q; // XOR, pos/neg edge only
        end
    end
    assign freq_preset_en_o = fr_preset_en;
    assign freq_preset_o = fr_preset;
    
endmodule
