`timescale 1ns / 1ps

module CA150_FF(
    input clock,
    input reset,
    input left,
    input prev,
    input right,
    output reg Q
    );
    
    initial
        Q <= 1;
    
    always@(posedge clock) begin
    if(reset)
        Q <= 0;  
    else
        Q <= prev ^ left ^ right;
    end
    
endmodule
