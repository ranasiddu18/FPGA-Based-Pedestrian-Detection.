`timescale 1ns / 1ps  
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 20:12:48
// Design Name: 
// Module Name: pedestrian_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

 module pedestrian_top(

input clk,

// Camera interface
input ov7670_pclk,
input ov7670_vsync,
input ov7670_href,
input [7:0] ov7670_data,

output ov7670_xclk,
output ov7670_sioc,
inout ov7670_siod,
output ov7670_reset,
output ov7670_pwdn,

output detected

);

// ================= CLOCK =================
 wire cam_xclk;
wire locked;

clk_wiz_0 clk_inst (
    .clk_in1(clk),
    .clk_out1(cam_xclk),
     .reset(1'b0), 
    .locked(locked)
);

// Drive camera clock
assign ov7670_xclk = cam_xclk;

// Camera control using locked
assign ov7670_reset = locked;   // only release reset when clock stable
assign ov7670_pwdn  = 0;

 
wire config_done;
ov7670_config CONFIG(
    .clk(locked ? clk : 1'b0),
    .sioc(ov7670_sioc),
    .siod(ov7670_siod),
    .config_done(config_done)
);
 
 

// ================= CAMERA CAPTURE =================
wire [15:0] cam_pixel;
wire cam_valid;

camera_capture CAM(
    .pclk(ov7670_pclk),
    .vsync(ov7670_vsync),
    .href(ov7670_href),
    .cam_data(ov7670_data),
    .pixel(cam_pixel),
    .valid(cam_valid)
);

// ================= FIFO (CDC FIX) =================
wire [15:0] fifo_pixel;
wire fifo_empty;

camera_fifo FIFO(
    .wr_clk(ov7670_pclk),
    .rd_clk(clk),
    .din(cam_pixel),
    .wr_en(cam_valid),
    .rd_en(~fifo_empty),
    .dout(fifo_pixel),
    .empty(fifo_empty)
);

// ================= GRAYSCALE =================
wire [7:0] gray_pixel;
wire gray_valid;

rgb_to_gray GRAY(
    .clk(clk),
    .pixel_in(fifo_pixel),
    .valid_in(~fifo_empty),
    .gray(gray_pixel),
    .valid_out(gray_valid)
);

// ================= LINE BUFFER =================
wire [7:0] p1,p2,p3,p4,p5,p6,p7,p8,p9;
wire lb_valid;

line_buffer LB(
    .clk(clk),
    .pixel_in(gray_pixel),
    .valid_in(gray_valid),
    .p1(p1), .p2(p2), .p3(p3),
    .p4(p4), .p5(p5), .p6(p6),
    .p7(p7), .p8(p8), .p9(p9),
    .valid_out(lb_valid)
);

// ================= SOBEL =================
wire signed [10:0] gx, gy;
wire [10:0] edge_mag;
wire sobel_valid;

sobel_filter SOBEL(
    .clk(clk),
    .valid_in(lb_valid),
    .p1(p1), .p2(p2), .p3(p3),
    .p4(p4), .p5(p5), .p6(p6),
    .p7(p7), .p8(p8), .p9(p9),
    .gx(gx),
    .gy(gy),
    .edge_mag(edge_mag),
    .valid_out(sobel_valid)
);

// ================= ORIENTATION =================
wire [2:0] bin;
wire ori_valid;

orientation_bin ORI(
    .clk(clk),
    .valid_in(sobel_valid),
    .gx(gx),
    .gy(gy),
    .bin(bin),
    .valid_out(ori_valid)
);

// ================= HOG =================
wire [7:0] h0,h1,h2,h3,h4,h5,h6,h7;
wire [7:0] h8,h9,h10,h11,h12,h13,h14,h15;

wire reset_hist;
wire cell_done;

hog_histogram HOG(
    .clk(clk),
    .valid_in(ori_valid),
    .bin(bin),
    .reset_hist(reset_hist),
    .h0(h0), .h1(h1), .h2(h2), .h3(h3),
    .h4(h4), .h5(h5), .h6(h6), .h7(h7),
    .h8(h8), .h9(h9), .h10(h10), .h11(h11),
    .h12(h12), .h13(h13), .h14(h14), .h15(h15)
);

// ================= CELL CONTROL =================
hog_cell_controller CELL(
    .clk(clk),
    .valid_in(ori_valid),
    .cell_done(cell_done),
    .reset_hist(reset_hist)
);

// ================= SVM =================
wire svm_detect;

svm_classifier SVM(
    .clk(clk),
    .h0(h0), .h1(h1), .h2(h2), .h3(h3),
    .h4(h4), .h5(h5), .h6(h6), .h7(h7),
    .h8(h8), .h9(h9), .h10(h10), .h11(h11),
    .h12(h12), .h13(h13), .h14(h14), .h15(h15),
    .detected(svm_detect)
);

// ================= FILTER =================
wire filtered_detect;

detection_filter FILTER(
    .clk(clk),
    .detect_in(svm_detect),
    .detect_out(filtered_detect)
);

// ================= FRAME =================
wire frame_start;

frame_counter FC(
    .clk(clk),
    .pixel_valid(gray_valid),
    .frame_start(frame_start)
);

frame_detector FD(
    .clk(clk),
    .detect_in(filtered_detect),
    .frame_start(frame_start),
    .detect_frame(detected)
);

endmodule