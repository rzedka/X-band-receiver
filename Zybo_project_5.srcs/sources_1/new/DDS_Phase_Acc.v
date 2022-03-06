`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2019 08:45:47 AM
// Design Name: 
// Module Name: DDS_Phase_Acc
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


module DDS_Phase_Acc(
    input clk,
    input arstn,
    input [15:0] ph_inc, // signed
    input [15:0] ph_off, // signed
    output [15:0] phase_o // unsigned 
    );
    parameter BITWIDTH = 16; // output phase width (unsigned), out range < 0 ,(2^Bitwidth)-1 >
wire [BITWIDTH+1:0]add0_out;
wire [BITWIDTH+1:0]add1_out;
wire [BITWIDTH:0]add_0_a;
wire [BITWIDTH:0]add_1_a;
(* keep = "true" *) reg  [BITWIDTH:0]mod_0;// 
 (* keep = "true" *) reg  [BITWIDTH:0]mod_1;// 

assign add_0_a = {1'b0, ph_inc};
assign add_1_a = {1'b0, ph_off};
// Don't forget to re-config the ADDERs !!!!
c_addsub_2 Add_0 (
  .A(add_0_a),      // input wire [16 : 0] A
  .B(mod_0),      // input wire [16 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(add0_out)      // output wire [17 : 0] S
);    

c_addsub_2 Add_1 (
  .A(add_1_a),      // input wire [16 : 0] A
  .B(mod_0),      // input wire [16 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(add1_out)      // output wire [17 : 0] S
);    

// Modulo block 0:
always @(add0_out)begin
    if(add0_out[BITWIDTH]==1'b1)begin
        mod_0<= {1'b0,add0_out[BITWIDTH-1:0]};
    end else begin
        mod_0<= add0_out[BITWIDTH:0];
    end
end

always @(posedge clk or negedge arstn)begin
    if(arstn == 0)begin
        mod_1<= {(BITWIDTH+1){1'b0}};
    end else begin
        if(add1_out[BITWIDTH]==1'b1)begin
            mod_1<= {1'b0,add1_out[BITWIDTH-1:0]};
        end else begin
            mod_1<= add1_out[BITWIDTH:0]; // range  < 0: 2^(BITWIDTH-1)-1 >
        end
    end
end

assign phase_o = mod_1[BITWIDTH-1:0];

endmodule
