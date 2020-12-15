vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/square12bit.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add20.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/sqrt20bit.vhd

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/magnitude.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/bank_of_magnitude.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/tb/tb_bank_of_magnitude.vhdl

vsim -t ns work.tb_bank_of_magnitude

do waves_tb_bank_of_magnitude.tcl

run 400 ns
