`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2026 22:55:09
// Design Name: 
// Module Name: camera_clock_gen
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


module camera_clock_gen(
    input clk,
    output cam_xclk
);

wire clk_out;

clk_wiz_0 clk_inst (
    .clk_in1(clk),
    .clk_out1(clk_out)
);

assign cam_xclk = clk_out;

endmodule
