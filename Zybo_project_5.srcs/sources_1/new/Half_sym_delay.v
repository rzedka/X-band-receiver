`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2019 05:12:51 PM
// Design Name: 
// Module Name: Half_sym_delay
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


module Half_sym_delay(
    input clk,
    input arstn,
    input [15:0] I_inp,
    input [15:0] Q_inp,
    output [15:0] I_out,
    output [15:0] Q_out
    );
    
    (* keep = "true" *) reg [3:0]smp_cnt;
    //reg fifo_srst;
    wire [31:0]fir_out;
    wire [15:0]fifo_out;
    reg fifo_rd_en;
    reg fifo_wr_en;
    wire srst;
    
    assign srst = !arstn;

fir_compiler_0 FIR0 (
  .aresetn(arstn),                        // input wire aresetn
  .aclk(clk),                              // input wire aclk
  .s_axis_data_tvalid(1'b1),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(),  // output wire s_axis_data_tready
  .s_axis_data_tdata(I_inp),    // input wire [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(fir_out)    // output wire [31 : 0] m_axis_data_tdata
);

fifo_generator_0 FIFO0 (
  .clk(clk),      // input wire clk
  .srst(srst),    // input wire srst
  .din(Q_inp),      // input wire [15 : 0] din
  .wr_en(fifo_wr_en),  // input wire wr_en
  .rd_en(fifo_rd_en),  // input wire rd_en
  .dout(fifo_out),    // output wire [15 : 0] dout
  .full(),    // output wire full
  .empty()  // output wire empty
);
    assign I_out = fir_out[30:15];
    assign Q_out = fifo_out;
    
    always @(posedge clk)
    begin
        if(srst==1)begin
            //fifo_srst <= 1;
            smp_cnt <= 0;
            fifo_rd_en <=0;
            fifo_wr_en <=0;
        end else begin
            //fifo_srst <= 0;
            fifo_wr_en <= 1;
            if (smp_cnt < 4'd10) begin
                smp_cnt <= smp_cnt + 1;
                fifo_rd_en <= 0;
            end else begin
                smp_cnt <= smp_cnt;
                fifo_rd_en <= 1;
            end 
        end  
    end

endmodule
