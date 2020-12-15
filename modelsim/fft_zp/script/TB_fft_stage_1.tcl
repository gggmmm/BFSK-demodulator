vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/mult12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_mult_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_multiplier_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/sign_inverter_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/fft_stage_1.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/tb/TB_fft_stage_1.vhdl

vsim -t ns work.TB_fft_stage_1

add wave -radix unsigned -position end  -noupdate -divider {FIRST EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res0
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res1
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res2
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res3
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res4
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res5
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res6
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/res7
add wave -radix unsigned -position end  -noupdate -divider {SECOND EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resA
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resB
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resC
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resD
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resE
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resF
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resG
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resH
add wave -radix unsigned -position end  -noupdate -divider {THIRD EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resI
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resJ
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resK
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resL
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resM
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resN
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resO
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resP
add wave -radix unsigned -position end  -noupdate -divider {FOURTH EIGHT}
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resQ
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resR
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resS
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resT
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resU
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resV
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resW
add wave -radix unsigned -position end  sim:/TB_fft_stage_1/resX

run 300 ns
