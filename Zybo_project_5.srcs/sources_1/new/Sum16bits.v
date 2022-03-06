`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 12:29:00 AM
// Design Name: 
// Module Name: Sum16bits
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


module Sum16bits(
    input [15:0] a,
    output [4:0] y
    );
    wire [3:0] y0;
    wire [3:0] y1;
Sum8bits SUM8bits_inst0(
    .a(a[7:0]), // 8bit in
    .y(y0)        // 4bit out
); 
Sum8bits SUM8bits_inst1(
    .a(a[15:8]), // 8bit in
    .y(y1)
); 
c_add4bit ADD4bit_inst0 (
  .A(y0),  // input wire [3 : 0] A
  .B(y1),  // input wire [3 : 0] B
  .S(y)  // output wire [4 : 0] S
  
);


endmodule
