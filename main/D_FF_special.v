`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 12:12:35
// Design Name: 
// Module Name: D_FF_special
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


module D_FF_special(
    input reset,
    input clock,
    input D,
    output reg Q
    );
    initial
        Q <= 1;
    
    always @ (posedge clock) begin
        if(reset)
            Q <= 0;
        else 
            Q <= D;
    end

endmodule
