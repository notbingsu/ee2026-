`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 17:40:16
// Design Name: 
// Module Name: my_countdown
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


module my_countdown(
        input clock,
        input [15:0] sw,
        input [32:0] seconds,
        output reg trigger = 0,
        output reg [6:0] seg,
        output dp,
        output reg [3:0] an
    );
    
    reg [32:0] secondcounter;
    reg record = 1;
    wire secondClock;
    my_clock secondclock(clock, 1, secondClock);
    
    always @(posedge secondClock) begin
        if (record) begin
        secondcounter <= seconds;
        record <= 0;
        end
        secondcounter <= (secondcounter == 0) ? 0 : secondcounter - 1;
        if (secondcounter == 0)
            trigger = 1;
        end
    
    my_seg_display(.clock(clock),.seconds(80),.dp(dp));
    
endmodule
