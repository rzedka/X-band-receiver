`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 05:59:02 PM
// Design Name: 
// Module Name: Header_extractor
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


module Header_extractor(
    input clk,
    input arstn,
    input data_en_i,
    input peak_det_i,
    input data_i,
    output header_data_o,
    output header_en_o,
    output header_clk_o
    );


(* keep = "true" *) reg [3:0]counter_q1;   
(* keep = "true" *) reg [3:0]counter_q2;   
(* keep = "true" *) reg [4:0]counter_d1;   
(* keep = "true" *) reg [4:0]counter_d2;   
(* keep = "true" *) reg [15:0]shreg_q;   
(* keep = "true" *) reg peak_det_q;   
wire counter_en1; // 
wire counter_en2; // 

wire counter_ovf1; // overflow
wire counter_ovf2; // overflow
wire data_mux;
wire shift_en; // 
wire clk_en_s; // 
wire R2; // 

// peak detection delay
always@(posedge clk or negedge arstn)begin
    if(arstn==0)begin
        peak_det_q <= 0;
    end else begin
        peak_det_q <= peak_det_i;
    end
end

// Adder for the counter 1:
always @(*)begin
    counter_d1 <= counter_q1 +1;
end
assign counter_ovf1 = counter_d1[4];
// COUNTER-1 (0 to 15)
always@(posedge clk or negedge arstn)begin
    if(arstn==0)begin
        counter_q1 <= 0;
    end else if(counter_en1 ==1)begin
        counter_q1 <= counter_d1[3:0];
    end
end

// Adder for the counter 2:
always @(*)begin
    counter_d2 <= counter_q2 +1;
end
assign counter_ovf2 = counter_d2[4];
// COUNTER-2 (0 to 15) - much slower than counter 1
always@(posedge clk or negedge arstn)begin
    if(arstn==0)begin
        counter_q2 <= 0;
    end else if((counter_en2 ==1)&&(clk_en_s))begin
        counter_q2 <= counter_d2[3:0];
    //end else if(counter_ovf2==1)begin
     //   counter_q2 <= 0;
    end
end
// Data input MUX:
assign data_mux = (counter_en1)?data_i:1'b0;

// Shift register enable
assign shift_en = counter_en1||clk_en_s;

// Shift register (16bit)
always@(posedge clk or negedge arstn)begin
    if(arstn==0)begin
        shreg_q <= 16'd0;
    end else if(shift_en ==1)begin
        shreg_q <= {data_mux, shreg_q[15:1]};
    end
end

// RS- flipflop with RESET priority:
RS_flipflop RS_FF_1(
    .clk  (clk),
    .arstn (arstn),
    .S     (peak_det_q),
    .R     (counter_ovf1),
    .Q     (counter_en1),
    .Qn    ()
);

assign R2 = counter_ovf2&&clk_en_s;

// RS- flipflop with RESET priority:
RS_flipflop RS_FF_2(
    .clk  (clk),
    .arstn (arstn),
    .S     (peak_det_q),
    .R     (R2),
    .Q     (counter_en2),
    .Qn    ()
);
clk_en_block CLK_EN_0(
    .clk(clk),
    .arstn(arstn),
    .en_i(counter_en2),
    .clk_en_o(clk_en_s),     // clock enable
    .clk_div_o(header_clk_o) // duty cycle 50 percent
    );  
    
assign header_data_o = shreg_q[0];  
assign header_en_o = counter_en2;  
    
endmodule
