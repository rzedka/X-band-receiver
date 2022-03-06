`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2019 10:28:29 PM
// Design Name: 
// Module Name: round2zero
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This block provides division by 2^Nbit and it rounds the result
//  towards the zero. The latency is 1 cycle. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// LATENCY = 1 cycle
module round2zero(
    input clk,
    input arstn,
    input [15:0] a_i,
    output [15:0] y_o
    );
    
    parameter BITSHIFT = 2;
    
    wire [16:0]add_out;
    wire [15:0]a_sh;
  (* keep = "true" *)   reg sign_q;
    reg [15:0] a_sh_q;
    
    assign a_sh = {{(BITSHIFT+1){a_i[15]}}, a_i[14:BITSHIFT]};
    
    assign y_o = (sign_q)? add_out[15:0]: a_sh_q;
    
    always @(posedge clk or negedge arstn)begin
        if(arstn == 0)begin
            sign_q <= 1'd0;
            a_sh_q <= 16'd0;
        end else begin
            sign_q <= a_sh[15];
            a_sh_q <= a_sh;
        end
    end
    
 c_addsub_1 ADD0 (
      .A(a_sh),      // input wire [15 : 0] A
      .B(1'b1),      // input wire [0 : 0] B
      .CLK(clk),  // input wire CLK
      .CE(1'b1),    // input wire CE
      .S(add_out)      // output wire [16 : 0] S
    );
endmodule
