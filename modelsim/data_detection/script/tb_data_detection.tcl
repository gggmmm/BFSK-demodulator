vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

# GOERTZEL
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

# MAGNITUDE GRZ
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/square12bit.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add24.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/sqrt16.vhd

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_detection/magnitude_grz.vhdl

# DATA DETECTION
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_detection/data_detection.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_detection/tb/tb_data_detection.vhdl

vsim -t ns work.tb_data_detection

do waves_tb_data_detection.tcl

run 60000 ns
