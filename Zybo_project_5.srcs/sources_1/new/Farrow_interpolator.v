`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2019 04:15:37 PM
// Design Name: 
// Module Name: Farrow_interpolator
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


module Farrow_interpolator(
    input clk,
    input arstn,
    input [15:0] farrow_inp,
    input [15:0] u_inp, // 16 bit input. Permitted range is (0 -> (2^15)-1 )
    output [15:0] farrow_out   
    );
    // u_inp
    wire [15:0] inp_div;
    wire [31:0]fir0_out;
    wire [31:0]fir1_out;
    wire [31:0]mul0_out;
    wire [31:0]mul1_out;
    wire [16:0]add0_out;
    wire [16:0]add1_out;
    wire [15:0]add0_b_in;
    wire [15:0]add1_b_in;
    wire [15:0]mul0_a_in;
    wire [15:0]mul1_a_in;
    wire mul_sclr;
    reg [15:0] inp_div_q1;
    reg [15:0] inp_div_q2;
    reg [15:0] inp_div_q3;
    reg [15:0] inp_div_q4;
    reg [15:0] inp_div_q5;
    reg [15:0] inp_div_q6;
    reg [15:0] inp_div_q7;
    reg [15:0] inp_div_q8;
    reg [15:0] inp_div_q9;
    reg [15:0] inp_div_q10;
    reg [15:0] b_q1;
    reg [15:0] b_q2;
    reg [15:0] b_q3;
    reg [15:0] c_q1;
    reg [15:0] c_q2;
    reg [15:0] c_q3;
    reg [15:0] c_q4;
    reg [15:0] c_q5;
    reg [15:0] c_q6;
    reg [15:0] c_q7;
   (* keep = "true" *)  reg [15:0] u_inp_q1;
   (* keep = "true" *)  reg [15:0] u_inp_q2;
   (* keep = "true" *)  reg [15:0] u_inp_q3;
   (* keep = "true" *)  reg [15:0] u_inp_q4;
   (* keep = "true" *)  reg [15:0] u_inp_q5;
   (* keep = "true" *)  reg [15:0] u_inp_q6;
   (* keep = "true" *)  reg [15:0] u_inp_q7;
   (* keep = "true" *)  reg [15:0] u_inp_q8;
   (* keep = "true" *)  reg [15:0] u_inp_q9;
   (* keep = "true" *)  reg [15:0] u_inp_q10;
   (* keep = "true" *)  reg [15:0] u_inp_q11;
   (* keep = "true" *)  reg [15:0] u_inp_q12;
   (* keep = "true" *)  reg [15:0] u_inp_q13;
   (* keep = "true" *)  reg [15:0] u_inp_q14;
   (* keep = "true" *)  reg [15:0] u_inp_q15;
    
    assign mul_sclr = !arstn ;
    
    
     round2zero #(.BITSHIFT(1)) 
    DIV0_inst(           // 1 cycle latency
        .clk(clk),
        .arstn(arstn),
        .a_i(farrow_inp), // inp [15:0]
        .y_o(inp_div) // out [15:0]
     );
     
     // h1 = [0.5, -1, 0.5]
     fir_compiler_1 FIR0_inst ( // 9 cycle latency
     .aresetn(arstn),                        // input wire aresetn
       .aclk(clk),                              // input wire aclk
       .s_axis_data_tvalid(1'b1),  // input wire s_axis_data_tvalid
       .s_axis_data_tready(),  // output wire s_axis_data_tready
       .s_axis_data_tdata(inp_div),    // input wire [15 : 0] s_axis_data_tdata
       .m_axis_data_tvalid(),  // output wire m_axis_data_tvalid
       .m_axis_data_tdata(fir0_out)    // output wire [31 : 0] m_axis_data_tdata
     );
    
    // h2 = [-0.75, 1-2^(-15), -0.25]
    fir_compiler_2 FIR1_inst (// 9 cycle latency
      .aresetn(arstn),                        // input wire aresetn
      .aclk(clk),                              // input wire aclk
      .s_axis_data_tvalid(1'b1),  // input wire s_axis_data_tvalid
      .s_axis_data_tready(),  // output wire s_axis_data_tready
      .s_axis_data_tdata(inp_div),    // input wire [15 : 0] s_axis_data_tdata
      .m_axis_data_tvalid(),  // output wire m_axis_data_tvalid
      .m_axis_data_tdata(fir1_out)    // output wire [31 : 0] m_axis_data_tdata
    );
    
    always@(posedge clk or negedge arstn) begin
        if(arstn ==0)begin
            inp_div_q1 <=0;
            inp_div_q2 <=0;
            inp_div_q3 <=0;
            inp_div_q4 <=0;
            inp_div_q5 <=0;
            inp_div_q6 <=0;
            inp_div_q7 <=0;
            inp_div_q8 <=0;
            inp_div_q9 <=0;
            inp_div_q10 <=0;
            b_q1 <= 0;
            b_q2 <= 0;
            b_q3 <= 0;
            c_q1 <= 0;
            c_q2 <= 0;
            c_q3 <= 0;
            c_q4 <= 0;
            c_q5 <= 0;
            c_q6 <= 0;
            c_q7 <= 0;
            u_inp_q1 <= 0;
            u_inp_q2 <= 0;
            u_inp_q3 <= 0;
            u_inp_q4 <= 0;
            u_inp_q5 <= 0;
            u_inp_q6 <= 0;
            u_inp_q7 <= 0;
            u_inp_q8 <= 0;
            u_inp_q9 <= 0;
            u_inp_q10 <= 0;
            u_inp_q11 <= 0;
            u_inp_q12 <= 0;
            u_inp_q13 <= 0;
            u_inp_q14 <= 0;
            u_inp_q15 <= 0;
        end else begin
            inp_div_q1 <=inp_div;
            inp_div_q2 <=inp_div_q1;
            inp_div_q3 <=inp_div_q2;
            inp_div_q4 <=inp_div_q3;
            inp_div_q5 <=inp_div_q4;
            inp_div_q6 <=inp_div_q5;
            inp_div_q7 <=inp_div_q6;
            inp_div_q8 <=inp_div_q7;
            inp_div_q9 <=inp_div_q8;
            inp_div_q10 <=inp_div_q9;
            b_q1 <= fir1_out[29:14]; // multiply by 2
            b_q2 <= b_q1;
            b_q3 <= b_q2;
            c_q1 <= inp_div_q10;
            c_q2 <= c_q1;
            c_q3 <= c_q2;
            c_q4 <= c_q3;
            c_q5 <= c_q4;
            c_q6 <= c_q5;
            c_q7 <= c_q6;
            u_inp_q1 <= u_inp;
            u_inp_q2 <= u_inp_q1;
            u_inp_q3 <= u_inp_q2;
            u_inp_q4 <= u_inp_q3;
            u_inp_q5 <= u_inp_q4;
            u_inp_q6 <= u_inp_q5;
            u_inp_q7 <= u_inp_q6;
            u_inp_q8 <= u_inp_q7;
            u_inp_q9 <= u_inp_q8;
            u_inp_q10 <= u_inp_q9;
            u_inp_q11 <= u_inp_q10;
            u_inp_q12 <= u_inp_q11;
            u_inp_q13 <= u_inp_q12;
            u_inp_q14 <= u_inp_q13;
            u_inp_q15 <= u_inp_q14;
        end
    end
    c_addsub_0 ADD0_inst ( // latency = 1 cycle
      .A(b_q3),      // input wire [15 : 0] A
      .B(add0_b_in),      // input wire [15 : 0] B
      .CLK(clk),  // input wire CLK
      .CE(1'b1),    // input wire CE
      .S(add0_out)      // output wire [16 : 0] S
    );
    
   c_addsub_0 ADD1_inst ( // latency = 1 cycle
      .A(c_q7),      // input wire [15 : 0] A
      .B(add1_b_in),      // input wire [15 : 0] B
      .CLK(clk),  // input wire CLK
      .CE(1'b1),    // input wire CE
      .S(add1_out)      // output wire [16 : 0] S
    );
    assign add0_b_in = mul0_out[30:15];
    assign add1_b_in = mul1_out[30:15];
    assign mul0_a_in = fir0_out[30:15];
    assign mul1_a_in = add0_out[15:0];
    
   mult_gen_0 MUL0_inst ( // latency = 3 cycles
      .CLK(clk),    // input wire CLK
      .A(mul0_a_in),        // input wire [15 : 0] A
      .B(u_inp_q11),        // input wire [15 : 0] B
      .SCLR(mul_sclr),  // input wire SCLR
      .P(mul0_out)        // output wire [31 : 0] P
    ); 
    
   mult_gen_0 MUL1_inst ( // latency = 3 cycles
      .CLK(clk),    // input wire CLK
      .A(mul1_a_in),        // input wire [15 : 0] A
      .B(u_inp_q15),        // input wire [15 : 0] B
      .SCLR(mul_sclr),  // input wire SCLR
      .P(mul1_out)        // output wire [31 : 0] P
    ); 
    //assign I_out = fir0_out[30:15];
    //assign I_out = fir1_out[29:14];
    //assign Q_out = fir1_out[29:14];
    assign farrow_out = {add1_out[14:0],1'b0}; // multiply by 2
    
    
endmodule
