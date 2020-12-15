vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/mult12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_mult_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_multiplier_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/sign_inverter_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_4_n.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_4_tw.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/fft_stage_3.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/tb/TB_fft_stage_3.vhdl

vsim -t ns work.TB_fft_stage_3

add wave -radix unsigned -position end  -noupdate -divider {FIRST EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res0
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res1
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res2
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res3
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res4
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res5
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res6
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res7
add wave -radix unsigned -position end  -noupdate -divider {SECOND EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res8
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res9
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res10
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res11
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res12
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res13
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res14
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res15
add wave -radix unsigned -position end  -noupdate -divider {THIRD EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res16
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res17
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res18
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res19
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res20
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res21
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res22
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res23
add wave -radix unsigned -position end  -noupdate -divider {FOURTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res24
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res25
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res26
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res27
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res28
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res29
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res30
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res31
add wave -radix unsigned -position end  -noupdate -divider {FIFTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res32
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res33
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res34
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res35
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res36
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res37
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res38
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res39
add wave -radix unsigned -position end  -noupdate -divider {SIXTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res40
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res41
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res42
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res43
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res44
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res45
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res46
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res47
add wave -radix unsigned -position end  -noupdate -divider {SEVENTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res48
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res49
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res50
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res51
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res52
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res53
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res54
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res55
add wave -radix unsigned -position end  -noupdate -divider {EIGHT EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res56
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res57
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res58
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res59
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res60
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res61
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res62
add wave -radix unsigned -position end  sim:/TB_fft_stage_3/res63

run 300 ns
