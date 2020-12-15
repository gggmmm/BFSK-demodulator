vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/tb/TB_signed_adder_12.vhdl

vsim -t ns work.tb_signed_adder_12

add wave -radix unsigned -position end  sim:/tb_signed_adder_12/op1
add wave -radix unsigned -position end  sim:/tb_signed_adder_12/op2
add wave -radix unsigned -position end  sim:/tb_signed_adder_12/res

run 1000 ns
