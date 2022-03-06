onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib c_add5bit_opt

do {wave.do}

view wave
view structure
view signals

do {c_add5bit.udo}

run -all

quit -force
