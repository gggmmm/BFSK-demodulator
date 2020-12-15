onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/clock
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/reset
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/new_sample
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/sample
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/delaysel
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/enable
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/start_data_detection
add wave -noupdate -radix unsigned -childformat {{/tb_dd_data_acquisition/dut/output(0) -radix unsigned} {/tb_dd_data_acquisition/dut/output(1) -radix unsigned} {/tb_dd_data_acquisition/dut/output(2) -radix unsigned} {/tb_dd_data_acquisition/dut/output(3) -radix unsigned} {/tb_dd_data_acquisition/dut/output(4) -radix unsigned} {/tb_dd_data_acquisition/dut/output(5) -radix unsigned} {/tb_dd_data_acquisition/dut/output(6) -radix unsigned} {/tb_dd_data_acquisition/dut/output(7) -radix unsigned}} -expand -subitemconfig {/tb_dd_data_acquisition/dut/output(0) {-height 16 -radix unsigned} /tb_dd_data_acquisition/dut/output(1) {-height 16 -radix unsigned} /tb_dd_data_acquisition/dut/output(2) {-height 16 -radix unsigned} /tb_dd_data_acquisition/dut/output(3) {-height 16 -radix unsigned} /tb_dd_data_acquisition/dut/output(4) {-height 16 -radix unsigned} /tb_dd_data_acquisition/dut/output(5) {-height 16 -radix unsigned} /tb_dd_data_acquisition/dut/output(6) {-height 16 -radix unsigned} /tb_dd_data_acquisition/dut/output(7) {-height 16 -radix unsigned}} /tb_dd_data_acquisition/dut/output
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/done
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/ps
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/cs
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/ns
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/samples_container
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/counter8
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/delayselCounter
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/REG_delaysel
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/FSM_size
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/S_IDLE
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/S_PLACE
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/S_C8_INCR
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/S_WAIT_SAMPLE
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/S_DELAYSEL_WAIT
add wave -noupdate -radix unsigned /tb_dd_data_acquisition/dut/S_COUNTER_RED
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8199870 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 350
configure wave -valuecolwidth 164
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
WaveRestoreZoom {375275 ns} {375407 ns}
