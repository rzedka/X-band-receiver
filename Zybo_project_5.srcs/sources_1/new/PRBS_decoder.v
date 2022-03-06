`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 12:08:15 PM
// Design Name: 
// Module Name: PRBS_decoder
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


module PRBS_decoder(
    input clk,
    input arstn,
    input data_i,
    input data_en_i,
    output data_o,
    output data_en_o
    );
    
    wire gen_s;
    //reg data_q;
    reg data_en_q;
    
PRBS_gen PRBS_GEN_inst0(
        .clk(clk),
        .arstn(arstn),
        .gen_en(data_en_i),//in
        .gen_o(gen_s)//out
);
/*
always @(posedge clk or negedge arstn)begin
    if(arstn == 0)begin
        //data_q <=0;
        data_en_q <=0;
        
    end else begin
        //data_q <= data_i;
        data_en_q <= data_en_i;
    end
end */

assign data_o = gen_s^^data_i;
assign data_en_o = data_en_i;

endmodule
