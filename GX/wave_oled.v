`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2023 11:15:14 PM
// Design Name: 
// Module Name: wave_oled
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


module wave_oled(
    input sw, freeze,
    input clk,
    input [11:0] mic_in,
    input [6:0] x, y,
    output [15:0] oled_data
    );
    
    reg [11:0] wave_x [95:0];
    integer i;
    initial begin
        for (i = 0; i < 96; i = i+1) begin
            wave_x[i] = 0;
        end
    end
    
    reg [6:0] x_co = 0; // 0 to 95
    
    always @ (posedge clk) begin
        x_co <= x_co == 95 ? 0 : x_co + 1;
        // get new mic_in value
        wave_x[x_co] <= freeze ? wave_x[x_co] : x_co < 96 - 1 ? wave_x[x_co+1] : mic_in;
    end
    
    wave_pos w0(sw, wave_x[x], y, oled_data);
    
endmodule
module wave_pos(
    input sw,
    input [11:0] wave_x,
    input [6:0] y,
    output [15:0] oled_data    
    );
    localparam barRange = 21;
    localparam greRange = 10;
    localparam yelRange = 20;
    
    wire [6:0] y_mirror;
    reg [5:0] num1, num2; // value from 0 to 63
    reg range_low, range_mid, range_high;
    assign y_mirror = 63 - y;
    
    always @ (*) begin
        if (sw) begin
            num1 = (wave_x[11] ? wave_x[10:5] : 0);
            if (y_mirror < num1) begin
                range_low = (num1 >= 1 && num1 <= barRange);
                range_mid = (num1 >= 1+barRange && num1 <= 2*barRange);
                range_high = (num1 >= 1+2*barRange);
            end else begin
                range_low = 0;
                range_mid = 0;
                range_high = 0;
            end
        end else begin
            num1 = wave_x[11:6];
            num2 = num1 > 64/2 ? num1 : 64 - num1; 
            if (y_mirror < num2 && y_mirror > 64 - num2) begin
                range_low = (num2 <= 64/2 + greRange && num2 >= 64/2 - greRange);
                range_mid = !range_low && (num2 <= 64/2 + yelRange && num2 >= 64/2 - yelRange);
                range_high = !range_mid && (num2 > 64/2 + yelRange && num2 < 64/2 - yelRange);
            end else begin
                range_low = 0;
                range_mid = 0;
                range_high = 0;
            end
        end
    end
    
    assign oled_data = range_low ? 16'h867F : range_mid ? 16'hFD8F : range_high ? 16'hF81F :
                       sw && !num1 && !y_mirror || !sw && num1 == 64/2 && y_mirror == 64/2 ? ~16'b0 : 16'b0;
endmodule