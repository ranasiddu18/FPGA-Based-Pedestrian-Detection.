`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 00:35:59
// Design Name: 
// Module Name: hog_histogram
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


 module hog_histogram(

    input clk,
    input reset_hist,
    input valid_in,
    input [2:0] bin,

    output reg [7:0] h0,h1,h2,h3,h4,h5,h6,h7,
    output reg [7:0] h8,h9,h10,h11,h12,h13,h14,h15
);

always @(posedge clk) begin

     if(reset_hist) begin
    h0<=0;h1<=0;h2<=0;h3<=0;
    h4<=0;h5<=0;h6<=0;h7<=0;
    h8<=0;h9<=0;h10<=0;h11<=0;
    h12<=0;h13<=0;h14<=0;h15<=0;
end

    else if(valid_in) begin
        case(bin)
    3'd0: if(h0 < 8'd100) h0 <= h0 + 1;
    3'd1: if(h1 < 8'd100) h1 <= h1 + 1;
    3'd2: if(h2 < 8'd100) h2 <= h2 + 1;
    3'd3: if(h3 < 8'd100) h3 <= h3 + 1;
    3'd4: if(h4 < 8'd100) h4 <= h4 + 1;
    3'd5: if(h5 < 8'd100) h5 <= h5 + 1;
    3'd6: if(h6 < 8'd100) h6 <= h6 + 1;
    3'd7: if(h7 < 8'd100) h7 <= h7 + 1;
endcase
    end

end

endmodule
