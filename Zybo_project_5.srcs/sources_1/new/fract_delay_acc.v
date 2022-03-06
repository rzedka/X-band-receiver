`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 12:50:56 PM
// Design Name: 
// Module Name: fract_delay_acc
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


module fract_delay_acc(
    input clk,
    input arstn,
    input [15:0] u_step_i,
    input [15:0] fr_offset_i,
    output [15:0] u_out,
    output skip_out // skip sample 
    );
    
    (* keep = "true" *) reg [15:0] u_step_q1;
   (* keep = "true" *)  reg [15:0] u_step_q2;
    (* keep = "true" *) reg [15:0] u_step_q3;
    wire mul_sclr;
    wire [31:0] mul0_out;
    wire [15:0] add0_b_in;
    wire [15:0] add1_a_in;
    wire [15:0] add1_b_in;
    wire [16:0] add0_out;
    wire [16:0] add1_out;
    
    assign mul_sclr = !arstn;
    assign add0_b_in = mul0_out[30:15];
    assign add1_a_in = add0_out[15:0];
    assign add1_b_in = {1'b0,add1_out[14:0]}; // underflow protection (flip on the positive )
    
  mult_gen_0 MUL0_inst ( // latency = 3 cycles
     .CLK(clk),    // input wire CLK
     .A(u_step_i),        // input wire [15 : 0] A
     .B(fr_offset_i),        // input wire [15 : 0] B
     .SCLR(mul_sclr),  // input wire SCLR
     .P(mul0_out)        // output wire [31 : 0] P
   );    
    
  c_addsub_0 ADD0_inst ( // latency = 1 cycle
      .A(u_step_q3),      // input wire [15 : 0] A
      .B(add0_b_in),      // input wire [15 : 0] B
      .CLK(clk),  // input wire CLK
      .CE(1'b1),    // input wire CE
      .S(add0_out)      // output wire [16 : 0] S
    );
    
   c_addsub_0 ADD1_inst ( // latency = 1 cycle
       .A(add1_a_in),      // input wire [15 : 0] A
       .B(add1_b_in),      // input wire [15 : 0] B
       .CLK(clk),  // input wire CLK
       .CE(1'b1),    // input wire CE
       .S(add1_out)      // output wire [16 : 0] S
     );
  
  always @(posedge clk or negedge arstn)begin
     if(arstn ==0)begin
        u_step_q1 <= 0;    
        u_step_q2 <= 0;    
        u_step_q3 <= 0;    
     end else begin
        u_step_q1 <= u_step_i;
        u_step_q2 <= u_step_q1;
        u_step_q3 <= u_step_q2;
        
     end
  end
  
  assign u_out = {1'b0, add1_out[14:0]};
  assign skip_out = add1_out[16];
endmodule
