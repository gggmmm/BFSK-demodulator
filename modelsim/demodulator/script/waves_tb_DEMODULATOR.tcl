onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_demodulator/dut/clock
add wave -noupdate -radix unsigned /tb_demodulator/dut/reset
add wave -noupdate -radix unsigned /tb_demodulator/dut/sample
add wave -noupdate -radix unsigned /tb_demodulator/sample_counter
add wave -noupdate -radix unsigned /tb_demodulator/dut/packet_completed
add wave -noupdate -radix unsigned /tb_demodulator/dut/bit_stream
add wave -noupdate -radix unsigned /tb_demodulator/dut/new_bit
add wave -noupdate -radix unsigned /tb_demodulator/dut/new_sample
add wave -noupdate -radix unsigned /tb_demodulator/dut/start_preamble_detector
add wave -noupdate -radix unsigned /tb_demodulator/dut/output_pd
add wave -noupdate -radix unsigned /tb_demodulator/dut/start_data_detection
add wave -noupdate -radix unsigned /tb_demodulator/dut/output_dd
add wave -noupdate -radix unsigned /tb_demodulator/dut/input_data_ready
add wave -noupdate -radix unsigned /tb_demodulator/dut/waiting_for_data
add wave -noupdate -radix unsigned /tb_demodulator/dut/input_preamble_detector
add wave -noupdate -radix unsigned /tb_demodulator/dut/done_preamble_detector
add wave -noupdate -radix unsigned /tb_demodulator/dut/out_delaysel
add wave -noupdate -radix unsigned /tb_demodulator/dut/out_binHigh
add wave -noupdate -radix unsigned /tb_demodulator/dut/out_binLow
add wave -noupdate -radix unsigned /tb_demodulator/dut/REG_delaysel
add wave -noupdate -radix unsigned /tb_demodulator/dut/REG_binHigh
add wave -noupdate -radix unsigned /tb_demodulator/dut/REG_binLow
add wave -noupdate -radix unsigned /tb_demodulator/dut/input_data_detection
add wave -noupdate -radix unsigned /tb_demodulator/dut/output_data_detection
add wave -noupdate -radix unsigned /tb_demodulator/dut/done_data_detection
add wave -noupdate -radix unsigned /tb_demodulator/dut/counter
add wave -noupdate -divider {DD acquisition}
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/clock
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/reset
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/new_sample
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/sample
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/delaysel
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/enable
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/start_data_detection
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/output
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/done
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/ps
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/cs
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/ns
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/samples_container
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/counter8
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/counterSymbols
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/delayselCounter
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/REG_delaysel
add wave -noupdate -divider {DATA DETECTION}
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/clock
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/reset
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/start
add wave -noupdate -radix unsigned -childformat {{/tb_demodulator/dut/data_detection_unit/input(0) -radix unsigned} {/tb_demodulator/dut/data_detection_unit/input(1) -radix unsigned} {/tb_demodulator/dut/data_detection_unit/input(2) -radix unsigned} {/tb_demodulator/dut/data_detection_unit/input(3) -radix unsigned} {/tb_demodulator/dut/data_detection_unit/input(4) -radix unsigned} {/tb_demodulator/dut/data_detection_unit/input(5) -radix unsigned} {/tb_demodulator/dut/data_detection_unit/input(6) -radix unsigned} {/tb_demodulator/dut/data_detection_unit/input(7) -radix unsigned}} -expand -subitemconfig {/tb_demodulator/dut/data_detection_unit/input(0) {-height 16 -radix unsigned} /tb_demodulator/dut/data_detection_unit/input(1) {-height 16 -radix unsigned} /tb_demodulator/dut/data_detection_unit/input(2) {-height 16 -radix unsigned} /tb_demodulator/dut/data_detection_unit/input(3) {-height 16 -radix unsigned} /tb_demodulator/dut/data_detection_unit/input(4) {-height 16 -radix unsigned} /tb_demodulator/dut/data_detection_unit/input(5) {-height 16 -radix unsigned} /tb_demodulator/dut/data_detection_unit/input(6) {-height 16 -radix unsigned} /tb_demodulator/dut/data_detection_unit/input(7) {-height 16 -radix unsigned}} /tb_demodulator/dut/data_detection_unit/input
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/binHigh
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/binLow
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/output
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/done
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/output_grzH
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/output_grzL
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/xn
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/done_grzH
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/done_grzL
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/REG_out_grzH
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/REG_out_grzL
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/out_mag_grzH
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/out_mag_grzL
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/REG_mag_grzH
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/REG_mag_grzL
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/done_mag0
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/done_mag1
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/counter
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/ps
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/cs
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/ns
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/start_GRZ
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/start_MAG
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/S_IDLE
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/S_FEED_GRZ
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/S_FEED_GRZ_W
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/S_GOERTZEL
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/S_MAGNITUDE
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_detection_unit/S_COMPARE
add wave -noupdate -divider {PD acquisition}
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/clock
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/reset
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/new_sample
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/sample
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/enable
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/start_preamble_detector
add wave -noupdate -radix unsigned -childformat {{/tb_demodulator/dut/data_acquisition_unit/pd_da/output(0) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(1) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(2) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(3) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(4) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(5) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(6) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(7) -radix unsigned}} -subitemconfig {/tb_demodulator/dut/data_acquisition_unit/pd_da/output(0) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/pd_da/output(1) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/pd_da/output(2) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/pd_da/output(3) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/pd_da/output(4) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/pd_da/output(5) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/pd_da/output(6) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/pd_da/output(7) {-height 16 -radix unsigned}} /tb_demodulator/dut/data_acquisition_unit/pd_da/output
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/done
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/counter_i
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/counter_j
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/samples_container
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/place_index
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/cs
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/ns
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/pd_da/ps
add wave -noupdate -divider {PREAMBLE DETECTOR}
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/clock
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/reset
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/start
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/input
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/input_data_ready
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/done
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/delaysel
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/binHigh
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/binLow
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/waiting_for_data
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/ns
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/cs
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/ps
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/i_counter
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/j_counter
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_IDLE
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_EOA
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_INCR_i
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_INCR_j
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_WAIT_FOR_DATA
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_MAXS
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_R
add wave -noupdate -radix unsigned /tb_demodulator/dut/preamble_detector_unit/S_MOR
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/clock
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/reset
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/new_sample
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/sample
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/delaysel
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/enable
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/start_data_detection
add wave -noupdate -radix unsigned -childformat {{/tb_demodulator/dut/data_acquisition_unit/dd_da/output(0) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(1) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(2) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(3) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(4) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(5) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(6) -radix unsigned} {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(7) -radix unsigned}} -expand -subitemconfig {/tb_demodulator/dut/data_acquisition_unit/dd_da/output(0) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/dd_da/output(1) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/dd_da/output(2) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/dd_da/output(3) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/dd_da/output(4) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/dd_da/output(5) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/dd_da/output(6) {-height 16 -radix unsigned} /tb_demodulator/dut/data_acquisition_unit/dd_da/output(7) {-height 16 -radix unsigned}} /tb_demodulator/dut/data_acquisition_unit/dd_da/output
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/done
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/ps
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/cs
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/ns
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/samples_container
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/counter8
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/counterSymbols
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/delayselCounter
add wave -noupdate -radix unsigned /tb_demodulator/dut/data_acquisition_unit/dd_da/REG_delaysel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2390650 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 446
configure wave -valuecolwidth 168
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
WaveRestoreZoom {0 ns} {2520042 ns}
