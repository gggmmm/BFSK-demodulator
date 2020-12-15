onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_preamble_detector/clock
add wave -noupdate -radix unsigned /tb_preamble_detector/reset
add wave -noupdate -radix unsigned /tb_preamble_detector/start
add wave -noupdate -radix unsigned /tb_preamble_detector/input_data_ready
add wave -noupdate -radix unsigned /tb_preamble_detector/waiting_for_data
add wave -noupdate -radix unsigned /tb_preamble_detector/input
add wave -noupdate -radix unsigned /tb_preamble_detector/done
add wave -noupdate -radix unsigned /tb_preamble_detector/delaysel
add wave -noupdate -radix unsigned /tb_preamble_detector/binHigh
add wave -noupdate -radix unsigned /tb_preamble_detector/binLow
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/ns
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/cs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/ps
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/i_counter
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/j_counter
add wave -noupdate -divider EOA
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/clock
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/reset
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/input
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/start
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/dest_reg
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/odd_or_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/done
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/ns
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/cs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/ps
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_0e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_0o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_1e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_1o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_2e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_2o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_3e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_3o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_4e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_4o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_5e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_5o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_6e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_6o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_7e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_7o
add wave -noupdate -divider FFT
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_FFT
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/start_FFT
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/done_FFT
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_fft
add wave -noupdate -divider BOM
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/input_BOM
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/start_BOM
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_BOM
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/done_BOM
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_BOM
add wave -noupdate -divider BOA
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/input1_BOA
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/input2_BOA
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/start_BOA
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/done_BOA
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_BOA
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_odd_BOA_i0
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_odd_BOA_i1
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_odd_BOA_i2
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_odd_BOA_i3
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_even_BOA_i0
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_even_BOA_i1
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_even_BOA_i2
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/REGS_output_even_BOA_i3
add wave -noupdate -divider MAXs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/input_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/input_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/start
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/done
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/val_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/val_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/max_index_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/max_index_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/val_odd_index_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/val_even_index_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/iinput_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/iinput_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/imax_index_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/max_value_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/done_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/imax_index_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/max_value_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAXSu0/done_even
add wave -noupdate -divider R
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/start
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/max_val_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/max_val_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/val_even_index_odd
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/val_odd_index_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/done
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/result
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/REG_result
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R1/REG_result
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R2/REG_result
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R3/REG_result
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/cs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/ns
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/R0/ps
add wave -noupdate -divider {MAX OF Rs}
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/start
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/R0
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/R1
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/R2
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/R3
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/done
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/result
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/cs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/ns
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/MAX_OF_RSu/ps
add wave -noupdate -divider STATE
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/ps
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/cs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {613 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 528
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1116 ns} {2900 ns}
