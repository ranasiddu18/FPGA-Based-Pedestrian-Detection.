`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 08:46:34
// Design Name: 
// Module Name: hog_cell_controller
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


 module hog_cell_controller(

    input clk,
    input valid_in,

    output reg cell_done,
    output reg reset_hist
);

reg [7:0] pixel_count = 0;

always @(posedge clk) begin

    if(valid_in) begin
        if(pixel_count == 8'd127) begin
            pixel_count <= 0;
            cell_done <= 1;
            reset_hist <= 1;
        end
        else begin
            pixel_count <= pixel_count + 1;
            cell_done <= 0;
            reset_hist <= 1;   // 🔴 KEEP RESET HIGH DURING CELL
        end
    end
    else begin
        reset_hist <= 0;
        cell_done <= 0;
    end

end

endmodule