`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2023 12:43:46
// Design Name: 
// Module Name: pixel_index_to_xy
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


module pixel_index_to_xy(input [12:0] pixel_index, output [6:0] x, y);
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
endmodule
