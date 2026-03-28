`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 00:30:17
// Design Name: 
// Module Name: line_buffer
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


  module line_buffer #(
    parameter WIDTH = 320
)(

    input clk,
    input [7:0] pixel_in,
    input valid_in,

    output reg [7:0] p1,p2,p3,
    output reg [7:0] p4,p5,p6,
    output reg [7:0] p7,p8,p9,

    output reg valid_out
);

// line memories
reg [7:0] line1 [0:WIDTH-1];
reg [7:0] line2 [0:WIDTH-1];

reg [8:0] col = 0;

// shift registers for current row
reg [7:0] r1, r2, r3;

always @(posedge clk) begin

    if(valid_in) begin

        // shift current row pixels
        r1 <= r2;
        r2 <= r3;
        r3 <= pixel_in;

        // assign window
        p1 <= line2[col];
        p2 <= line2[col+1];
        p3 <= line2[col+2];

        p4 <= line1[col];
        p5 <= line1[col+1];
        p6 <= line1[col+2];

        p7 <= r1;
        p8 <= r2;
        p9 <= r3;

        // update line buffers
        line2[col] <= line1[col];
        line1[col] <= pixel_in;

        // column control
        if(col >= WIDTH-3)
            col <= 0;
        else
            col <= col + 1;

        // valid only after pipeline fills
        if(col > 2)
            valid_out <= 1;
        else
            valid_out <= 0;

    end
    else begin
        valid_out <= 0;
    end

end

endmodule