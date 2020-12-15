vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/sign_inverter_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_2_tw.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/tb/TB_butterfly_2_tw.vhdl

vsim -t ns work.TB_butterfly_2_tw

add wave -radix unsigned -position end  -noupdate -divider {INPUTS}
add wave -radix unsigned -position end  sim:/tb_butterfly_2_tw/op0
add wave -radix unsigned -position end  sim:/tb_butterfly_2_tw/op1
add wave -radix unsigned -position end  -noupdate -divider {RESULTS}
add wave -radix unsigned -position end  sim:/tb_butterfly_2_tw/res0
add wave -radix unsigned -position end  sim:/tb_butterfly_2_tw/res1

run 500 ns
