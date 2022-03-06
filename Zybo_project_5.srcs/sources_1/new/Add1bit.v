`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 12:14:25 AM
// Design Name: 
// Module Name: Add1bit
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


module Add1bit(
    input a0,
    input a1,
    output [1:0] y
    );
    
    reg y0, y1;
    
    assign y = {y1,y0};
    
    always @(a0,a1)begin
        y0 <= a0^^a1;
        y1 <= a0&&a1;    
    end
endmodule
