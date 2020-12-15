onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_magnitude/clock
add wave -noupdate -radix unsigned /tb_magnitude/reset
add wave -noupdate -radix unsigned /tb_magnitude/input
add wave -noupdate -radix unsigned /tb_magnitude/start
add wave -noupdate -radix unsigned /tb_magnitude/output
add wave -noupdate -radix unsigned /tb_magnitude/done
add wave -noupdate -radix unsigned /tb_magnitude/dut/clock
add wave -noupdate -radix unsigned /tb_magnitude/dut/reset
add wave -noupdate -radix unsigned /tb_magnitude/dut/input
add wave -noupdate -radix unsigned /tb_magnitude/dut/start
add wave -noupdate -radix unsigned /tb_magnitude/dut/output
add wave -noupdate -radix unsigned /tb_magnitude/dut/done
add wave -noupdate -radix unsigned /tb_magnitude/dut/OUT_square1
add wave -noupdate -radix unsigned /tb_magnitude/dut/OUT_square2
add wave -noupdate -radix unsigned /tb_magnitude/dut/OUT_add
add wave -noupdate -radix unsigned /tb_magnitude/dut/OUT_sqrt
add wave -noupdate -radix unsigned /tb_magnitude/dut/REG_square1
add wave -noupdate -radix unsigned /tb_magnitude/dut/REG_square2
add wave -noupdate -radix unsigned /tb_magnitude/dut/REG_add
add wave -noupdate -radix unsigned /tb_magnitude/dut/REG_sqrt
add wave -noupdate -radix unsigned /tb_magnitude/dut/cs
add wave -noupdate -radix unsigned /tb_magnitude/dut/ns
add wave -noupdate -radix unsigned /tb_magnitude/dut/ps
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 312
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
WaveRestoreZoom {0 ns} {256 ns}
