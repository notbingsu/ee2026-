`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2023 09:39:55
// Design Name: 
// Module Name: Mouse_config
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


module Mouse_config(
    input clock,
    input cursorflag,
    output setmax_x,
    output setmax_y,
    output [11:0] value
    );
    
    reg temp_setmax_x, temp_setmax_y;
    reg [11:0] temp_value; 
    
    assign setmax_x = temp_setmax_x;
    assign setmax_y = temp_setmax_y;
    assign value = temp_value;
    
    initial
    begin
        temp_setmax_x = 1;
        temp_setmax_y = 0;
        temp_value = 95;
    end
    
    always @ (posedge clock)
    begin
       
        case(cursorflag)
        0:
        begin
            temp_value = (temp_value == 95)? 63 : 95;
            temp_setmax_x = (temp_value == 95)? 1 : 0;
            temp_setmax_y = (temp_value == 63)? 1 : 0;
        end
        1:
        begin
            temp_value = (temp_value == 93)? 61 : 93;
            temp_setmax_x = (temp_value == 93)? 1 : 0;
            temp_setmax_y = (temp_value == 61)? 1 : 0;
        end
        endcase
        
    end
    
endmodule
