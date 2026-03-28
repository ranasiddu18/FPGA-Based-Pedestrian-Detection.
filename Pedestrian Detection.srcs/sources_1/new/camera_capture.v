`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 08:28:15
// Design Name: 
// Module Name: camera_capture
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


 module camera_capture(

input pclk,
input vsync,
input href,
input [7:0] cam_data,

output reg [15:0] pixel,
output reg valid

);

reg byte_toggle;

always @(posedge pclk) begin

    if(vsync) begin
        byte_toggle <= 0;
        valid <= 0;
    end

    else if(href) begin
        byte_toggle <= ~byte_toggle;

        if(byte_toggle) begin
            pixel[7:0] <= cam_data;
            valid <= 1;
        end
        else begin
            pixel[15:8] <= cam_data;
            valid <= 0;
        end
    end
end

endmodule
