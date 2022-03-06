`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2019 10:11:04 AM
// Design Name: 
// Module Name: DUT_top
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


module DUT_top(
    input sysclk,
    input arstn,
    //input freq_preset_en,
    //input [15:0]freq_preset,
    //output [15:0] I_out,
    //output [15:0] Q_out,
    //output [15:0] Cost_ERR_out_o,
    //output [15:0] Cost_LPF_out_o,
    //output [15:0] SymTim_ERR_out_o,
    //output [15:0] SymTim_LPF_out_o,
    //output [15:0] SymTim_U_out_o,
    output PLL_locked_o,
    output rd_clk_o,
    output data_o,
    output data_en_o,
    //output peak_det_o,
    output peak_toggle_o,
    output peak_det_LED_o,
    output header_o,
    output header_en_o,
    output header_clk_o
    
    );
    
    wire wr_clk, rd_clk;
    wire BRAM_en_s;
    wire freq_preset_en_s;
    wire [15:0] freq_preset_s;
    wire [13:0] BRAM_addr_s;
    wire [16:0] BRAM_addr1_s;
    wire [31:0] BRAM_out_s;
    wire [15:0] Cost_I_inp_s;
    wire [15:0] Cost_Q_inp_s;
    wire [15:0] Cost_I_out_s;
    wire [15:0] Cost_Q_out_s;
    wire [15:0] Cost_ERR_out_s;
    wire [15:0] Cost_LPF_out_s;
    wire [15:0] SymTim_I_out_s;
    wire [15:0] SymTim_Q_out_s;
    //wire [15:0] SymTim_ERR_out_s;
    //wire [15:0] SymTim_LPF_out_s;
    //wire [15:0] SymTim_U_out_s;
    //wire  SymTim_skip_out_s;
    wire cnt_clr; // clear the binary counter
    wire clk_rst;
    wire pll_locked;
    wire peak_det_s;
    wire data_s, data_en_s;
    
    assign cnt_clr = !pll_locked;
    assign clk_rst = !arstn;
    assign BRAM_en_s = pll_locked;
    
   clk_wiz_0 clk_wiz_0
       (
    // Clock out ports
    .clk_out1(wr_clk),     // output clk_out1
    .clk_out2(rd_clk),     // output clk_out2
    // Status and control signals
    .reset(clk_rst),      // input reset
    .locked(pll_locked),       // output locked
   // Clock in ports
    .clk_in1(sysclk)      // input clk_in1
    ); 
   
 // Control block. Generates startup conditions for the design (frequency offset preset for the Costas loop).
Zybo_ctrl_block Zybo_ctrl_0(
       .clk(wr_clk),
       .arstn(arstn),
       .pll_locked(pll_locked),
       .freq_preset_o(freq_preset_s),
       .freq_preset_en_o(freq_preset_en_s)
);     
c_counter_binary_3 CNT1_inst (
  .CLK(wr_clk),    // input wire CLK
  .CE(BRAM_en_s),      // input wire CE
  .SCLR(cnt_clr),  // input wire SCLR
  .Q(BRAM_addr1_s)        // output wire [16 : 0] Q
);
// ROM loaded with 9 CADUs,  f_offset = 18310 Hz. 
blk_mem_gen_1 ROM1_inst (
  .clka(wr_clk),    // input wire clka
  .ena(BRAM_en_s),      // input wire ena
  .addra(BRAM_addr1_s),  // input wire [16 : 0] addra
  .douta(BRAM_out_s)  // output wire [31 : 0] douta
);
/*
// Counter compatible with ROM_inst0
c_counter_binary_0 CNT0_inst (
      .CLK(wr_clk),    // input wire CLK
      .CE(BRAM_en_s),      // input wire CE
      .SCLR(cnt_clr),  // input wire SCLR
      .Q(BRAM_addr_s)        // output wire [13 : 0] Q
);

// Contains 1 CADU of MATLAB model signal, f_offset = 18310 Hz. 
blk_mem_gen_0 ROM_inst0 (
      .clka(wr_clk),    // input wire clka
      .ena(BRAM_en_s),      // input wire ena
      .addra(BRAM_addr_s),  // input wire [13 : 0] addra
      .douta(BRAM_out_s)  // output wire [31 : 0] douta
);
*/    
    assign Cost_I_inp_s = BRAM_out_s[31:16];
    assign Cost_Q_inp_s = BRAM_out_s[15:0];
    
   
    Costas_loop 
    Costas_inst (
      .clk       (wr_clk), 
      .arstn     (pll_locked),
      .I_inp     (Cost_I_inp_s),  // in [15:0]
      .Q_inp     (Cost_Q_inp_s), // in [15:0]
      .ph_off     (16'd0), // in [15:0]
      .freq_preset     (freq_preset_s), // in [15:0]
      .freq_preset_en  (freq_preset_en_s), // in 
      .fb_polarity     (1'b1), // in 
      .I_out      (Cost_I_out_s), // [15:0]
      .Q_out      (Cost_Q_out_s), //[15:0]
      .PD_out     (Cost_ERR_out_s), // [15:0]
      .LPF_out    (Cost_LPF_out_s) // [15:0]
      ); 
      
 Sym_Timing_loop SymTiming_inst(
      .wr_clk   (wr_clk),
      .rd_clk   (rd_clk),
      .arstn    (pll_locked),
      .I_inp    (Cost_I_out_s), //[15:0]
      .Q_inp    (Cost_Q_out_s), //[15:0]
      .I_out    (SymTim_I_out_s),
      .Q_out    (SymTim_Q_out_s),
      .err_debug_o      (),//[15:0] TED error debug output
      .lpf_debug_o      (),  //[15:0]  LPF debug output
      .u_debug_o        (),  //[15:0]
      .skip_debug_o     ()  //[0:0]
      );  
  
  ASM_detection ASM_det_0(
      .clk(rd_clk),
      .arstn(pll_locked),
      .I_inp(SymTim_I_out_s), 
      .Q_inp(SymTim_Q_out_s),
      .data_o(data_s),
      .data_en_o(data_en_s),
      .peak_det_o(peak_det_s)   
 );    
 
 // Design block for debugging and monitoring
 Zybo_monitor ZyboMonitor_0(
     .clk(rd_clk),
     .arstn(pll_locked),
     .peak_det_i(peak_det_s),
     .peak_det_toggle_o(peak_toggle_o),// freq_toggle = 915.5 Hz
     .peak_det_LED_o(peak_det_LED_o)// freq_LED = 915.5/1024 Hz
 );
 
Header_extractor HEADER_ext_0(
     .clk(rd_clk),
     .arstn(arstn),
     .data_en_i(data_en_s),
     .peak_det_i(peak_det_s),
     .data_i(data_s),
     .header_data_o(header_o),
     .header_en_o(header_en_o),
     .header_clk_o(header_clk_o)
     );
     
      assign data_en_o = data_en_s;   
      assign data_o = data_s;   
      //assign Q_out = SymTim_Q_out_s;   
      //assign Cost_ERR_out_o = Cost_ERR_out_s;   
      //assign Cost_LPF_out_o = Cost_LPF_out_s;   
      //assign SymTim_ERR_out_o = SymTim_ERR_out_s;   
      //assign SymTim_LPF_out_o = SymTim_LPF_out_s;   
      //assign SymTim_U_out_o = SymTim_U_out_s;   
      assign PLL_locked_o = pll_locked;   
      //assign peak_det_o = peak_det_s;   
      assign rd_clk_o = rd_clk;   
        
endmodule
