`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 14:10:24
// Design Name: 
// Module Name: rgb2gray
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


module rgb2gray (
    input wire clk,
    input wire rst,
    input wire [7:0] r_in,
    input wire [7:0] g_in,
    input wire [7:0] b_in,
    input wire data_valid_in,  // High when input pixels are valid
    
    output reg [7:0] gray_out,
    output reg data_valid_out  // High when output pixel is ready
);

    // Internal registers for pipelining (1 clock cycle latency)
    reg [15:0] gray_sum;
    reg valid_pipeline;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            gray_sum <= 16'd0;
            gray_out <= 8'd0;
            valid_pipeline <= 1'b0;
            data_valid_out <= 1'b0;
        end else begin
            // Stage 1: Multiply and accumulate
            if (data_valid_in) begin
                // 77*R + 150*G + 29*B
                gray_sum <= (r_in * 8'd77) + (g_in * 8'd150) + (b_in * 8'd29);
                valid_pipeline <= 1'b1;
            end else begin
                valid_pipeline <= 1'b0;
            end

            // Stage 2: Shift (divide by 256) and output
            if (valid_pipeline) begin
                gray_out <= gray_sum[15:8]; // This is equivalent to shifting right by 8
                data_valid_out <= 1'b1;
            end else begin
                data_valid_out <= 1'b0;
            end
        end
    end

endmodule
