`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 12:26:27
// Design Name: 
// Module Name: init_grp_oled
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


module init_grp_oled(
    input clock,
    input btnU,
    input btnD,
    input [15:0] oled_data_1,
//    input [15:0] oled_data_2,
    output [6:0] x, y,
    output [7:0] JC
    );

    wire clk6p25m;
    clk_divider D_clk (.CLK(clock), .n(7), .clock_out(clk6p25m));

    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index; // Goes from 0 to 6143
    
//    reg [15:0] oled_control = 0;
    
//    always@(posedge clock) begin
//    if(btnU)
//    oled_control = oled_data_1;
    
//    if(btnD)
//    oled_control = oled_data_2; 
    
//    end

    Oled_Display (.clk(clk6p25m), .reset(0),
    .frame_begin(frame_begin), .sending_pixels(sending_pixels), .sample_pixel(sample_pixel),
    .pixel_index(pixel_index), .pixel_data(oled_data_1),
    .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), .pmoden(JC[7]));
    
    pixel_index_to_xy (.pixel_index(pixel_index), .x(x), .y(y));

endmodule
