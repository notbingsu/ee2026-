`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 10:47:10 PM
// Design Name: 
// Module Name: show_display
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


module show_display(
    input [10:0] num, 
    input clock, 
    output reg [8:0] led = 0,
    output reg [3:0] an = ~4'b0,
    output reg [6:0] seg = ~7'b0
    );
    
    //display digit on 7seg and led
//    reg [6:0] seg_val;
//    reg [8:0] led_val;
    always @ (posedge clock) begin
        if (num >= 0 && num < 205)
            begin  
                seg = 7'b1000000;
                led = 9'h000;
            end
        else if (num >= 205 && num < 409)
            begin
                seg = 7'b1111001;
                led = 9'h001;
            end
        else if (num >= 409 && num < 614)
            begin
                seg = 7'b0100100;
                led = 9'h003;
            end
        else if (num >= 614 && num < 819)
            begin
                seg = 7'b0110000;
                led = 9'h007;
            end
        else if (num >= 819 && num < 1024)
            begin 
                seg = 7'b0011001;
                led = 9'h00f;
            end
        else if (num >= 1024 && num < 1229)
            begin 
                seg = 7'b0010010;
                led = 9'h01f;
            end
        else if (num >= 1229 && num < 1434)
            begin
                seg = 7'b0000010;
                led = 9'h03f;
            end
        else if (num >= 1434 && num < 1638)
            begin
                seg = 7'b1111000;
                led = 9'h07f;
            end
        else if (num >= 1638 && num < 1842)
            begin
                seg = 7'b0;
                led = 9'h0ff;
            end
        else if (num >= 1842 && num <= 2047)
            begin 
                seg = 7'b0010000;
                led = 9'h1ff;
            end
        
        an <= 4'b1110;

    end
    

endmodule
