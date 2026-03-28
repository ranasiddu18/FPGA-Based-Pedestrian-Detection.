`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 20:40:28
// Design Name: 
// Module Name: rgb_to_gray
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


 module rgb_to_gray(

input clk,
input [15:0] pixel_in,
input valid_in,

output reg [7:0] gray,
output reg valid_out

);

wire [4:0] r = pixel_in[15:11];
wire [5:0] g = pixel_in[10:5];
wire [4:0] b = pixel_in[4:0];

always @(posedge clk)
begin
    gray <= (r<<1) + (r<<2) + (g<<4) + (g<<2) + (b<<1);
gray <= gray >> 6;
    valid_out <= valid_in;
end

endmodule
