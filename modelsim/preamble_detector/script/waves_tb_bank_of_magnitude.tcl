onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/clock
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/reset
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/input
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/start
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/done
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/output(63)
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/clock
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/reset
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/input
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/start
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/output
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/done
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/OUT_square1
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/OUT_square2
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/OUT_add
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/OUT_sqrt
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/REG_square1
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/REG_square2
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/REG_add
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/REG_sqrt
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/ns
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/cs
add wave -noupdate -radix unsigned /tb_bank_of_magnitude/dut/gen_magnitude(63)/magnitudeu/ps
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 381
configure wave -valuecolwidth 205
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
WaveRestoreZoom {24 ns} {365 ns}
