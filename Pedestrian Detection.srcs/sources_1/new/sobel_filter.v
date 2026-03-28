`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 00:33:01
// Design Name: 
// Module Name: sobel_filter
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


module sobel_filter(
    input clk,
    input valid_in,

    input [7:0] p1,p2,p3,
    input [7:0] p4,p5,p6,
    input [7:0] p7,p8,p9,

    output reg signed [10:0] gx,
    output reg signed [10:0] gy,
    output reg [10:0] edge_mag,
    output reg valid_out
);

reg signed [10:0] gx_temp;
reg signed [10:0] gy_temp;

reg [10:0] abs_gx;
reg [10:0] abs_gy;

always @(posedge clk) begin

    if(valid_in) begin

        gx_temp = (p3 + (p6<<1) + p9) - (p1 + (p4<<1) + p7);
        gy_temp = (p7 + (p8<<1) + p9) - (p1 + (p2<<1) + p3);

        gx <= gx_temp;
        gy <= gy_temp;

        abs_gx = (gx_temp < 0) ? -gx_temp : gx_temp;
        abs_gy = (gy_temp < 0) ? -gy_temp : gy_temp;

         edge_mag <= (gx[10] ? -gx : gx) + (gy[10] ? -gy : gy);

        valid_out <= 1;

    end
    else
        valid_out <= 0;

end

endmodule
 
