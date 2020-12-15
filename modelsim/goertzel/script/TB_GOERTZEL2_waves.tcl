onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_goertzel2/clock
add wave -noupdate -radix unsigned /tb_goertzel2/reset
add wave -noupdate -radix unsigned /tb_goertzel2/input
add wave -noupdate -radix unsigned /tb_goertzel2/xn
add wave -noupdate -radix unsigned /tb_goertzel2/start
add wave -noupdate -radix unsigned /tb_goertzel2/output
add wave -noupdate -radix unsigned /tb_goertzel2/done
add wave -noupdate -divider STATE
add wave -noupdate -radix unsigned /tb_goertzel2/dut/s0
add wave -noupdate -radix unsigned /tb_goertzel2/dut/s1
add wave -noupdate -radix unsigned /tb_goertzel2/dut/s2
add wave -noupdate -radix unsigned /tb_goertzel2/dut/ps
add wave -noupdate -radix unsigned /tb_goertzel2/dut/cs
add wave -noupdate -radix unsigned /tb_goertzel2/dut/ns
add wave -noupdate -divider ADDER
add wave -noupdate -radix unsigned /tb_goertzel2/dut/adder_op1
add wave -noupdate -radix unsigned /tb_goertzel2/dut/adder_op2
add wave -noupdate -radix unsigned /tb_goertzel2/dut/resa
add wave -noupdate -divider {COS MULT}
add wave -noupdate -radix unsigned /tb_goertzel2/dut/cos_term_mult/op1
add wave -noupdate -radix unsigned /tb_goertzel2/dut/cos_term_mult/op2
add wave -noupdate -radix unsigned /tb_goertzel2/dut/cos_term_mult/res
add wave -noupdate -divider {WKN/FACTOR MULT}
add wave -noupdate -radix unsigned /tb_goertzel2/dut/mul_op1
add wave -noupdate -radix unsigned /tb_goertzel2/dut/mul_op2
add wave -noupdate -radix unsigned /tb_goertzel2/dut/resm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 275
configure wave -valuecolwidth 218
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
WaveRestoreZoom {0 ns} {313 ns}
