onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider input
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/op1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/op5
add wave -noupdate -divider output
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res0
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res2
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res3
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res6
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/res7
add wave -noupdate -divider m1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/m1/op1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/m1/op2
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/m1/res
add wave -noupdate -divider a1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/a1/op1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/a1/op2
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/a1/res
add wave -noupdate -divider m5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/m5/op1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/m5/op2
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/m5/res
add wave -noupdate -divider i5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/i5/Cin
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/i5/Cout
add wave -noupdate -divider a5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/a5/op1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/a5/op2
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/a5/res
add wave -noupdate -divider {reg and stuff}
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/cs
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/ns
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_inv4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_inv5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_inv6
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_inv7
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_inv4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_inv5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_inv6
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_inv7
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul0
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul2
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul3
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul6
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/out_mul7
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_mul1
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_mul2
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_mul3
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_mul4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_mul5
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_mul6
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/reg_mul7
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/W1N4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/W2N4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/W3N4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/W5N4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/W6N4
add wave -noupdate -radix unsigned /tb_butterfly_8_tw/B/W7N4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70 ns} 0} {{Cursor 2} {192 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
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
WaveRestoreZoom {7573 ns} {7707 ns}
