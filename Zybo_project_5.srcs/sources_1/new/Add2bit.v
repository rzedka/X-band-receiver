`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 12:01:11 AM
// Design Name: 
// Module Name: Add2bit
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


module Add2bit(
    input [1:0] a1,
    input [1:0] a2,
    output [2:0] y
    );
    
  reg y0, y1, y2;
  
  always @(a1,a2)begin
    y0 <= a1[0]^^a2[0];
    y1 <= (a1[1]^^a2[1])||(a1[0]&&a2[0]);
    y2 <= a1[1]&&a2[1];
  end
  assign y = {y2,y1,y0};
endmodule
