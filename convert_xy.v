`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 11:39:19 PM
// Design Name: 
// Module Name: convert_xy
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


module convert_xy(
    input [12:0] pixel_index,
    output [6:0] x,y
    );
    
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
endmodule
