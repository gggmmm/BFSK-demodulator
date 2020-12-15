vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/mult12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_mult_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_multiplier_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_adder_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/goertzel/wkn_selector.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/goertzel/factor_selector.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/goertzel/cos_term_selector.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/goertzel/goertzel.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/goertzel/tb/TB_GOERTZEL.vhdl

vsim -t ns work.TB_GOERTZEL

do /home/giovanni/Desktop/modelsim/goertzel/script/waves_TB_GOERTZEL.tcl

run 3500 ns;
