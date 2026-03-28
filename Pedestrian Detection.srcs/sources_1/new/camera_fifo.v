`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2026 23:06:27
// Design Name: 
// Module Name: camera_fifo
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


module camera_fifo(

input wr_clk,
input rd_clk,

input [15:0] din,
input wr_en,

input rd_en,

output [15:0] dout,
output empty

);

fifo_generator_0 fifo_inst (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .din(din),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .dout(dout),
    .empty(empty),
    .rst(1'b0) 
);

endmodule