`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 01:39:32
// Design Name: 
// Module Name: frame_counter
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


module frame_counter(

    input clk,
    input pixel_valid,

    output reg frame_start

);

reg [16:0] count = 0;

always @(posedge clk) begin

    frame_start <= 0;

    if(pixel_valid) begin

        if(count == 17'd76799) begin
            count <= 0;
            frame_start <= 1;
        end
        else
            count <= count + 1;

    end

end

endmodule
