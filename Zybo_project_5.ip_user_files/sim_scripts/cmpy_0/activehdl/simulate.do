onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+cmpy_0 -L xil_defaultlib -L xpm -L xbip_utils_v3_0_8 -L axi_utils_v2_0_4 -L xbip_pipe_v3_0_4 -L xbip_bram18k_v3_0_4 -L mult_gen_v12_0_13 -L cmpy_v6_0_14 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.cmpy_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {cmpy_0.udo}

run -all

endsim

quit -force
