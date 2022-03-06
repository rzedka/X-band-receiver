`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 02:33:52 PM
// Design Name: 
// Module Name: Costas_bipolar_DDS
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


module Costas_bipolar_DDS(
    input clk,
    input arstn,
    input [15:0] ph_inc,
    input [15:0] ph_off,
    output [9:0] I_out,
    output [9:0] Q_out
    );

    wire [10:0]pa_phase_inc;
    wire [10:0]pa_phase_off;
    wire [15:0]dds_phase_in;
    wire [31:0]dds_cossin_out;
    wire [15:0]PhaseAcc_out;
 
DDS_Phase_Acc #(16) // bitwidth
DDS_PA_bipolar(
    .clk(clk),
    .arstn(arstn),
    .ph_inc(ph_inc),// 16bit signed inp
    .ph_off(ph_off),// 16bit signed inp
    .phase_o(PhaseAcc_out)// 16bit unsigned out
    );

assign dds_phase_in = PhaseAcc_out; // 16bit 

dds_compiler_0 DDS0 (
  .aclk(clk),                                // input wire aclk
  .aresetn(arstn),                          // input wire aresetn
  .s_axis_phase_tvalid(1'b1),  // input wire s_axis_phase_tvalid
  .s_axis_phase_tdata(dds_phase_in),    // input wire [15 : 0] s_axis_phase_tdata 
  //BUT the useful phase width = 10bit
  .m_axis_data_tvalid(),    // output wire m_axis_data_tvalid
  .m_axis_data_tdata(dds_cossin_out)      // output wire [31 : 0] m_axis_data_tdata
);

assign I_out = dds_cossin_out[9:0];   // cos out
assign Q_out = dds_cossin_out[25:16]; // sin out


endmodule
