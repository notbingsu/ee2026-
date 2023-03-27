`timescale 1ns / 1ps

module CA90_FF(
    input clock,
    input reset,
    input left,
    input right,
    output reg Q
    );
    
    initial
        Q <= 0;
    
    always@(posedge clock) begin
    if(reset)
        Q <= 0;
    else
        Q <= left ^ right;
    end
    
endmodule
