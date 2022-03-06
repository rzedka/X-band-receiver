`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 12:24:05 AM
// Design Name: 
// Module Name: Sum8bits
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


module Sum8bits(
    input [7:0] a,
    output [3:0] y
    );
    
    wire [2:0] y0;
    wire [2:0] y1;
    
Sum4bits SUM4bits_inst0(
    .a(a[3:0]),// 4bit in
    .y(y0) // 3bit out
); 
Sum4bits SUM4bits_inst1(
    .a(a[7:4]),// 4bit in
    .y(y1) // 3bit out
);

c_add3bit ADD3bit_inst0 (
  .A(y0),  // input wire [2 : 0] A
  .B(y1),  // input wire [2 : 0] B
  .S(y)  // output wire [3 : 0] S
);

endmodule
