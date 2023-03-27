`timescale 1ns / 1ps

module MUX(
    input input1,
    input input2,
    input chooser,
    output reg choice
    );
    
    //if chooser is 0, choose input 1, else choose input 2
    always @(*) 
        choice = (~chooser)?input1:input2;
    
endmodule
