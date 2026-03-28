`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 19:50:46
// Design Name: 
// Module Name: pixel_stream
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



module pixel_stream(
    input clk,
    output reg [7:0] pixel,
    output reg valid
);

reg [7:0] memory [0:4095];
reg [12:0] addr = 0;

initial begin
    $readmemh("person.hex", memory);
end

always @(posedge clk) begin
    pixel <= memory[addr];
    valid <= 1;

    addr <= addr + 1;

    if(addr == 4095)
        addr <= 0;
end
endmodule
