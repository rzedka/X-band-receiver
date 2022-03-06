`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2019 06:47:08 PM
// Design Name: 
// Module Name: TED_LPF
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


module TED_LPF(
    input clk,
    input arstn,
    input [15:0] err_i,
    input clk_en_i,
    output [15:0] filter_o
    );
    
    reg [15:0]Int_q;
    reg [15:0]P_q;
    wire [15:0]P_div_inp;
    wire [15:0]I_div_inp;
    wire [16:0]ADD0_out;
    wire [15:0]ADD1_a_in;

    wire [16:0]ADD1_out;
    
    // Divide by 8, latency 1 cycle
round2zero #(.BITSHIFT(3)) 
       P_DIV(
       .clk(clk),
       .arstn(arstn),
       .a_i(err_i),
       .y_o(P_div_inp)
    );    
     // Divide by 512, latency 1 cycle
round2zero #(.BITSHIFT(9)) 
       I_DIV(
       .clk(clk),
       .arstn(arstn),
       .a_i(err_i),
       .y_o(I_div_inp)
    ); 
   // assign I_div_inp = 0; 
   
   // latency 1 cycle
c_addsub_0 ADD0 (
      .A(I_div_inp),      // input wire [15 : 0] A
      .B(Int_q),      // input wire [15 : 0] B
      .CLK(clk),  // input wire CLK
      .CE(clk_en_i),    // input wire CE
      .S(ADD0_out)      // output wire [16 : 0] S
    );    
    
//  latency 1 cycle
c_addsub_0 ADD1 (
      .A(ADD1_a_in),      // input wire [15 : 0] A
      .B(P_q),      // input wire [15 : 0] B
      .CLK(clk),  // input wire CLK
      .CE(clk_en_i),    // input wire CE
      .S(ADD1_out)      // output wire [16 : 0] S
    ); 
    
    assign ADD1_a_in = ADD0_out[15:0];
    
    always @(posedge clk or negedge arstn)begin
        if(arstn ==0)begin
            Int_q <= 0;
            P_q <= 0;
        end else if (clk_en_i) begin // clock enable
            Int_q <= ADD0_out[15:0];    
            P_q <= P_div_inp;    
        end 
    end
 
    assign filter_o = ADD1_out[15:0];
 
endmodule
