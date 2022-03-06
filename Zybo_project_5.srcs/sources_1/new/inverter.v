`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2019 02:07:26 AM
// Design Name: 
// Module Name: inverter
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


module inverter(
    input clk,
    input arstn,
    input [15:0] x_i,
    input sign_i,
    output [15:0] y_o
    );
    
    
    reg sign_q;
    reg [15:0]x_q;
    wire [16:0]add_out;
    reg [15:0]x_neg;
 
 always @(*) begin
    x_neg <= ~x_i;
 end
 
 always @(posedge clk or negedge arstn)begin   
    if(arstn == 0)begin
        sign_q <= 1'b0;
        x_q <= 16'd0;
    end else begin
        sign_q <= sign_i;
        x_q <= x_i;
    end  
 end
 
    c_addsub_0 add0 (
  .A(x_neg),      // input wire [15 : 0] A
  .B(16'd1),      // input wire [15 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(add_out)      // output wire [16 : 0] S
);


assign y_o = (sign_q) ? add_out[15:0] : x_q ;

endmodule
