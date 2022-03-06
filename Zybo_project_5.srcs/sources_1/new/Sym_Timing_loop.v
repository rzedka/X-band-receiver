`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2019 09:25:19 PM
// Design Name: 
// Module Name: Sym_Timing_loop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This design block provides symbol timing feedback loop mechanism. The "Farrow_resampler" is a Farrow-structured interpolation 
// circuit which cyclicaly increments the fractional sample delay (in a range 0 -> 1) with a "step" precisely calculated for given 
// input (2.2222 smp/sym) and output (2.0 smp/sym) symbol sampling ratios. In a nutshell, it is able to resample data with input sampling ratio
// greater than the output sampling ratio. 
// The Farrow resampler as such works without any feedback, but for proper timing it must cooperate with Timing Error Detector (TED). 
// Since we use 2.0 smp/sym output ratio, Gardner TED has been used for this purpose. The output of the TED is updated every 2nd clk cycle. That
// is the reason for the clock enable signal (clock division by 2). 
// The TED_LPF is a feedback loop filter. It contains Proportional and Integral parts with coefficients set as powers of 2 (to avoid using multipliers). 
// The output of the TED_LPF leads into the Farrow_resampler block, closing the feedback loop. Since both blocks work in different clock domains 
// (Farrow resampler's input side works @ 16.6666 MSPS and TED_LPF works @ 15.0 MSPS), there is a simple domain crossing synchronizer in the Farrow
// Resampler's input. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Sym_Timing_loop(
    input wr_clk,
    input rd_clk,
    input arstn,
    input [15:0] I_inp,
    input [15:0] Q_inp, 
    output [15:0] I_out,
    output [15:0] Q_out,
    output [15:0]err_debug_o, // TED error debug output
    output [15:0]lpf_debug_o, // LPF debug output
    output [15:0]u_debug_o,
    output skip_debug_o
    );

    wire clk_rst;
    //wire locked_s;
    wire [15:0] I_resamp;
    wire [15:0] Q_resamp;
    wire [15:0] err_s;
    wire [15:0] fr_offset_s;
    wire ce_s;  
    
    Farrow_resampler FR_inst0 (
       .wr_clk(wr_clk),
       .rd_clk(rd_clk),
       .arstn(arstn),
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
        .arstn  (arstn),
        .I_inp  (I_resamp),
        .Q_inp  (Q_resamp),
        .err_out(err_s),
        .clk_en_out (ce_s)
    );
        
    TED_LPF TED_LPF_inst(
        .clk    (rd_clk),
        .arstn  (arstn),
        .err_i  (err_s),
        .clk_en_i (ce_s),
        .filter_o (fr_offset_s)
    );     
    
    assign err_debug_o = err_s;
    assign lpf_debug_o = fr_offset_s;
endmodule
