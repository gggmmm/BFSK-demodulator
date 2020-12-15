vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/mult12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_mult_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/tb/TB_signed_mult_12.vhdl

vsim -t ns work.tb_signed_mult_12

add wave -radix unsigned -position end  sim:/tb_signed_mult_12/op1
add wave -radix unsigned -position end  sim:/tb_signed_mult_12/op2
add wave -radix unsigned -position end  sim:/tb_signed_mult_12/res

run 800 ns
