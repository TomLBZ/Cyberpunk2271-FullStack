#
# Create work library
#
vlib work
#
# Compile sources
#
vlog  D:/source/repos/_fpga_repos/CyberSynth2271_MIDI/simulation/IO_tb.v
#
# Call vsim to invoke simulator
#
vsim -L  -gui -novopt work.IO_tb
#
# Add waves
#
add wave *
#
# Run simulation
#
run 1000ns
#
# End