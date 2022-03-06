`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 03:44:11 PM
// Design Name: 
// Module Name: Farrow_resampler_test
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


module Farrow_resampler_test(
    input sysclk,
    input arstn,
    input [15:0] I_inp,
    input [15:0] Q_inp,
    //input [15:0] fr_offset_i,   
    output [15:0] I_out,
    output [15:0] Q_out,
    output wr_clk_o, // starting the file reading
    output rd_clk_o, // starting the file reading
    output locked_o, // starting the file reading
    output [15:0]err_debug_o, // TED error debug output
    output [15:0]lpf_debug_o, // LPF debug output
    output [15:0]u_debug_o,
    output skip_debug_o
    );
    
    wire wr_clk;
    wire rd_clk;
    wire clk_rst;
    wire locked_s;
    wire [15:0] I_resamp;
    wire [15:0] Q_resamp;
    wire [15:0] err_s;
    wire [15:0] fr_offset_s;
    wire ce_s;
    
    assign clk_rst = !arstn;
    assign locked_o = locked_s;
    assign wr_clk_o = wr_clk;
    assign rd_clk_o = rd_clk; // monitoring clocks
    
      clk_wiz_0 instance_name
     (
      // Clock out ports
      .clk_out1(wr_clk),     // output clk_out1
      .clk_out2(rd_clk),     // output clk_out2
      // Status and control signals
      .reset(clk_rst),      // input reset
      .locked(locked_s),       // output locked
     // Clock in ports
      .clk_in1(sysclk)      // input clk_in1
      );      
    
    Farrow_resampler FR_inst0 (
       .wr_clk(wr_clk),
       .rd_clk(rd_clk),
       .arstn(locked_s),
       .I_inp(I_inp), // [15:0] inp
       .Q_inp(Q_inp), // [15:0] inp
       .fr_offset_i(fr_offset_s), // [15:0] inp
       .I_out(I_resamp), // [15:0] out
       .Q_out(Q_resamp), // [15:0] out
       .u_debug(u_debug_o), // [15:0] debug out
       .skip_debug(skip_debug_o) // debug out
    
    );
    assign I_out = I_resamp;
    assign Q_out = Q_resamp;
    
    Gardner_TED TED_inst(
        .clk    (rd_clk),
        .arstn  (locked_s),
        .I_inp  (I_resamp),
        .Q_inp  (Q_resamp),
        .err_out(err_s),
        .clk_en_out (ce_s)
    );
        
    TED_LPF TED_LPF_inst(
        .clk    (rd_clk),
        .arstn  (locked_s),
        .err_i  (err_s),
        .clk_en_i (ce_s),
        .filter_o (fr_offset_s)
    );     
    
    assign err_debug_o = err_s;
    assign lpf_debug_o = fr_offset_s;
    
endmodule
