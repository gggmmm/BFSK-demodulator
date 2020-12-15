vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/sign_inverter_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_8_n.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/tb/TB_butterfly_8_n.vhdl

vsim -t ns work.TB_butterfly_8_n

add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res1
add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res2
add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res3
add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res4
add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res5
add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res6
add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res7
add wave -radix unsigned -position end  sim:/tb_butterfly_8_n/res8

run 400 ns
