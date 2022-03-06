`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 03:36:43 PM
// Design Name: 
// Module Name: Farrow_resampler
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


module Farrow_resampler(
    input wr_clk,
    input rd_clk,
    input arstn,
    input [15:0] I_inp,
    input [15:0] Q_inp,
    input [15:0] fr_offset_i, // input from read- clock domain
    output [15:0] I_out,
    output [15:0] Q_out,
    output [15:0] u_debug,
    output  skip_debug
    );
    
    reg [18:0]shreg1;
    reg [23:0]shreg2;
    reg [15:0] fr_offset_q;
    reg [15:0] fr_offset_q2;
    reg locked_q1;
    reg locked_q2;
    reg locked_q3;
    reg locked_q4;

    wire [15:0]u_sig;
    wire fifo_wr_en;
    wire fifo_rd_en;
    wire [15:0] I_farr;
    wire [15:0] Q_farr;
    wire [31:0] fifo_din;
    wire [31:0] fifo_dout;
    wire skip_smp_s;
    wire fifo_rst;
    //assign Q_farr = 16'd0;
    assign fifo_rst = !arstn;
    assign fifo_wr_en = shreg1[0];
    assign fifo_rd_en = shreg2[0];
    assign fifo_din = {I_farr, Q_farr};
    assign I_out = fifo_dout[31:16];
    assign Q_out = fifo_dout[15:0];
    
    assign skip_debug = skip_smp_s;
    assign u_debug = u_sig;
    
    // Latency 19 cycles
    Farrow_interpolator FarrInt_I (
        .clk(wr_clk),
        .arstn(arstn),
        .farrow_inp(I_inp),  // [15:0] inp
        .u_inp(u_sig),       // [15:0] inp
        .farrow_out(I_farr)   // [15:0] out
    );
    
    // Latency 19 cycles
    Farrow_interpolator FarrInt_Q (
        .clk(wr_clk),
        .arstn(arstn),
        .farrow_inp(Q_inp),  // [15:0] inp
        .u_inp(u_sig),       // [15:0] inp
        .farrow_out(Q_farr)   // [15:0] out
     );
     
     fract_delay_acc FrDelay_inst(
        .clk(wr_clk),
        .arstn(arstn),
        .u_step_i(16'hF333),   // [15:0] in,  equals -1/10 
        .fr_offset_i(fr_offset_q2),// [15:0] in
        .u_out(u_sig),      // [15:0] out
        .skip_out(skip_smp_s)    // [0:0] out
     );
     
     
     fifo_generator_1 FIFO_resampler (
       .rst(fifo_rst),                  // input wire rst
       .wr_clk(wr_clk),            // input wire wr_clk
       .rd_clk(rd_clk),            // input wire rd_clk
       .din(fifo_din),                  // input wire [31 : 0] din
       .wr_en(fifo_wr_en),              // input wire wr_en
       .rd_en(fifo_rd_en),              // input wire rd_en
       .dout(fifo_dout),                // output wire [31 : 0] dout
       .full(),                // output wire full
       .empty(),              // output wire empty
       .rd_data_count(),  // output wire [3 : 0] rd_data_count
       .wr_data_count(),  // output wire [3 : 0] wr_data_count
       .wr_rst_busy(),  // output wire wr_rst_busy
       .rd_rst_busy()  // output wire rd_rst_busy
     );
     
     // Compensation of the Farrow Interp. latency:
     always @(posedge wr_clk or negedge arstn)begin
        if(arstn == 0)begin
            shreg1 <= 0;
        end else begin
            shreg1 <= {!skip_smp_s, shreg1[18:1]}; // bitshift right
        end
     end
     
     // Give the FIFO write some margin until it starts reading:
     // Delaying FIFO read enable to prevent the EMPTY flag situation:
      always @(posedge rd_clk or negedge arstn)begin
         if(arstn == 0)begin
             shreg2 <= 0;
         end else begin
             shreg2 <= {1'b1, shreg2[23:1]}; // bitshift right
         end
      end
      
     //  Domain crossing for the 
     always @(posedge wr_clk or negedge arstn)begin
         if(arstn == 0)begin
             fr_offset_q <= 0;
             fr_offset_q2 <= 0;
           
         end else begin
             fr_offset_q <= fr_offset_i; // bitshift right
             fr_offset_q2 <= fr_offset_q; // bitshift right
            
         end
      end
      
     
endmodule
