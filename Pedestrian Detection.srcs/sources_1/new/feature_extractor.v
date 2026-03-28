`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 20:07:00
// Design Name: 
// Module Name: feature_extractor
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


    module feature_extractor(
    input wire clk,
    input wire rst_n,          // Added: Active-low reset
    input wire [7:0] edge_val, // Corrected: Renamed from 'edge'
    input wire valid_in,

    output reg feature,
    output reg valid_out
);

parameter THRESHOLD = 8'd10;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        feature   <= 1'b0;
        valid_out <= 1'b0;
    end else if (valid_in) begin
        feature   <= (edge_val > THRESHOLD);
        valid_out <= 1'b1;
    end else begin
        valid_out <= 1'b0;
        feature   <= 1'b0;     // Added: Clears stale data
    end
end

endmodule