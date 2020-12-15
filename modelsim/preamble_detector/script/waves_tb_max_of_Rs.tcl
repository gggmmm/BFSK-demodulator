onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/clock
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/reset
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/start
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R0
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R1
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R2
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R3
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R4
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R5
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R6
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/R7
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/done
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/result
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/cs
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/ns
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/ps
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/input_array
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/tmp_max_value
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/tmv
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/tmp_max_index
add wave -noupdate -radix unsigned /tb_max_of_rs/dut/tmi
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
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
WaveRestoreZoom {0 ns} {420 ns}
