`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 09:33:44 AM
// Design Name: 
// Module Name: ASM_buff_interface
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


module ASM_buff_interface(
    input [31:0] a,
    output [15:0] y
    );
    
   assign y = {a[31],a[29],a[27],a[25],a[23],a[21],a[19],a[17],a[15],a[13],a[11],a[9],a[7],a[5],a[3],a[1]}; 
    
endmodule
