`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 02:29:28
// Design Name: 
// Module Name: detection_filter
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


 module detection_filter(

    input clk,
    input detect_in,

    output reg detect_out

);

reg [7:0] counter = 0;

always @(posedge clk) begin

    if(detect_in)
        counter <= counter + 1;
    else
        counter <= 0;

    if(counter > 8)
        detect_out <= 1;
    else
        detect_out <= 0;

end

endmodule
