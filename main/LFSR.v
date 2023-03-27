`timescale 1ns / 1ps

module LFSR_8_bit_v1(
    input clock,
    input reset,
    input [7:0] seed,
    output [7:0] pseudo_random
    );
    
    wire [7:0] ff_outputs;
    wire [7:0] mux_choices;
    wire [2:0] xor_outputs;
    reg [7:0] chooser = 8'b1101011;
    
    assign pseudo_random = ff_outputs;
    
//    always@(posedge clock)
//        chooser = ~chooser;
 
    
    D_FF Flip_flops_7 [6:0] (
        .reset(reset),
        .clock(clock),
        .D(mux_choices[7:1]),
        .Q(ff_outputs[7:1])
    );
    
     D_FF_special never_reset(
        .reset(0),
        .clock(clock),
        .D(mux_choices[0]),
        .Q(ff_outputs[0])
     );
    
    MUX Mux_2 [7:0] (
        .input1(seed),
        .input2({ff_outputs[0], xor_outputs[1], ff_outputs[6], xor_outputs[0] , ff_outputs[4], ff_outputs[3], xor_outputs[2], ff_outputs[1]}),
        .chooser(chooser),
        .choice(mux_choices)
    );
    
    XOR Gate1 (
        .x1(ff_outputs[0]),
        .x2(ff_outputs[4]),
        .y(xor_outputs[0])
    );
    
    XOR Gate2 (
        .x1(ff_outputs[0]),
        .x2(ff_outputs[6]),
        .y(xor_outputs[1])
    );
    
    XOR Gate3 (
        .x1(ff_outputs[0]),
        .x2(ff_outputs[1]),
        .y(xor_outputs[2])
    );

    
endmodule
