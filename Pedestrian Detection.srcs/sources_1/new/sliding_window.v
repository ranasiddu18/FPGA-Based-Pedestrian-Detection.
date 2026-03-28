`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 20:11:06
// Design Name: 
// Module Name: sliding_window
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


 
module sliding_window(
    input clk,
    input feature,
    input valid_in,

    output reg detected
);

reg [7:0] count = 0;

always @(posedge clk) begin
    if(valid_in) begin

        if(feature)
            count <= count + 1;

        if(count > 8'd20)
            detected <= 1;
        else
            detected <= 0;

    end
end

endmodule
    
