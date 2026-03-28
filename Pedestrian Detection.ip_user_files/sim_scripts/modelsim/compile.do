vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+../../../../../Mini project/Pedestrian_Detection" "+incdir+../../../../2025.2/Vivado/data/rsb/busdef" "+incdir+../../../Pedestrian Detection.gen/sources_1/ip/clk_wiz_0" \
"C:/vivado/2025.2/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/vivado/2025.2/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/vivado/2025.2/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../../Mini project/Pedestrian_Detection" "+incdir+../../../../2025.2/Vivado/data/rsb/busdef" "+incdir+../../../Pedestrian Detection.gen/sources_1/ip/clk_wiz_0" \
"../../../Pedestrian Detection.srcs/sources_1/new/camera_capture.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/camera_clock.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/detection_filter.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/frame_counter.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/frame_detector.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/hog_cell_controller.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/hog_histogram.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/line_buffer.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/orientation_bin.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/ov7670_config.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/pedestrian_top.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/rgb_to_gray.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/sobel_filter.v" \
"../../../Pedestrian Detection.srcs/sources_1/new/svm_classifier.v" \
"../../../Pedestrian Detection.srcs/sim_1/new/testbench.v" \

vlog -work xil_defaultlib \
"glbl.v"

