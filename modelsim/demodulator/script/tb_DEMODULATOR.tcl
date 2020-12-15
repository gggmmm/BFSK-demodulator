vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/my_package.vhdl

# data acquisition
# DATA DETECTION
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/dd_data_acquisition.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/tb/tb_dd_data_acquisition.vhdl

# PREAMBLE DETECTION
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/pd_data_acquisition.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/tb/tb_pd_data_acquisition.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/data_acquisition/data_acquisition.vhdl

# preamble detector
# ==== FFT_ZP ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/compare12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_adder_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/mult12.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/signed_mult_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_multiplier_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complex_adder_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/sign_inverter_12.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/complexity_and_sign_inverter_12.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_2_n.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_2_tw.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_4_n.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_4_tw.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_8_n.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/butterfly_8_tw.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/fft_stage_1.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/fft_stage_2.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/fft_stage_3.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/fft_stage_4.vhdl

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/fft_zp/FFT_ZP.vhdl

# ==== BANK OF MAGNITUDE ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/square12bit.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add20.vhd
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/sqrt20bit.vhd

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/magnitude.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/bank_of_magnitude.vhdl

# ==== BANK OF ADDERS ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/IP/add_sub12.vhd

vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/bank_of_adders.vhdl

# ==== EVEN ODD ACCUMULATOR ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/even_odd_accumulator.vhdl

# ==== MAXS ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/max_finder64.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/maxs.vhdl

# ==== R ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/R.vhdl

# ==== MAX OF Rs ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/max_of_Rs.vhdl

# ==== PREAMBLE_DETECTOR ====
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/preamble_detector/PREAMBLE_DETECTOR.vhdl

# DATA DETECTION
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

# DEMODULATOR
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/demodulator/DEMODULATOR.vhdl
vcom -work work -2002 -explicit -stats=none /home/giovanni/Desktop/modelsim/demodulator/tb/tb_DEMODULATOR.vhdl

vsim -t ns work.tb_DEMODULATOR

do waves_tb_DEMODULATOR.tcl

run 2700 us
