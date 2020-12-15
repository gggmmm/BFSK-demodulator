vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/R.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/tb/tb_R.vhdl

vsim -t ns work.tb_R

#do waves_tb_maxs.tcl

run 400 ns
