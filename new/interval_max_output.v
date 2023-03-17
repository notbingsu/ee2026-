`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 04:08:25 PM
// Design Name: 
// Module Name: interval_max_output
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


module interval_max_output(
    input clk_display, clk_peak, 
    input [11:0]signal, 
    input [31:0]k,
    output [8:0] led,
    output [3:0] an,
    output [6:0] seg,
    output reg [10:0]num = 0 
    );
    reg[31:0] counter = 0;    
    reg [11:0]max = 0;
    
    always @(posedge clk_peak) begin
        counter <= counter == k ? 0 : counter + 1;
        max <= counter == 0 ? signal : (signal > max ? signal : max);
        num <= max[11] ? max[10:0] : 0;
    end
    
    show_display display(num, clk_display, led, an, seg);
    
    
endmodule
