vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

# DATA DETECTION
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/dd_data_acquisition.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/tb/tb_dd_data_acquisition.vhdl

vsim -t ns work.tb_dd_data_acquisition

do waves_tb_dd_data_acquisition.tcl

run 800000 ns
