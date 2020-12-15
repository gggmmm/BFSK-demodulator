onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_magnitude_grz/clock
add wave -noupdate -radix unsigned /tb_magnitude_grz/reset
add wave -noupdate -radix unsigned /tb_magnitude_grz/input
add wave -noupdate -radix unsigned /tb_magnitude_grz/start
add wave -noupdate -radix unsigned /tb_magnitude_grz/output
add wave -noupdate -radix unsigned /tb_magnitude_grz/done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 264
configure wave -valuecolwidth 163
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
WaveRestoreZoom {0 ns} {842 ns}
