`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 12:18:52 AM
// Design Name: 
// Module Name: Sum4bits
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


module Sum4bits(
    input [3:0] a,
    output [2:0] y
    );
    
    wire [1:0]y0;
    wire [1:0]y1;
    
Add1bit ADD1bit_inst0(
        .a0(a[0]),
        .a1(a[1]),
        .y(y0)    // 2bit out
 );   
Add1bit ADD1bit_inst1(
        .a0(a[2]),
        .a1(a[3]),
        .y(y1)    // 2bit out
 );
 
Add2bit ADD2bit_inst0(
     .a1(y0),
     .a2(y1),
     .y(y)   // 3bit out
);   

endmodule
