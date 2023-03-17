`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 09:27:36 AM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input clock, input [31:0]k,
    output out
    );
    reg out_value = 1'b0;
    integer clock_counter = 0; 
    always @(posedge clock)
    begin
    if (clock_counter == k - 1)
        begin
        out_value <= ~out_value;
        clock_counter <= 0;
        end
    else
        begin
        clock_counter <= (clock_counter == k -1) ? 0 : clock_counter + 1;
        end
    end
    assign out = out_value;
     
    
endmodule
