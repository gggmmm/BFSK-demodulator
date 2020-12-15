onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/clock
add wave -noupdate /tb_pd_data_acquisition/start_preamble_detector
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/reset
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/new_sample
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/sample
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/output
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/done
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/counter_i
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/counter_j
add wave -noupdate -radix unsigned -childformat {{/tb_pd_data_acquisition/dut/samples_container(0) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(1) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(2) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(3) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(4) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(5) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(6) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(7) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(8) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(9) -radix unsigned} {/tb_pd_data_acquisition/dut/samples_container(10) -radix unsigned}} -expand -subitemconfig {/tb_pd_data_acquisition/dut/samples_container(0) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(1) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(2) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(3) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(4) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(5) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(6) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(7) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(8) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(9) {-height 16 -radix unsigned} /tb_pd_data_acquisition/dut/samples_container(10) {-height 16 -radix unsigned}} /tb_pd_data_acquisition/dut/samples_container
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/place_index
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/cs
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/ns
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/ps
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/FSM_size
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/S_IDLE
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/S_PLACE
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/S_INCR_i
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/S_INCR_j
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/S_WAIT_SAMPLE
add wave -noupdate -radix unsigned /tb_pd_data_acquisition/dut/S_SPECIAL_SHIFT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5422 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 307
configure wave -valuecolwidth 166
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
WaveRestoreZoom {0 ns} {63 us}
