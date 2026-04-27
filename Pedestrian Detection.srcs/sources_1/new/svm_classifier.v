`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 07:03:21
// Design Name: 
// Module Name: svm_classifier
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

  module svm_classifier(

    input clk,

    input [7:0] h0,h1,h2,h3,h4,h5,h6,h7,
    input [7:0] h8,h9,h10,h11,h12,h13,h14,h15,

    output reg detected
);

// Weights
parameter signed w0  = -115;
parameter signed w1  = 18;
parameter signed w2  = 4;
parameter signed w3  = -73;
parameter signed w4  = -37;
parameter signed w5  = 61;
parameter signed w6  = 59;
parameter signed w7  = 166;
parameter signed w8  = -126;
parameter signed w9  = -23;
parameter signed w10 = -42;
parameter signed w11 = 119;
parameter signed w12 = -70;
parameter signed w13 = -31;
parameter signed w14 = 41;
parameter signed w15 = -23;

parameter signed bias = -8;

reg signed [31:0] score, score_next;

// Compute next score (combinational)
always @(*) begin
    score_next =
        w0*h0 + w1*h1 + w2*h2 + w3*h3 +
        w4*h4 + w5*h5 + w6*h6 + w7*h7 +
        w8*h8 + w9*h9 + w10*h10 + w11*h11 +
        w12*h12 + w13*h13 + w14*h14 + w15*h15 +
        bias;
end

// Register + decision
always @(posedge clk) begin
    score <= score_next;
     detected <= (score_next > 0);   // start with 0 threshold
end

endmodule
