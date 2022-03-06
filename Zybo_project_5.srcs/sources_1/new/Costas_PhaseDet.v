`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2019 10:50:10 PM
// Design Name: 
// Module Name: Costas_PhaseDet
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


 module Costas_PhaseDet(
    input clk,
    input arstn,
    input [15:0] I_inp,
    input [15:0] Q_inp,
    output [15:0] err_out
    );
    wire [16:0]add_0_out;
    wire [16:0]add_1_out;
    wire [15:0]sum_in_0;
    wire [15:0]sum_in_1;
    wire [16:0]sum_out;
    reg [15:0]I_inv;
    reg [15:0]Q_inv;
    reg I_sign;
    reg Q_nsign;
    reg [15:0]I_mux_inp;
    reg [15:0]Q_mux_inp;
    
c_addsub_1 unsig_add_0 (
  .A(Q_inv),      // input wire [15 : 0] A
  .B(1'b1),      // input wire [0 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(add_0_out)      // output wire [16 : 0] S
);

c_addsub_1 unsig_add_1 (
  .A(I_inv),      // input wire [15 : 0] A
  .B(1'b1),      // input wire [0 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(add_1_out)      // output wire [16 : 0] S
);

c_addsub_0 sig_add_0 (
  .A(sum_in_0),      // input wire [15 : 0] A
  .B(sum_in_1),      // input wire [15 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(sum_out)      // output wire [16 : 0] S
);

always @(I_inp, Q_inp)begin
    I_inv <= ~I_inp; // bitwise negation
    Q_inv <= ~Q_inp;   
end

always @(posedge clk or negedge arstn)begin
    if(arstn == 0)begin
        I_sign <= 1'b0;
        Q_nsign <= 1'b1;
        I_mux_inp <= 16'd0;
        Q_mux_inp <= 16'd0;
    end else begin
        I_sign <= I_inp[15];
        Q_nsign <= !Q_inp[15];
        I_mux_inp <= I_inp;
        Q_mux_inp <= Q_inp;
    end
end
//assign I_sign = I_inp[15];
//assign Q_nsign = !Q_inp[15];
// result = (condition)?{if not zero}:{if zero}
assign sum_in_0 = (I_sign) ? add_0_out[15:0] : Q_mux_inp ; // MUX0
assign sum_in_1 = (Q_nsign) ? add_1_out[15:0] : I_mux_inp ;  // MUX1
assign err_out = sum_out[15:0];

endmodule
