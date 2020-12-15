vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

# PREAMBLE DETECTION
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/pd_data_acquisition.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/tb/tb_pd_data_acquisition.vhdl

vsim -t ns work.tb_pd_data_acquisition

do waves_tb_pd_data_acquisition.tcl

run 60000 ns
