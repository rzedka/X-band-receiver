`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 11:43:22 AM
// Design Name: 
// Module Name: PRBS_gen
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


module PRBS_gen(
    input clk,
    input arstn,
    input gen_en,
    output gen_o
    );
     
    reg [7:0] shreg;
    wire bitxor;
    
always @(posedge clk or negedge arstn) begin
    if(arstn==0)begin
        shreg <= 8'hFF;
    end else begin
        if(gen_en==1)begin
            shreg <= {bitxor, shreg[7:1]};    
        end else begin
            shreg <= 8'hFF;
        end    
    end
end
// PRBS polygon = [1 0 1 0 1 0 0 1]
assign bitxor = ((shreg[0]^^shreg[3])^^shreg[5])^^shreg[7];

assign gen_o = shreg[0];

endmodule
