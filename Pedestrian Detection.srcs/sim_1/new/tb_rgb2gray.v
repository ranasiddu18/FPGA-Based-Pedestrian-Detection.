`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 14:12:28
// Design Name: 
// Module Name: tb_rgb2gray
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


module tb_rgb2gray();
reg clk;
    reg rst;
    reg [7:0] r_in, g_in, b_in;
    reg data_valid_in;
    
    wire [7:0] gray_out;
    wire data_valid_out;

    // Instantiate the Unit Under Test (UUT)
    rgb2gray uut (
        .clk(clk),
        .rst(rst),
        .r_in(r_in),
        .g_in(g_in),
        .b_in(b_in),
        .data_valid_in(data_valid_in),
        .gray_out(gray_out),
        .data_valid_out(data_valid_out)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // File I/O variables
    integer file_in, file_out, status;
    reg [23:0] rgb_pixel; // 24-bit combined RGB

    initial begin
        // Initialize Inputs
        rst = 1;
        r_in = 0; g_in = 0; b_in = 0;
        data_valid_in = 0;

        // Open files (You must create 'input_image.hex' in your simulation directory)
        // Format of input_image.hex should be 6-digit hex per line: RRGGBB
        file_in = $fopen("input_image.hex", "r");
        file_out = $fopen("output_image.hex", "w");

        if (file_in == 0) begin
            $display("Error: Could not open input_image.hex. Creating dummy data...");
            // Fallback if file doesn't exist to prevent simulation crash
            #20 rst = 0;
            
            // Test Case 1: Pure Red
            @(posedge clk); data_valid_in=1; r_in=255; g_in=0; b_in=0;
            // Test Case 2: Pure Green
            @(posedge clk); data_valid_in=1; r_in=0; g_in=255; b_in=0;
            // Test Case 3: Pure Blue
            @(posedge clk); data_valid_in=1; r_in=0; g_in=0; b_in=255;
            // Test Case 4: White
            @(posedge clk); data_valid_in=1; r_in=255; g_in=255; b_in=255;
            
            @(posedge clk); data_valid_in=0;
            #50 $finish;
        end else begin
            // Wait for global reset
            #20 rst = 0;

            // Read from file and push to module
            while (!$feof(file_in)) begin
                @(posedge clk);
                status = $fscanf(file_in, "%h\n", rgb_pixel);
                if (status == 1) begin
                    r_in = rgb_pixel[23:16];
                    g_in = rgb_pixel[15:8];
                    b_in = rgb_pixel[7:0];
                    data_valid_in = 1;
                end
            end
            
            @(posedge clk);
            data_valid_in = 0;
            
            // Wait for pipeline to empty
            #20; 
            $fclose(file_in);
            $fclose(file_out);
            $display("Simulation Complete.");
            $finish;
        end
    end

    // Write output to file when valid
    always @(posedge clk) begin
        if (data_valid_out && file_out != 0) begin
            $fwrite(file_out, "%h\n", gray_out);
        end
    end
endmodule
