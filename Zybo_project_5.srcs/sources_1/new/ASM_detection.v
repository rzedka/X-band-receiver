`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2019 10:54:26 PM
// Design Name: 
// Module Name: ASM_detection
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This block provides symbol detection (16bit samples -> 1bit), NRZ-M decoding, ASM detection,
// I-Q zipping into a single data stream and PRBS decoding triggered with each new CADU frame. 
// The output data format is "data_o" serial data stream enabled by "data_en_o" signal which is enabled for exactly 
// 8160 clock periods. Simulation is verified for all 4 Carrier phase ambiguity states.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ASM_detection(
    input clk,
    input arstn,
    input [15:0] I_inp, 
    input [15:0] Q_inp,
    output data_o,
    output data_en_o,
   // output [5:0] sum_IIRR_o,
   // output [5:0] sum_IRRI_o,
    output peak_det_o
   
    );
    
    parameter ASM_THRESHOLD = 29;
    
   (* keep = "true" *)  reg [31:0]shreg_I;
   (* keep = "true" *)  reg [31:0]shreg_Q1;
   (* keep = "true" *)  reg [31:0]shreg_Q2;
  (* keep = "true" *)   reg Q_inp_q1;
  (* keep = "true" *)   reg Q_inp_q2;
  (* keep = "true" *)   reg [15:0] ASM_I_rev; // reversed order 
  (* keep = "true" *)   reg [15:0] ASM_Q_rev; // reversed order 
    
   
  (* keep = "true" *)   reg I_sym_q, I_sym_qq, I_sym_qqq;
  (* keep = "true" *)   reg Q_sym_q, Q_sym_qq, Q_sym_qqq;
    wire I_sym_decod, Q_sym_decod;
    
    wire [15:0]I_buff;
    wire [15:0]Q1_buff;
    wire [15:0]Q2_buff;
    
  (* keep = "true" *)   reg [15:0]nxor_RR;
  (* keep = "true" *)   reg [15:0]nxor_II;
  (* keep = "true" *)   reg [15:0]nxor_IR;
  (* keep = "true" *)   reg [15:0]nxor_RI;
    
    wire [4:0]sum_RR;
    wire [4:0]sum_II;
    wire [4:0]sum_IR;
    wire [4:0]sum_RI;
    
    wire [5:0]sum_RR_II;
    wire [5:0]sum_IR_RI;
    
    wire [6:0] sub0_a_in; 
    wire [6:0] sub0_b_in; 
    wire [6:0] sub1_a_in; 
    wire [6:0] sub1_b_in; 
    wire [7:0] sub0_out; 
    wire [7:0] sub1_out; 
    wire ASM_cond0_s;
    wire ASM_cond1_s;
    wire bincnt_sclr;
    wire bincnt_ce;
    wire bincnt_thr_out;
    
    // Symbol detection (no-clock version)
    //assign I_sym = I_inp[15];
    //assign Q_sym = Q_inp[15];
    
 // NRZ-M decoding delays:   (data must be delayed by 2 samples because of 2.0 smp/sym data ratio )
always @(posedge clk or negedge arstn)begin
    if(arstn ==0)begin
        I_sym_q <= 0;
        Q_sym_q <= 0;
        I_sym_qq <= 0;
        I_sym_qqq <= 0;
        Q_sym_qq <= 0;
        Q_sym_qqq <= 0;
    end else begin
        I_sym_q <= I_inp[15];
        Q_sym_q <= Q_inp[15];
        I_sym_qq <= I_sym_q;
        I_sym_qqq <= I_sym_qq;
        Q_sym_qq <= Q_sym_q;
        Q_sym_qqq <= Q_sym_qq;
    end
end

// NRZ-M decoding ( 2.0 samples per symbol)
assign I_sym_decod = I_sym_q^I_sym_qqq;
assign Q_sym_decod = Q_sym_q^Q_sym_qqq;

    // ASM preparation:
    always@(posedge clk or negedge arstn)begin
        if(arstn ==0)begin
            ASM_I_rev  <= 16'h0000;
            ASM_Q_rev  <= 16'h0000;
            
        end else begin
            ASM_I_rev  <= 16'h47DC;
            ASM_Q_rev  <= 16'hE7D2;
        end  
    end    
    
   // Input buffers: 
    always@(posedge clk or negedge arstn)begin
        if(arstn ==0)begin
            shreg_I <= 32'd0;
            shreg_Q1 <= 32'd0;
            shreg_Q2 <= 32'd0;
            Q_inp_q1 <= 1'd0;
            Q_inp_q2 <= 1'd0;
        end else begin
            shreg_I  <= {I_sym_decod, shreg_I[31:1]};
            shreg_Q1 <= {Q_sym_decod, shreg_Q1[31:1]};
            shreg_Q2 <= {Q_inp_q2,shreg_Q2[31:1]};
            Q_inp_q1 <= Q_sym_decod;
            Q_inp_q2 <= Q_inp_q1;
        
        end
    
    end
// pick every 2nd input bit 
ASM_buff_interface ASM_BuffInt_0(
        .a(shreg_I), // [31:0] input
        .y(I_buff) // [15:0] input
);
// pick every odd input
ASM_buff_interface ASM_BuffInt_1(
        .a(shreg_Q1), // [31:0] input
        .y(Q1_buff) // [15:0] input
);
// pick every odd input
ASM_buff_interface ASM_BuffInt_2(
        .a(shreg_Q2), // [31:0] input
        .y(Q2_buff) // [15:0] input
);

always@(*)begin
    nxor_RR <= ~(I_buff^ASM_I_rev);
    nxor_II <= ~(Q1_buff^ASM_Q_rev);
    nxor_IR <= ~(Q2_buff^ASM_I_rev);
    nxor_RI <= ~(I_buff^ASM_Q_rev);

end

// Sum All ones in the 16bit word:
Sum16bits
 SUM16bits_0 (
  .a      (nxor_RR), // [15:0]
  .y      (sum_RR) // [4:0]
); 
Sum16bits SUM16bits_1 (
  .a      (nxor_II), // [15:0]
  .y      (sum_II) // [4:0]
); 
Sum16bits SUM16bits_2 (
  .a      (nxor_IR), // [15:0]
  .y      (sum_IR) // [4:0]
); 
Sum16bits SUM16bits_3 (
  .a      (nxor_RI), // [15:0]
  .y      (sum_RI) // [4:0]
); 

c_add5bit ADD5bit_0 (
  .A(sum_RR),      // input wire [4 : 0] A
  .B(sum_II),      // input wire [4 : 0] B
  .CLK(clk),  // input wire CLK
  .S(sum_RR_II)      // output wire [5 : 0] S
);

c_add5bit ADD5bit_1 (
  .A(sum_IR),      // input wire [4 : 0] A
  .B(sum_RI),      // input wire [4 : 0] B
  .CLK(clk),  // input wire CLK
  .S(sum_IR_RI)      // output wire [5 : 0] S
);

assign sub0_b_in = {1'b0,sum_RR_II};
assign sub1_b_in = {1'b0,sum_IR_RI};
assign sub0_a_in = ASM_THRESHOLD;
assign sub1_a_in = ASM_THRESHOLD;

c_add7bit SUB7bit_0 (
  .A(sub0_a_in),      // input wire [6 : 0] A
  .B(sub0_b_in),      // input wire [6 : 0] B
  .CLK(clk),  // input wire CLK
  .S(sub0_out)      // output wire [7 : 0] S
);

c_add7bit SUB7bit_1 (
  .A(sub1_a_in),      // input wire [6 : 0] A
  .B(sub1_b_in),      // input wire [6 : 0] B
  .CLK(clk),  // input wire CLK
  .S(sub1_out)      // output wire [7 : 0] S
);

assign ASM_cond0_s = sub0_out[7];
assign ASM_cond1_s = sub1_out[7];

wire S_FF0, Qn_FF0;
wire S_FF1, S_FF2;
wire mux0_s, mux1_s;

assign S_FF0 = Qn_FF0&&((ASM_cond0_s)||(ASM_cond1_s));
// RS- flipflop with RESET priority:
RS_flipflop RS_FF_0(
    .clk  (clk),
    .arstn (arstn),
    .S     (S_FF0),
    .R     (bincnt_thr_out),
    .Q     (bincnt_ce),
    .Qn    (Qn_FF0)
);


assign bincnt_sclr = (!arstn)||bincnt_thr_out;

// Binary counter up to 8160
c_counter_binary_1 BinCnt_0 (
  .CLK(clk),          // input wire CLK
  .CE(bincnt_ce),            // input wire CE
  .SCLR(bincnt_sclr),        // input wire SCLR
  .THRESH0(bincnt_thr_out),  // output wire THRESH0
  .Q()              // output wire [12 : 0] Q
);

assign S_FF1 = S_FF0&&ASM_cond0_s;
assign S_FF2 = S_FF0&&ASM_cond1_s;

// RS- flipflop with RESET priority:
RS_flipflop RS_FF_1(
    .clk  (clk),
    .arstn (arstn),
    .S     (S_FF1),
    .R     (bincnt_thr_out),
    .Q     (mux0_s),
    .Qn    ()
);
// RS- flipflop with RESET priority:
RS_flipflop RS_FF_2(
    .clk  (clk),
    .arstn (arstn),
    .S     (S_FF2),
    .R     (bincnt_thr_out),
    .Q     (mux1_s),
    .Qn    ()
);

wire clk_en_s;
// Clock enable Generator (division ratio = 2)
clk_en_gen CE_GEN_0(
    .clk    (clk),
    .arstn  (arstn),
    .en     (bincnt_ce),
    .clk_en_o     (clk_en_s),
    .clk_en_180_o ()
    );
    
    reg I_sym_decod_q, I_sym_decod_qq;  
  (* keep = "true" *)   reg Q1_sym_decod_q, Q1_sym_decod_qq ;  
  (* keep = "true" *)   reg Q2_sym_decod_q, Q2_sym_decod_qq ;  
   // reg I_sym_decod_qqq, Q1_sym_decod_qqq,Q2_sym_decod_qqq;
   
  //Symbol stream delay compensation:
  always@(posedge clk or negedge arstn)begin
      if(arstn ==0)begin
  
          I_sym_decod_q <= 1'd0;
          Q1_sym_decod_q <= 1'd0;
          Q2_sym_decod_q <= 1'd0;
          I_sym_decod_qq <= 1'd0;
          Q1_sym_decod_qq <= 1'd0;
          Q2_sym_decod_qq <= 1'd0;
      end else begin
            I_sym_decod_q <= I_sym_decod;
            I_sym_decod_qq <= I_sym_decod_q;
           // I_sym_decod_qqq <= I_sym_decod_qq;
            Q1_sym_decod_q <= Q_sym_decod;
            Q1_sym_decod_qq <= Q1_sym_decod_q;
            //Q1_sym_decod_qqq <= Q1_sym_decod_qq;
            Q2_sym_decod_q <= Q_inp_q2;
            Q2_sym_decod_qq <= Q2_sym_decod_q;
            //Q2_sym_decod_qqq <= Q2_sym_decod_qq;
      end
  end
  wire I_sym_mux;
  wire Q_sym_mux;
  wire mux_cond;
  reg I_sym_2nd; 
  reg Q_sym_2nd; 
  wire PRBS_inp;
  wire PRBS_inp_en;
  reg PRBS_inp_en_q;
 
 // Conditional signal for the Phase MUX.
 assign mux_cond = mux0_s&&(!mux1_s) ;
 
 // Phase ambiguity MUX:

 assign I_sym_mux = (mux_cond)? I_sym_decod_qq : Q2_sym_decod_qq ;
 assign Q_sym_mux = (mux_cond)? Q1_sym_decod_qq : I_sym_decod_qq ; //  choose between +-90  and 0/180 degree Phase.

 
 // Clock enabled register (pick every 2nd sample)
 always@(posedge clk or negedge arstn)begin
     if(arstn ==0)begin 
        I_sym_2nd <= 0;
        Q_sym_2nd <= 0;
     end else if(clk_en_s == 0)begin
        I_sym_2nd <= I_sym_mux;
        Q_sym_2nd <= Q_sym_mux;
     end
     
  end
  
 always@(posedge clk or negedge arstn)begin
     if(arstn ==0)begin   
        PRBS_inp_en_q <= 0;
     end else begin
        PRBS_inp_en_q <= bincnt_ce;
     end
  end
  
 // MUX used to switch between I and Q bit. Input of the PRBS decoder:
 assign PRBS_inp = (clk_en_s)?I_sym_2nd:Q_sym_2nd;
 assign PRBS_inp_en = PRBS_inp_en_q;

PRBS_decoder PRBS_DEC_0(
    .clk(clk),
    .arstn(arstn),
    .data_i(PRBS_inp),
    .data_en_i(PRBS_inp_en),
    .data_o(data_o),
    .data_en_o(data_en_o) 
    );

assign peak_det_o = S_FF0;

endmodule
