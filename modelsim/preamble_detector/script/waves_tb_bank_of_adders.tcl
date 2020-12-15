onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_bank_of_adders/clock
add wave -noupdate -radix unsigned /tb_bank_of_adders/reset
add wave -noupdate -radix unsigned /tb_bank_of_adders/input1
add wave -noupdate -radix unsigned /tb_bank_of_adders/input2
add wave -noupdate -radix unsigned /tb_bank_of_adders/start
add wave -noupdate -radix unsigned /tb_bank_of_adders/done
add wave -noupdate -radix unsigned /tb_bank_of_adders/output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {310 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 390
configure wave -valuecolwidth 116
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
WaveRestoreZoom {0 ns} {525 ns}
