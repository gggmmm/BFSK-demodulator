vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/square12bit.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add13.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/sqrt14bit.vhd

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_detection/magnitude_grz.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_detection/tb/tb_magnitude_grz.vhdl

vsim -t ns work.tb_magnitude_grz

do waves_tb_magnitude_grz.tcl

run 700 ns
