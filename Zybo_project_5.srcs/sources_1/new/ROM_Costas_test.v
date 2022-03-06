`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 02:11:28 PM
// Design Name: 
// Module Name: ROM_Costas_test
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


module ROM_Costas_test(
    input wr_clk,
    input arstn, // means that PLL is locked and clock is ready
    input [15:0] freq_preset,
    input freq_preset_en,
    output [15:0] I_out,
    output [15:0] Q_out,
    output [15:0] PD_debug,
    output [15:0] LPF_debug
    );
    
    wire cnt_sclr;
    wire cnt_en;
    wire BRAM_en_s;
    wire [13:0] BRAM_addr_s;
    wire [31:0] BRAM_out_s;
    wire [15:0] Cost_I_inp_s;
    wire [15:0] Cost_Q_inp_s;
    
    assign cnt_sclr = !arstn;
    assign cnt_en = arstn;
    assign BRAM_en_s = arstn;
    
c_counter_binary_0 CNT0_inst (
      .CLK(wr_clk),    // input wire CLK
      .CE(cnt_en),      // input wire CE
      .SCLR(cnt_sclr),  // input wire SCLR
      .Q(BRAM_addr_s)        // output wire [13 : 0] Q
);
        
blk_mem_gen_0 ROM_inst (
      .clka(wr_clk),    // input wire clka
      .ena(BRAM_en_s),      // input wire ena
      .addra(BRAM_addr_s),  // input wire [13 : 0] addra
      .douta(BRAM_out_s)  // output wire [31 : 0] douta
);
            
 assign Cost_I_inp_s = BRAM_out_s[31:16];
 assign Cost_Q_inp_s = BRAM_out_s[15:0];
   
Costas_loop 
    Costas_inst (
      .clk       (wr_clk), 
      .arstn     (arstn),
      .I_inp     (Cost_I_inp_s),  // in [15:0]
      .Q_inp     (Cost_Q_inp_s), // in [15:0]
      .ph_off     (16'd0), // in [15:0]
      .freq_preset     (freq_preset), // in [15:0]
      .freq_preset_en  (freq_preset_en), // in 
      .fb_polarity     (1'b1), // in 
      .I_out      (I_out), // [15:0]
      .Q_out      (Q_out), //[15:0]
      .PD_out     (PD_debug), // [15:0]
      .LPF_out    (LPF_debug) // [15:0]
 ); 
          
endmodule
