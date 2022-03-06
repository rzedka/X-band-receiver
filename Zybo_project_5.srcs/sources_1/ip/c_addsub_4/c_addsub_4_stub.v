// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Mon Apr 15 00:47:31 2019
// Host        : DESKTOP-8SF1CNR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/darch/Documents/Vivado_projects/Zybo_project_4/Zybo_project_4.srcs/sources_1/ip/c_addsub_4/c_addsub_4_stub.v
// Design      : c_addsub_4
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_addsub_v12_0_11,Vivado 2017.4" *)
module c_addsub_4(A, B, S)
/* synthesis syn_black_box black_box_pad_pin="A[3:0],B[3:0],S[4:0]" */;
  input [3:0]A;
  input [3:0]B;
  output [4:0]S;
endmodule
