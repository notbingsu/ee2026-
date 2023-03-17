`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 20:33:25
// Design Name: 
// Module Name: Mouse_to_OLED
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
`define PINKCOLOR 16'hFDDF
`define NAVYCOLOR 16'h18CE
`define REDCOLOR 16'hE924
`define YELLOWCOLOR 16'hFFB5
`define GREENCOLOR 16'h87F4

module Mouse_to_OLED(
    input clock,
    input clock10hz,
    input middle,
    input [6:0] curr_x,
    input [6:0] curr_y,
    input [11:0] xpos, 
    input [11:0] ypos,
    output [15:0] pixel_data,
    output cursorflag
    );
    
    reg [15:0] pixelinfo;
    reg change_cursor = 0;
    
    assign pixel_data = pixelinfo;
    assign cursorflag = change_cursor;
    
    always @ (posedge clock10hz)
    begin
        if(middle)
        change_cursor = ~change_cursor;
    end
    
    always @ (posedge clock)
    begin
        case(change_cursor)
        
        0:
            pixelinfo = (curr_x == xpos && curr_y == ypos)? `PINKCOLOR : `NAVYCOLOR; //small cursor
        1:
            pixelinfo = (((curr_x == xpos) || (curr_x == xpos + 1) || (curr_x == xpos + 2)) && ((curr_y == ypos) || (curr_y == ypos + 1) || (curr_y == ypos + 2)))? `GREENCOLOR : `NAVYCOLOR; //large cursor
            
        endcase

    end
        
endmodule
