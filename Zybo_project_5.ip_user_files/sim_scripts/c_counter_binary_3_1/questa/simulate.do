onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib c_counter_binary_3_opt

do {wave.do}

view wave
view structure
view signals

do {c_counter_binary_3.udo}

run -all

quit -force
