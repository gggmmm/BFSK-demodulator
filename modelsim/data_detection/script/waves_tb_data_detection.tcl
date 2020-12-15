onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_data_detection/dut/clock
add wave -noupdate -radix unsigned /tb_data_detection/dut/reset
add wave -noupdate -radix unsigned /tb_data_detection/dut/start
add wave -noupdate -radix unsigned /tb_data_detection/dut/input
add wave -noupdate -radix unsigned /tb_data_detection/dut/binHigh
add wave -noupdate -radix unsigned /tb_data_detection/dut/binLow
add wave -noupdate -radix unsigned /tb_data_detection/dut/output
add wave -noupdate -radix unsigned /tb_data_detection/dut/done
add wave -noupdate -divider GOERTZEL
add wave -noupdate -radix unsigned /tb_data_detection/dut/REG_binHigh
add wave -noupdate -radix unsigned /tb_data_detection/dut/REG_binLow
add wave -noupdate -radix unsigned /tb_data_detection/dut/output_grzH
add wave -noupdate -radix unsigned /tb_data_detection/dut/output_grzL
add wave -noupdate -radix unsigned /tb_data_detection/dut/xn
add wave -noupdate -radix unsigned /tb_data_detection/dut/done_grzH
add wave -noupdate -radix unsigned /tb_data_detection/dut/done_grzL
add wave -noupdate -radix unsigned /tb_data_detection/dut/REG_out_grzH
add wave -noupdate -radix unsigned /tb_data_detection/dut/REG_out_grzL
add wave -noupdate -divider MAGNITUDE
add wave -noupdate -radix unsigned /tb_data_detection/dut/out_mag_grzH
add wave -noupdate -radix unsigned /tb_data_detection/dut/out_mag_grzL
add wave -noupdate -radix unsigned /tb_data_detection/dut/REG_mag_grzH
add wave -noupdate -radix unsigned /tb_data_detection/dut/REG_mag_grzL
add wave -noupdate -radix unsigned /tb_data_detection/dut/done_mag0
add wave -noupdate -radix unsigned /tb_data_detection/dut/done_mag1
add wave -noupdate -divider STATE
add wave -noupdate -radix unsigned /tb_data_detection/dut/counter
add wave -noupdate -radix unsigned /tb_data_detection/dut/ps
add wave -noupdate -radix unsigned /tb_data_detection/dut/cs
add wave -noupdate -radix unsigned /tb_data_detection/dut/ns
add wave -noupdate -radix unsigned /tb_data_detection/dut/start_GRZ
add wave -noupdate -radix unsigned /tb_data_detection/dut/start_MAG
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 319
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1114 ns}
