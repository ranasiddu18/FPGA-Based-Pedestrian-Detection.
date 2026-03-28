`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 02:24:54
// Design Name: 
// Module Name: camera_clock
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


module camera_clock(
    input clk,
    output xclk
);

reg [1:0] div = 0;

always @(posedge clk)
    div <= div + 1;

assign xclk = div[1];

endmodule
