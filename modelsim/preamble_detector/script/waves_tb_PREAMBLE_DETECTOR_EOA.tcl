onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/clock
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/reset
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/input
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/start
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/dest_reg
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/odd_or_even
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_0o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_1o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_2o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_3o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_0e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_1e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_2e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/output_3e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/done
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_0o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_1o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_2o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_3o
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_0e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_1e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_2e
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/REGS_output_3e
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
add wave -noupdate -divider {BOA IN}
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/clock
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/reset
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/input1
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/input2
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/start
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/done
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/output
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/adders_out
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/ns
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/cs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/BOA/ps
add wave -noupdate -divider STATE
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/ps
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/cs
add wave -noupdate -radix unsigned /tb_preamble_detector/dut/EOA/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {470 ns} 0}
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
WaveRestoreZoom {0 ns} {10518 ns}
