`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 20:30:14
// Design Name: 
// Module Name: XY_coordinate_finder
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

module XY_coordinate_finder(
    input [12:0] pixel_index,
    output [6:0] x,
    output [6:0] y
    );
    
    assign x = (pixel_index % 96);
    assign y = (pixel_index / 96);
    
endmodule
