`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 18:01:44
// Design Name: 
// Module Name: my_seg_display
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


module my_seg_display(
        input clock,
        input [32:0] seconds,
        output reg [6:0] seg,
        output dp,
        output reg [3:0] an
    );
        reg [4:0] switcher = 0;
        wire secondcount, minutecount;
        wire minute10, minute1, second10, second1;
        assign minutecount = seconds / 60;
        assign secondcount = seconds % 60;
        assign minute10 = minutecount / 10;
        assign minute1 = minutecount % 10;
        assign second10 = seconds / 10;
        assign second1 = seconds % 10;
        
        assign dp = 0;
        
        always @(posedge clock) begin
            switcher <= (switcher == 3) ? 0 : switcher + 1;
            if (switcher == 0) begin
                an <= 4'b0111;
                case (minute10)
                    0: seg <= 7'b1000000;
                    1: seg <= 7'b1111001;
                    2: seg <= 7'b0100100;
                    3: seg <= 7'b0110000;
                    4: seg <= 7'b0011001;
                    5: seg <= 7'b0010010;
                    6: seg <= 7'b0000010;
                    7: seg <= 7'b1111000;
                    8: seg <= 7'b0000000;
                    9: seg <= 7'b0010000;
                    default: seg <= 7'b1000000;
                endcase
            end
            if (switcher == 1) begin
                an <= 4'b1011;
                case (minute1)
                    0: seg <= 7'b1000000;
                    1: seg <= 7'b1111001;
                    2: seg <= 7'b0100100;
                    3: seg <= 7'b0110000;
                    4: seg <= 7'b0011001;
                    5: seg <= 7'b0010010;
                    6: seg <= 7'b0000010;
                    7: seg <= 7'b1111000;
                    8: seg <= 7'b0000000;
                    9: seg <= 7'b0010000;
                    default: seg <= 7'b1000000;
                endcase
            end
            if (switcher == 2) begin
                an <= 4'b1101;
                case (second10)
                    0: seg <= 7'b1000000;
                    1: seg <= 7'b1111001;
                    2: seg <= 7'b0100100;
                    3: seg <= 7'b0110000;
                    4: seg <= 7'b0011001;
                    5: seg <= 7'b0010010;
                    6: seg <= 7'b0000010;
                    7: seg <= 7'b1111000;
                    8: seg <= 7'b0000000;
                    9: seg <= 7'b0010000;
                    default: seg <= 7'b1000000;
                endcase
            end
            if (switcher == 3) begin
                an <= 4'b1110;
                case (second1)
                    0: seg <= 7'b1000000;
                    1: seg <= 7'b1111001;
                    2: seg <= 7'b0100100;
                    3: seg <= 7'b0110000;
                    4: seg <= 7'b0011001;
                    5: seg <= 7'b0010010;
                    6: seg <= 7'b0000010;
                    7: seg <= 7'b1111000;
                    8: seg <= 7'b0000000;
                    9: seg <= 7'b0010000;
                    default: seg <= 7'b1000000;
                endcase
            end
        end
        
        
endmodule
