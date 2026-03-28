`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 20:42:56
// Design Name: 
// Module Name: ov7670_config
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


  module ov7670_config(

input clk,
output reg sioc,
inout wire siod,
output reg config_done

);

// OV7670 write address
localparam DEV_ADDR = 8'h42;

// ROM: register + value pairs
reg [15:0] rom [0:15];

initial begin
    rom[0]  = 16'h1280; // reset
    rom[1]  = 16'h1204; // RGB
    rom[2]  = 16'h40D0; // RGB565
    rom[3]  = 16'h1101; // clock prescaler
    rom[4]  = 16'h0C00;
    rom[5]  = 16'h3E00;
    rom[6]  = 16'h8C00;
    rom[7]  = 16'h0400;
    rom[8]  = 16'h4030;
    rom[9]  = 16'h1418;
    rom[10] = 16'h4F80;
    rom[11] = 16'h5030;
    rom[12] = 16'h5100;
    rom[13] = 16'h5222;
    rom[14] = 16'h535E;
    rom[15] = 16'h5480;
end

// clock divider (~100kHz SCCB)
reg [15:0] clk_div = 0;
reg sclk = 0;

always @(posedge clk) begin
    clk_div <= clk_div + 1;
    if(clk_div == 500) begin
        clk_div <= 0;
        sclk <= ~sclk;
    end
end

// state machine
reg [4:0] rom_addr = 0;
reg [7:0] data;
reg [3:0] bit_cnt;
reg [3:0] state;

reg siod_out;
reg siod_oe;

assign siod = siod_oe ? siod_out : 1'bz;

always @(posedge sclk) begin

    case(state)

    // START condition
    0: begin
        siod_oe <= 1;
        siod_out <= 1;
        sioc <= 1;
        state <= 1;
    end

    1: begin
        siod_out <= 0;
        state <= 2;
    end

    // send device address
    2: begin
        data <= DEV_ADDR;
        bit_cnt <= 7;
        state <= 3;
    end

    3: begin
        sioc <= 0;
        siod_out <= data[bit_cnt];
        state <= 4;
    end

    4: begin
        sioc <= 1;
        if(bit_cnt == 0)
            state <= 5;
        else begin
            bit_cnt <= bit_cnt - 1;
            state <= 3;
        end
    end

    // send register address
    5: begin
        data <= rom[rom_addr][15:8];
        bit_cnt <= 7;
        state <= 6;
    end

    6: begin
        sioc <= 0;
        siod_out <= data[bit_cnt];
        state <= 7;
    end

    7: begin
        sioc <= 1;
        if(bit_cnt == 0)
            state <= 8;
        else begin
            bit_cnt <= bit_cnt - 1;
            state <= 6;
        end
    end

    // send register value
    8: begin
        data <= rom[rom_addr][7:0];
        bit_cnt <= 7;
        state <= 9;
    end

    9: begin
        sioc <= 0;
        siod_out <= data[bit_cnt];
        state <= 10;
    end

    10: begin
        sioc <= 1;
        if(bit_cnt == 0)
            state <= 11;
        else begin
            bit_cnt <= bit_cnt - 1;
            state <= 9;
        end
    end

    // STOP condition
    11: begin
        sioc <= 1;
        siod_out <= 0;
        state <= 12;
    end

    12: begin
        siod_out <= 1;

        if(rom_addr == 15) begin
            config_done <= 1;
            state <= 13;
        end
        else begin
            rom_addr <= rom_addr + 1;
            state <= 0;
        end
    end

    // DONE
    13: begin
        siod_oe <= 0;
        sioc <= 1;
    end

    endcase
end

endmodule
