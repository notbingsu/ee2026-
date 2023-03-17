`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 09:26:21
// Design Name: 
// Module Name: Clock Divider
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


module Clock_mHz(
    input clock,
    input [31:0] m,
    output khzclock
    );
    
    integer khzcounter = 0; //regular clock ticker
    reg clocksignal = 1'b0;
    assign khzclock = clocksignal;
    
    always @(posedge clock)
    begin
        khzcounter <= (khzcounter ==50000000/m)? 0 : khzcounter + 1;
        clocksignal <= (khzcounter == 0)? ~clocksignal : clocksignal; //toggle the signal at the right frequency
    end

endmodule

module Clock_6p25mHz(
    input clock,
    output khzclock
    );
    
    integer khzcounter = 0; //regular clock ticker
    reg clocksignal = 1'b0;
    assign khzclock = clocksignal;
    
    always @(posedge clock)
    begin
        khzcounter <= (khzcounter == 8)? 0 : khzcounter + 1;
        clocksignal <= (khzcounter == 0)? ~clocksignal : clocksignal; //toggle the signal at the right frequency
    end

endmodule

