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
    input [6:0] x, y,
    input [3:0] machine_state,
    output reg [15:0] oled_data = 0
    );

    reg [1:0] color; // white, green, red, black
    
    // Green Lines
    // sw[8] controls display of green lines
    wire border1, border2, border;
    assign border1 = ((x <= 59) && (y >= 57 && y <= 59));
    assign border2 = ((x >= 57 && x <= 59) && (y <= 59));
    assign border = border1 || border2;

    // We simulate a 7-segment display
    wire [6:0] oled_seg;

    assign oled_seg[0] = (x >= 15 && x <= 39) && (y >= 9 && y <= 13);
    assign oled_seg[1] = (x >= 35 && x <= 39) && (y >= 9 && y <= 28);
    assign oled_seg[2] = (x >= 35 && x <= 39) && (y >= 26 && y <= 45);
    assign oled_seg[3] = (x >= 15 && x <= 39) && (y >= 41 && y <= 45);
    assign oled_seg[4] = (x >= 15 && x <= 19) && (y >= 26 && y <= 45);
    assign oled_seg[5] = (x >= 15 && x <= 19) && (y >= 9 && y <= 28);
    assign oled_seg[6] = (x >= 15 && x <= 39) && (y >= 25 && y <= 29);

    wire [9:0] num;

    assign num[0] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[4] || oled_seg[5];
    assign num[1] = oled_seg[1] || oled_seg[2];
    assign num[2] = oled_seg[0] || oled_seg[1] || oled_seg[3] || oled_seg[4] || oled_seg[6];
    assign num[3] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[6];
    assign num[4] = oled_seg[1] || oled_seg[2] || oled_seg[5] || oled_seg[6];
    assign num[5] = oled_seg[0] || oled_seg[2] || oled_seg[3] || oled_seg[5] || oled_seg[6];
    assign num[6] = oled_seg[0] || oled_seg[2] || oled_seg[3] || oled_seg[4] || oled_seg[5] || oled_seg[6];
    assign num[7] = oled_seg[0] || oled_seg[1] || oled_seg[2];
    assign num[8] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[4] || oled_seg[5] || oled_seg[6];
    assign num[9] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[5] || oled_seg[6];

    always @ (*) begin
        if (machine_state == 4'd4) begin
            if (sw[7:5]) begin
                if (sw[7])
                    color = num[7] ? 2'b11 : 2'b00;
                else if (sw[6])
                    color = num[6] ? 2'b11 : 2'b00;
                else if (sw[5])
                    color = num[5] ? 2'b11 : 2'b00;
            end

            if (!sw[8] && border)
                color = 2'b10;
            
            case (color)
                2'b11: oled_data = 16'hFFFF;
                2'b10: oled_data = 16'h07E0;
                2'b00: oled_data = 16'h0000;
                default: oled_data = 16'h0000;
            endcase
        end
    end
endmodule
