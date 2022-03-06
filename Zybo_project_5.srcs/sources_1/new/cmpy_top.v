`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2019 01:47:15 PM
// Design Name: 
// Module Name: cmpy_top
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


module cmpy_top(
    input clk,
    input arstn,
    input [15:0] a_real_i,
    input [15:0] a_imag_i,
    input [9:0] b_real_i,
    input [9:0] b_imag_i,
    output [15:0] y_real_o,
    output [15:0] y_imag_o
    );
    
  wire [31:0]cmpy_a;
  wire [31:0]cmpy_b;
  wire [79:0]cmpy_y;
  
  cmpy_0 CMPY_0 (
  .aclk(clk),                              // input wire aclk
  .aresetn(arstn), 
  .s_axis_a_tvalid(1'b1),        // input wire s_axis_a_tvalid
  .s_axis_a_tdata(cmpy_a),          // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1'b1),        // input wire s_axis_b_tvalid
  .s_axis_b_tdata(cmpy_b),          // input wire [31 : 0] s_axis_b_tdata
  .m_axis_dout_tvalid(),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(cmpy_y)    // output wire [79 : 0] m_axis_dout_tdata
);
    
    assign cmpy_a = {a_imag_i,a_real_i};
    assign cmpy_b = {b_imag_i,6'd0,b_real_i,6'd0};
    assign y_real_o = cmpy_y[30:15];
    assign y_imag_o = cmpy_y[70:55];
endmodule
