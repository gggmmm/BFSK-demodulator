vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/max_of_Rs.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/tb/tb_max_of_Rs.vhdl

vsim -t ns work.tb_max_of_Rs

do waves_tb_max_of_Rs.tcl

run 400 ns
