`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 10:39:13 PM
// Design Name: 
// Module Name: vol_bar_oled
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


module vol_bar_oled(
    input [10:0] num,
    input [6:0] x, y,
    output reg [15:0] oled_data
    );
    
        // Booleans 
    wire x_range;
    wire [9:0] v;
    assign x_range = x >= 32 && x <= 63;
    // Boolean value at each level
    assign v[0] = 0;
    assign v[1] = (num >= 205  && (y <= 63 && y >= 58));
    assign v[2] = (num >= 409  && (y <= 56 && y >= 51));
    assign v[3] = (num >= 614  && (y <= 49 && y >= 44));
    assign v[4] = (num >= 819  && (y <= 42 && y >= 37));
    assign v[5] = (num >= 1024 && (y <= 35 && y >= 30));
    assign v[6] = (num >= 1229 && (y <= 28 && y >= 23));
    assign v[7] = (num >= 1434 && (y <= 21 && y >= 16));
    assign v[8] = (num >= 1638 && (y <= 14 && y >= 9));
    assign v[9] = (num >= 1842 && (y <= 7 && y >= 2));

    // Assigning volume bar oled_data
    always @ (*) begin
        if (x_range && num > 0 && v) begin
            if (v[3:1])
                oled_data = 16'b00000_111111_00000;
            if (v[6:4])
                oled_data = 16'b11111_111111_00000;
            if (v[9:7]) 
                oled_data = 16'b11111_000000_00000;
        end else 
            oled_data = 16'b0;
    end
endmodule
