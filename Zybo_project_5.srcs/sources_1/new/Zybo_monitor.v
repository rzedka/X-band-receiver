`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2019 10:02:00 PM
// Design Name: 
// Module Name: Zybo_monitor
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


module Zybo_monitor(
    input clk,
    input arstn,
    input peak_det_i,
    input data_i,
    input data_en_i,
    //output header,
    output peak_det_toggle_o,
    output peak_det_LED_o
    );
    
   (* keep = "true" *) reg peak_det_toggle_q;
    wire [9:0] cnt_out;
    wire cnt_sclr;
    assign cnt_sclr =!arstn;
    
    always @(posedge clk or negedge arstn)begin
        if(arstn ==0)begin
            peak_det_toggle_q <= 0;
        end else begin
            if(peak_det_i == 1)begin
                peak_det_toggle_q <= !peak_det_toggle_q;
            end else begin
                peak_det_toggle_q <= peak_det_toggle_q;
            end
        end
    end
    assign peak_det_toggle_o = peak_det_toggle_q;
 
 // Dividing the peak detection pulses so they are visible on LEDs
 c_counter_binary_2 CNT_2 (
      .CLK(clk),    // input wire CLK
      .CE(peak_det_i),      // input wire CE
      .SCLR(cnt_sclr),  // input wire SCLR
      .Q(cnt_out)        // output wire [9 : 0] Q
    ); 
    
    assign peak_det_LED_o = cnt_out[9];
    
endmodule

