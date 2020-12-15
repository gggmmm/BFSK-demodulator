vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/max_finder64.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/tb/tb_max_finder64.vhdl

vsim -t ns work.tb_max_finder64

add wave -position end  sim:/tb_max_finder64/input
add wave -position end  sim:/tb_max_finder64/max_index
add wave -position end  sim:/tb_max_finder64/max_value
add wave -position end  sim:/tb_max_finder64/done

run 400 ns
