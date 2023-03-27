`timescale 1ns / 1ps

module oled_control(
    input [3:0] machine_state,
    input [15:0] oled_s0, oled_s1, oled_s2, oled_s3, oled_s4, oled_s5, oled_s6, oled_s7, oled_s8,
    output reg [15:0] oled_data
    );

    always @ (*) begin
        // update oled states where neccessary
        case (machine_state)
            4'b0000: oled_data = oled_s0;
            4'b0001: oled_data = 0;
            4'b0010: oled_data = 0;
            4'b0011: oled_data = 0;
            4'b0100: oled_data = 0;
            4'b0101: oled_data = 0;
            4'b0110: oled_data = 0;
            4'b0111: oled_data = oled_s7;
            4'b1000: oled_data = 0;
        endcase
    end
endmodule