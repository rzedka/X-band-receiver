`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2019 02:00:35 PM
// Design Name: 
// Module Name: Costas_LPF
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


module Costas_LPF(
    input clk,
    input arstn,
    input sign_i,
    input [15:0] err_i,
    input [15:0] I_load,
    input I_load_en,
    output [15:0] filter_o
    );
    
   parameter I1_BITSHIFT = 12; // == 0 for no division, Represents coefficient K2
   parameter I2_BITSHIFT = 5; // == 0 for no division
   parameter P_BITSHIFT = 10; // == 0 for no division, Represents coefficient K1
   
   
 //reg [16:0]add0_buff;   
 (* keep = "true" *) reg [15:0]I_sat_q;   
 (* keep = "true" *) reg [15:0]P_div_q;   
(* keep = "true" *)  reg [15:0]P_div_qq;   
 (* keep = "true" *) reg [15:0]I_sat;   
 (* keep = "true" *) reg I_load_en_q;
(* keep = "true" *)  reg [15:0]I_load_q;
 wire [16:0]add0_out;
 wire [16:0]add1_out;
 wire [15:0]P_inp_div;
 wire [15:0]I_inp_div;
 wire [15:0]I_sat_div;

 wire [15:0]inv_i;
 
 
  // ========= Division by 2^I1_BITSHIFT ==============
 //assign I_inp_div = {{(I1_BITSHIFT+1){err_i[15]}}, err_i[14:I1_BITSHIFT]};
  // ========= Division by 2^P_BITSHIFT ==============
 //assign P_inp_div = {{(P_BITSHIFT+1){err_i[15]}}, err_i[14:P_BITSHIFT]};
 
 
 // ========= Division by 2^I1_BITSHIFT ==============
 // =========== 1 cycle latency ===========
 round2zero #(.BITSHIFT(I1_BITSHIFT)) 
 INT_1_DIV(
     .clk(clk),
     .arstn(arstn),
     .a_i(err_i),
     .y_o(I_inp_div)
  );
 
 // ========= Division by 2^P_BITSHIFT ==============
 // =========== 1 cycle latency ===========
  round2zero #(.BITSHIFT(P_BITSHIFT)) 
  PROP_1_DIV(
      .clk(clk),
      .arstn(arstn),
      .a_i(err_i),
      .y_o(P_inp_div)
   );


c_addsub_0 Add_0 (
  .A(I_inp_div),      // input wire [15 : 0] A
  .B(I_sat),      // input wire [15 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(add0_out)      // output wire [16 : 0] S
); 


// Overflow / Underflow protection
always @(*) begin
    if(I_load_en_q == 1'b1) begin
        I_sat <= I_load_q;
     end else begin
        //if((add0_buff[15:12]==4'b1000)&&(add0_out[15:12]==4'b0111))begin
        if((I_sat_q[15:12]==4'b1000)&&(add0_out[15:12]==4'b0111))begin
             // Underflow
             I_sat <= 16'h8000;
         //end else if((add0_buff[15:12]==4'b0111)&&(add0_out[15:12]==4'b1000))begin
         end else if((I_sat_q[15:12]==4'b0111)&&(add0_out[15:12]==4'b1000))begin
             // Overflow
             I_sat <= 16'h7FFF;
         end else begin
         // Normal operation
             I_sat <= add0_out[15:0];
         end
     end
end

// ========= Division by 2^I2_BITSHIFT ==============
//assign I_sat_div = {{(I2_BITSHIFT+1){I_sat[15]}}, I_sat[14:I2_BITSHIFT]};
round2zero #(.BITSHIFT(I2_BITSHIFT)) 
 INT_2_DIV(
     .clk(clk),
     .arstn(arstn),
     .a_i(I_sat),
     .y_o(I_sat_div)
  );
  
 c_addsub_0 Add_1 (
  .A(P_div_qq),      // input wire [15 : 0] A
  .B(I_sat_div),      // input wire [15 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(add1_out)      // output wire [16 : 0] S
); 

always @(posedge clk or negedge arstn)begin
    if(arstn == 0)begin
        //add0_buff <= 17'd0;
        I_sat_q <= 16'd0;
        P_div_q <= 16'd0;
        P_div_qq <= 16'd0;
        I_load_q <= 16'd0;
        I_load_en_q <= 1'b0;
    end else begin
        //add0_buff <= add0_out;
        I_sat_q <= I_sat;
        P_div_q <= P_inp_div;
        P_div_qq <= P_div_q;
        I_load_q <= I_load;
        I_load_en_q <=I_load_en;
    end
   
end


inverter inv0 (
    .clk(clk),
    .arstn(arstn),
    .x_i(inv_i),
    .sign_i(sign_i), // sign of the Costas loop feedback (0 == Positive)
    .y_o(filter_o)
);
// Output assignment:
assign inv_i = add1_out[15:0];

endmodule
