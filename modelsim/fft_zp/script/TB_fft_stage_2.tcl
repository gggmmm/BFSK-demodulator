vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/mult12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_mult_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_multiplier_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/sign_inverter_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_8_n.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_8_tw.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/fft_stage_2.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/tb/TB_fft_stage_2.vhdl

vsim -t ns work.TB_fft_stage_2

add wave -radix unsigned -position end  -noupdate -divider {FIRST EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res0
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res1
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res2
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res3
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res4
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res5
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res6
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res7
add wave -radix unsigned -position end  -noupdate -divider {SECOND EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res8
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res9
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res10
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res11
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res12
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res13
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res14
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res15
add wave -radix unsigned -position end  -noupdate -divider {THIRD EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res16
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res17
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res18
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res19
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res20
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res21
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res22
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res23
add wave -radix unsigned -position end  -noupdate -divider {FOURTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res24
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res25
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res26
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res27
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res28
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res29
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res30
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res31
add wave -radix unsigned -position end  -noupdate -divider {FIFTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res32
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res33
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res34
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res35
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res36
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res37
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res38
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res39
add wave -radix unsigned -position end  -noupdate -divider {SIXTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res40
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res41
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res42
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res43
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res44
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res45
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res46
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res47
add wave -radix unsigned -position end  -noupdate -divider {SEVENTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res48
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res49
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res50
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res51
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res52
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res53
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res54
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res55
add wave -radix unsigned -position end  -noupdate -divider {EIGHT EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res56
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res57
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res58
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res59
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res60
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res61
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res62
add wave -radix unsigned -position end  sim:/TB_fft_stage_2/res63

run 300 ns
