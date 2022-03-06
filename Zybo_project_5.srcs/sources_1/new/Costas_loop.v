`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2019 08:49:19 PM
// Design Name: 
// Module Name: Costas_loop
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


module Costas_loop(
    input clk,
    input arstn,
    input [15:0] I_inp,
    input [15:0] Q_inp,
    input [15:0] ph_off,
    input [15:0] freq_preset,
    input freq_preset_en,
    input fb_polarity,
    output [15:0] I_out,
    output [15:0] Q_out,
    output [15:0] PD_out,
    output [15:0] LPF_out
    );
    
    
    wire [9:0]dds_I_sig;
    wire [9:0]dds_Q_sig;
    wire [15:0]cmpy_I_sig;
    wire [15:0]cmpy_Q_sig;
    wire [15:0]hsd_I_sig;
    wire [15:0]hsd_Q_sig;
    wire [15:0]PD_err_sig;
    wire [15:0]LPF_out_sig;
    
    cmpy_top CMPY_TOP_inst(
    .clk(clk),
    .arstn(arstn),
    .a_real_i(I_inp), // in [15:0]
    .a_imag_i(Q_inp), // in [15:0]
    .b_real_i(dds_I_sig), // in [9:0]
    .b_imag_i(dds_Q_sig), // in [9:0]
    .y_real_o(cmpy_I_sig), // out [15:0]
    .y_imag_o(cmpy_Q_sig) //out [15:0]
    );
    
    Half_sym_delay HSD_inst(
    .clk(clk),
    .arstn(arstn), // in [0:0]
    .I_inp(cmpy_I_sig), // in [15:0]
    .Q_inp(cmpy_Q_sig), // in [15:0]
    .I_out(hsd_I_sig), // out [15:0]
    .Q_out(hsd_Q_sig)   // out [15:0] 
    
    );
    
    Costas_PhaseDet CPD_inst(
    .clk(clk),
    .arstn(arstn),
    .I_inp(hsd_I_sig), // in [15:0] 
    .Q_inp(hsd_Q_sig), // in [15:0] 
    .err_out(PD_err_sig)          // out [15:0] 
    );
    
    
    Costas_LPF #(
    .I1_BITSHIFT(12),
    .I2_BITSHIFT(5),
    .P_BITSHIFT(10)
    ) 
    CLPF_inst (
    .clk(clk),
    .arstn(arstn),
    .sign_i(fb_polarity),  // in
    .err_i(PD_err_sig),        // in [15:0]
    .I_load(freq_preset),       // in [15:0]
    .I_load_en(freq_preset_en), // in
    .filter_o(LPF_out_sig)      // out [15:0]    
    );
    
    Costas_bipolar_DDS CBDDS_inst (
    .clk(clk),
    .arstn(arstn),
    .ph_inc(LPF_out_sig),
    .ph_off(ph_off),
    .I_out(dds_I_sig),
    .Q_out(dds_Q_sig)
    );
    
    assign I_out = hsd_I_sig;
    assign Q_out = hsd_Q_sig;
    assign PD_out = PD_err_sig;
    assign LPF_out = LPF_out_sig;
endmodule
