`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 11:16:17
// Design Name: 
// Module Name: oled_task
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


module oled_indiv_task(
    input clock, input [15:0] sw,
    output [7:0] JC
    );

    wire clk6p25m;
    // Can change to use common clock divider
    clk_divider D_clk (.CLK(clock), .n(7), .clock_out(clk6p25m));

    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index; // Goes from 0 to 6143
    wire [15:0] oled_data;
    wire [6:0] x, y;

    Oled_Display D_Oled (.clk(clk6p25m), .reset(0),
    .frame_begin(frame_begin), .sending_pixels(sending_pixels), .sample_pixel(sample_pixel),
    .pixel_index(pixel_index), .pixel_data(oled_data),
    .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), .pmoden(JC[7]));
    
    pixel_index_to_xy xyconvert (.pixel_index(pixel_index), .x(x), .y(y));

    display_task D_task (.x(x), .y(y), .sw(sw[8:4]), .oled_data(oled_data));
endmodule
