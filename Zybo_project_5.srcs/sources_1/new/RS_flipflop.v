`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 04:29:20 PM
// Design Name: 
// Module Name: RS_flipflop
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


module RS_flipflop(
    input clk,
    input arstn,
    input S,
    input R,
    output Q,
    output Qn
    );
    
   (* keep = "true" *)  reg q, qn;
 // Synchronous RS flipflop with RESET priority
 always@(posedge clk or negedge arstn)begin
    if(arstn==0)begin
        q <= 0;
        qn <= 1;
    end else begin
        q <= (q&&(!R)&&(!S))||(S&&(!R));
        qn <= R||(qn&&(!S));
    end

 end
 assign Q = q;
 assign Qn = qn;
endmodule
