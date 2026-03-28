`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 19:52:53
// Design Name: 
// Module Name: edge_detector
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


 
module edge_detector(
    input  wire       clk,
    input  wire       rst_n,      // Added reset
    input  wire [7:0] pixel,
    input  wire       valid_in,
    output reg  [7:0] edge_val,   // Renamed to avoid keyword conflict
    output reg        valid_out
);

    reg [7:0] prev_pixel;
    reg       first_pixel_done;   // Tracks valid state of prev_pixel

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            prev_pixel       <= 8'd0;
            edge_val         <= 8'd0;
            valid_out        <= 1'b0;
            first_pixel_done <= 1'b0;
        end else begin
            if (valid_in) begin
                prev_pixel <= pixel;
                
                // Only assert valid_out if prev_pixel holds actual image data
                if (first_pixel_done) begin
                    edge_val  <= (pixel > prev_pixel) ? (pixel - prev_pixel) : (prev_pixel - pixel);
                    valid_out <= 1'b1;
                end else begin
                    valid_out        <= 1'b0;
                    first_pixel_done <= 1'b1; 
                end
            end else begin
                valid_out <= 1'b0;
            end
        end
    end

endmodule
