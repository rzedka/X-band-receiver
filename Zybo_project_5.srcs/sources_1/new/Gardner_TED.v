`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2019 08:55:39 AM
// Design Name: 
// Module Name: Gardner_TED
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


module Gardner_TED(
    input clk,
    input arstn,
    input [15:0] I_inp,
    input [15:0] Q_inp,
    output [15:0] err_out,
    output clk_en_out
    );
    
    reg [15:0]I_q1;
    reg [15:0]I_q2;
    reg [15:0]Q_q1;
    reg [15:0]Q_q2;
    reg clk_en;
    
    wire [31:0]MULI_out;
    wire [31:0]MULQ_out;
    wire mul_rst;
    wire [15:0] I_inp_div;
    wire [15:0] Q_inp_div;
    wire [16:0] SUB_I_out;
    wire [16:0] SUB_Q_out;
    wire [15:0] ADD0_a_in;
    wire [15:0] ADD0_b_in;
    wire [16:0] ADD0_out;
    wire [15:0] MULI_a_in;
    wire [15:0] MULQ_a_in;
    
    assign mul_rst = !arstn;
    assign MULI_a_in = SUB_I_out[15:0];
    assign MULQ_a_in = SUB_Q_out[15:0];
    assign ADD0_a_in = MULI_out[30:15];
    assign ADD0_b_in = MULQ_out[30:15];
    
round2zero #(.BITSHIFT(1)) 
 I_DIV(
     .clk(clk),
     .arstn(arstn),
     .a_i(I_inp),
     .y_o(I_inp_div)
  );
  
round2zero #(.BITSHIFT(1)) 
   Q_DIV(
   .clk(clk),
   .arstn(arstn),
   .a_i(Q_inp),
   .y_o(Q_inp_div)
);

 c_addsub_3 SUB_I ( // S = A - B
    .A(I_inp_div),      // input wire [15 : 0] A
    .B(I_q2),      // input wire [15 : 0] B 
    .CLK(clk),  // input wire CLK
    .CE(1'b1),    // input wire CE
    .S(SUB_I_out)      // output wire [16 : 0] S
  ); 
  
   c_addsub_3 SUB_Q ( // S = A - B
     .A(Q_inp_div),      // input wire [15 : 0] A
     .B(Q_q2),      // input wire [15 : 0] B 
     .CLK(clk),  // input wire CLK
     .CE(1'b1),    // input wire CE
     .S(SUB_Q_out)      // output wire [16 : 0] S
   ); 
   
  mult_gen_0 MUL_I (
    .CLK(clk),    // input wire CLK
    .A(MULI_a_in),        // input wire [15 : 0] A
    .B(I_q2),        // input wire [15 : 0] B
    .SCLR(mul_rst),  // input wire SCLR
    .P(MULI_out)        // output wire [31 : 0] P
  );
  
  mult_gen_0 MUL_Q (
    .CLK(clk),    // input wire CLK
    .A(MULQ_a_in),        // input wire [15 : 0] A
    .B(Q_q2),        // input wire [15 : 0] B
    .SCLR(mul_rst),  // input wire SCLR
    .P(MULQ_out)        // output wire [31 : 0] P
  );  
    
  c_addsub_0 ADD0 (
    .A(ADD0_a_in),      // input wire [15 : 0] A
    .B(ADD0_b_in),      // input wire [15 : 0] B
    .CLK(clk),  // input wire CLK
    .CE(1'b1),    // input wire CE
    .S(ADD0_out)      // output wire [16 : 0] S
  );
  
  always @(posedge clk or negedge arstn)begin
    if(arstn ==0)begin
        I_q1 <=0;
        I_q2 <=0;
        Q_q1 <=0;
        Q_q2 <=0;
        clk_en <= 0;
    end else begin
        I_q1 <= I_inp_div;
        I_q2 <= I_q1;
        Q_q1 <= Q_inp_div;
        Q_q2 <= Q_q1;
        clk_en <= !clk_en;
    end
  
  end
  
  assign err_out = ADD0_out[15:0];
  assign clk_en_out = clk_en;
endmodule
