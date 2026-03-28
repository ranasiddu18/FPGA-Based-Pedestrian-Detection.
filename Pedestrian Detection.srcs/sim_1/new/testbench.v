`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 20:24:06
// Design Name: 
// Module Name: testbench
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


module testbench();

reg clk;
wire detected;

pedestrian_top DUT(
    .clk(clk),
    .detected(detected)
);

always #5 clk = ~clk;

initial begin
    clk = 0;

    #2000000;

    $finish;
end

endmodule