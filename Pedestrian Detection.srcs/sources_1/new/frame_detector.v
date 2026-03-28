`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 01:38:00
// Design Name: 
// Module Name: frame_detector
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

 module frame_detector(

    input clk,
    input detect_in,
    input frame_start,

    output reg detect_frame

);

always @(posedge clk) begin

    if(frame_start)
        detect_frame <= 0;

    else if(detect_in)
        detect_frame <= 1;

end

endmodule