`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 01:46:32
// Design Name: 
// Module Name: pipeline_reg
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


module pipeline_reg #(
    parameter WIDTH = 8
)(
    input clk,
    input valid_in,
    input [WIDTH-1:0] data_in,

    output reg valid_out,
    output reg [WIDTH-1:0] data_out
);

always @(posedge clk) begin
    data_out  <= data_in;
    valid_out <= valid_in;
end

endmodule
