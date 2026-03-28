`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 17:48:12
// Design Name: 
// Module Name: line_buffer_bram
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


 module line_buffer_bram #(parameter IMG_WIDTH = 640, parameter DATA_WIDTH = 8)(
input wire clk,
input wire valid_in,
input wire [DATA_WIDTH-1:0] data_in,
output reg [DATA_WIDTH-1:0] data_out
);

endmodule
