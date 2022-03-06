onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib c_add3bit_opt

do {wave.do}

view wave
view structure
view signals

do {c_add3bit.udo}

run -all

quit -force
