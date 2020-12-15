onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_goertzel/output
add wave -noupdate -radix unsigned /tb_goertzel/input
add wave -noupdate -radix unsigned /tb_goertzel/output
add wave -noupdate -radix unsigned /tb_goertzel/xn
add wave -noupdate -radix unsigned /tb_goertzel/clock
add wave -noupdate -radix unsigned /tb_goertzel/reset
add wave -noupdate -radix unsigned /tb_goertzel/start
add wave -noupdate -radix unsigned /tb_goertzel/done
add wave -noupdate -radix unsigned /tb_goertzel/dut/s0
add wave -noupdate -radix unsigned /tb_goertzel/dut/s1
add wave -noupdate -radix unsigned /tb_goertzel/dut/s2
add wave -noupdate -radix unsigned /tb_goertzel/dut/ps
add wave -noupdate -radix unsigned /tb_goertzel/dut/cs
add wave -noupdate -radix unsigned /tb_goertzel/dut/ns
add wave -noupdate -radix unsigned /tb_goertzel/dut/counter
add wave -noupdate -radix unsigned /tb_goertzel/dut/reg_ct
add wave -noupdate -radix unsigned /tb_goertzel/dut/reg_fac
add wave -noupdate -radix unsigned /tb_goertzel/dut/reg_wkns
add wave -noupdate -divider ADDER
add wave -noupdate -radix unsigned /tb_goertzel/dut/adder_op1
add wave -noupdate -radix unsigned /tb_goertzel/dut/adder_op2
add wave -noupdate -radix unsigned /tb_goertzel/dut/resa
add wave -noupdate -divider MUL
add wave -noupdate -radix unsigned /tb_goertzel/dut/mul_op1
add wave -noupdate -radix unsigned /tb_goertzel/dut/mul_op2
add wave -noupdate -radix unsigned /tb_goertzel/dut/resm
add wave -noupdate -divider {MUL CT}
add wave -noupdate -radix unsigned /tb_goertzel/dut/cos_term_mult/op1
add wave -noupdate -radix unsigned /tb_goertzel/dut/cos_term_mult/op2
add wave -noupdate -radix unsigned /tb_goertzel/dut/cos_term_mult/res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 350
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
WaveRestoreZoom {0 ns} {206 ns}
