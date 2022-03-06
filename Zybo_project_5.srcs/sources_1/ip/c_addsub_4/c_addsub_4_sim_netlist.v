// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Mon Apr 15 00:47:31 2019
// Host        : DESKTOP-8SF1CNR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/darch/Documents/Vivado_projects/Zybo_project_4/Zybo_project_4.srcs/sources_1/ip/c_addsub_4/c_addsub_4_sim_netlist.v
// Design      : c_addsub_4
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_addsub_4,c_addsub_v12_0_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_11,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module c_addsub_4
   (A,
    B,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [3:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [3:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [4:0]S;

  wire [3:0]A;
  wire [3:0]B;
  wire [4:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* c_a_type = "1" *) 
  (* c_a_width = "4" *) 
  (* c_add_mode = "0" *) 
  (* c_ainit_val = "0" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "1" *) 
  (* c_b_value = "0000" *) 
  (* c_b_width = "4" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_has_ce = "0" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_latency = "0" *) 
  (* c_out_width = "5" *) 
  (* c_sinit_val = "0" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_addsub_4_c_addsub_v12_0_11 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(1'b0),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "1" *) 
(* C_A_WIDTH = "4" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "1" *) (* C_B_VALUE = "0000" *) 
(* C_B_WIDTH = "4" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "0" *) 
(* C_OUT_WIDTH = "5" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) (* ORIG_REF_NAME = "c_addsub_v12_0_11" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module c_addsub_4_c_addsub_v12_0_11
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [3:0]A;
  input [3:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [4:0]S;

  wire \<const0> ;
  wire [3:0]A;
  wire [3:0]B;
  wire [4:0]S;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* c_a_type = "1" *) 
  (* c_a_width = "4" *) 
  (* c_add_mode = "0" *) 
  (* c_ainit_val = "0" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "1" *) 
  (* c_b_value = "0000" *) 
  (* c_b_width = "4" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_has_ce = "0" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_latency = "0" *) 
  (* c_out_width = "5" *) 
  (* c_sinit_val = "0" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_addsub_4_c_addsub_v12_0_11_viv xst_addsub
       (.A(A),
        .ADD(1'b0),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b0),
        .CLK(1'b0),
        .C_IN(1'b0),
        .C_OUT(NLW_xst_addsub_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
iO2Bdkfy0dqqValMR4KhTWXpD0gDQF+kyoly3tZBTZTVs0CbWJ4Owhu4jxMCf8X2gbWR6iweF6Ks
B5dmLHZTDA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
dbcEbgyZfx3YLmYpvjegvD9sRQCV1qBv0GqFBvCakC3SMR/H82zqo5uv5MZldBGUVmNHnxF3Vejx
zSqxUKfTNc90CS6quuoQe0eeq3T5XSdgwbNtjPZKvJuJTmQKT96yB3CfQOz13fGjaLrn/8NBUBBh
I7OEoGGg7ADph9V3vRg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bD3a4YgAnaoJx9/hljj2C1rODcUhawTVE1gtdPkNj8/YjemaFM6/sF7Q0CXbDJ7a+OBrB5pUgj3O
Vesi4yVmFp+mGmFarftWat5KmZiP3RVWrXwdzMj+f8T7p+lE3iD4njqUxIUz0TsUaNvFeW0xVNNb
OwTEX04nyt5HrU82dltJCclpFxE6yrP9YvI7l328bphwnC63xxk8T3yXwCrvj3VrIYuDT2yMRxrB
TBCv/Fe2f07JQyV73J7+DGAeJG0B1dTHeu48auQT63g1HsYaUXREihEUKgZe70QlOqlPbrr6Quhx
2LXE8LSdCA+FbJ7LlQc/Sgasj3ZYjM5lhEKleQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GCfR7acMSeEtOw1DhZKkUXjh9Uw/vUar7CGDRG9rZcB9NFDtQTltJeuKjFg8eaeKH9HFBMryuX72
/tmzhtFaiSTjr2na4ncL2XV3QRXe7nQaiHdc7cKBcZDvdSSMzOSYcIxLunwLwQTLC7sCvINmlxO1
NXnYzJVL1xb9HP8QVnSYpo1p+gCXcRBZzrOjZjCUnl7F2t3ZZStSGjBEyXVLnV+ouU3+247oJAOa
kC7v+pOtG2ho4KclIg0MGijjPs+jyOFU+b5C+ufQp/zL9GiZ5waCjb/0Y1vkBc9jZKR7YRnv+ASG
ju1uP8oqEXR9742kXRnW4HkMKkCK1MLDgWYdqw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L+AGKmFZ1zoRJFd2cA+zxJhkgQ1R0aEjGQCGRFLNNhLHZXpzGDIjdSLjralBVRJ2rD6UcJutapF5
YaMoV9kphGGG2B07dxBuIimVjOxS3ZQJ7ru59ddfGBxUe9EHrv00Q5hTwoxig0lxqnmjSSnfsDeF
weTIqNnXkG5kqqezKC8a2FvUD5QWQBibhK69OAdmhhIOwZmpfvQKbEKgLX70BzcNlmLnttRL7G+q
XZ3fabZ42+JJHDLiIfveB3Gp2Lf2tzTH1u2xx5aEUr9154pnC9PWIwL3y3VBAT1oHR7ScdoGDOEy
HoYUiDibldOidIeKW0KrTeAIuBNmtM4R0R+RSA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
V5ClnklUs5Wo++EDemG/KeowZlAfqB8SUrvSxPQGrdIwGfUvoCajhuABAWdS/L/pQl7Eyz51aiuw
KzPMrWtQozAEITf1xzvzgKbWZqoi4PQD3rThywFsFq60u8DdvHYM/kEvit0cZVFvG8rAbtlseHLu
0vU1kbrNgxb3bxjOovg=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cRqAgScIUeXUwYGfCC0XDtpcc+mFNm3p8oTcFdtIU1nnlMagpBMqRm5ELc+m/Yw8jBwvcvt4tUFv
u/ypEEw+y12B+5Pr6SmnLJ+NVB3Q3Eyh4Q/d7p3jReIIsUxrlENpCTi4PVXMKr1B1Htzm8F8mXDq
y2UV+0SC+4yrBIntsdS0S8jPBERhfJhzNC5z38pPHANtM4wGGIUuKxIALLz1aq+2AjLbEgFHNrzw
2bJiDwRSTwrY4Yx2MSzYJk3O+cQBUe8nJDPx+aGEvDzQ4ZdJMNg2z+iaiE7OTaqK492Jb/1jvU0j
wlI+n35s2rrnc9QgfljdOJuueruPuYDi5vTTxA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZOfvuT4y+DOqdZf/hOi+0KpUl530E3vGOzxUrhAmzQ7FiEBvZ43VbRfxZIb5KWlzgJPrzAtt6HZ+
ffvH3jT2I84AEaMf7Cltarn+l1+FAgGBRVBo3JZlfksYBxYknCnZtRAxUg43wasAcJr9chlSPXcN
IZ10pDCsinYmGWRjx0RdPD60WU9NSPc5NrbIdk6x4XAhFSW+VhcFCPVxKY8pFKHNlcudfV9DJtdG
vHRZxBCqqg6yUyer+zvxVuNecV9hahYvzjMkj4Rg8KRRASRu0Y1caFhQ9hXMR2+iht4Io0Tqh0wh
+iTAEUbFhV7mVx+u2snqUytmY129KtfhOaaPeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
B3a9uMLggn+7pAVuuDWLz5eV+qkAPsc1jtnLtrAY2vrn2lmKdgJS4YSjW5/pmsxqqyx58RgMi+ap
yMavsrycFPraU91EZlFmabIwkE/tkuPGJQAPLuaRuSAgWTOOCFttreOB7xc3hfA3x0YueRbh5Dbi
7FWsqa3+/3RoQSZ1IyxCZf9n1B4jCPzgyf5ZgbA9LhLPynZmmxmpg94qPqdMY7c1MDZTBtm7ta3c
1aYCcJLkwHYXUs2W17akxhqF1bhvHG5arVQg934ShuOr5hreIfcEkwBgrS0xSlYh6bv8uVNcvNwP
6IL7lzw+gcz3d7yALCVEtGwYmzbIrqr7x+lgDg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 4608)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
