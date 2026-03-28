`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 00:34:55
// Design Name: 
// Module Name: orientation_bin
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


 module orientation_bin(
    input clk,
    input valid_in,
    input signed [10:0] gx,
    input signed [10:0] gy,
    output reg [2:0] bin,
    output reg valid_out
);

reg signed [10:0] abs_gx, abs_gy;

always @(posedge clk) begin
    if(valid_in) begin
        abs_gx <= (gx < 0) ? -gx : gx;
        abs_gy <= (gy < 0) ? -gy : gy;

        // approximate orientation bins
        if(abs_gx > abs_gy*2)
            bin <= 3'd0;      // ~0°
        else if(abs_gx > abs_gy)
            bin <= (gy >= 0) ? 3'd1 : 3'd7;
        else if(abs_gy > abs_gx*2)
            bin <= (gy >= 0) ? 3'd2 : 3'd6;
        else
            bin <= (gx >= 0) ? 3'd3 : 3'd5;

        valid_out <= 1'b1;
    end
    else
        valid_out <= 1'b0;
end

endmodule
 