`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 09:26:33
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(input CLK, input [31:0] n, output reg clock_out = 0);
    reg [31:0] count = 0;
    
    always @ (posedge CLK) begin
        count <= (count >= n) ? 0 : count + 1;
        clock_out <= (count == 0) ? ~clock_out : clock_out;
    end
endmodule
