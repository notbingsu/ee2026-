`timescale 1ns / 1ps

module CASR_32_bit(
    input clock,
    input reset,
    output [31:0] pseudo_random
    );
    
    wire [31:0] ff_outputs;
    
    assign pseudo_random = ff_outputs;
    
    CA90_FF Flip_flop_1 (
        .reset(reset),
        .clock(clock),
        .left(0),
        .right(ff_outputs[1]),
        .Q(ff_outputs [0])
    );
    
    CA90_FF Flip_flop_2 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[0]),
        .right(ff_outputs[2]),
        .Q(ff_outputs [1])
    );
    
    CA90_FF Flip_flop_3 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[1]),
        .right(ff_outputs[3]),
        .Q(ff_outputs [2])
    );
    
    CA90_FF Flip_flop_4 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[2]),
        .right(ff_outputs[4]),
        .Q(ff_outputs [3])
    );
    
    CA90_FF Flip_flop_5 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[3]),
        .right(ff_outputs[5]),
        .Q(ff_outputs [4])
    );
    
    CA90_FF Flip_flop_6 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[4]),
        .right(ff_outputs[6]),
        .Q(ff_outputs [5])
    );
    
    CA90_FF Flip_flop_7 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[5]),
        .right(ff_outputs[7]),
        .Q(ff_outputs [6])
    );
    
    CA90_FF Flip_flop_8 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[6]),
        .right(ff_outputs[8]),
        .Q(ff_outputs [7])
    );
    
    CA90_FF Flip_flop_9 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[7]),
        .right(ff_outputs[9]),
        .Q(ff_outputs [8])
    );
    
    CA90_FF Flip_flop_10 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[8]),
        .right(ff_outputs[10]),
        .Q(ff_outputs [9])
    );
    
    CA90_FF Flip_flop_11 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[9]),
        .right(ff_outputs[11]),
        .Q(ff_outputs [10])
    );
    
    CA90_FF Flip_flop_12 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[10]),
        .right(ff_outputs[12]),
        .Q(ff_outputs [11])
    );
    
    CA90_FF Flip_flop_13 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[11]),
        .right(ff_outputs[13]),
        .Q(ff_outputs [12])
    );
    
    CA90_FF Flip_flop_14 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[12]),
        .right(ff_outputs[14]),
        .Q(ff_outputs [13])
    );
    
    CA90_FF Flip_flop_15 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[13]),
        .right(ff_outputs[15]),
        .Q(ff_outputs [14])
    );
    
    CA90_FF Flip_flop_16 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[14]),
        .right(ff_outputs[16]),
        .Q(ff_outputs [15])
    );
    
    CA90_FF Flip_flop_17 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[15]),
        .right(ff_outputs[17]),
        .Q(ff_outputs [16])
    );
    
    CA90_FF Flip_flop_18 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[16]),
        .right(ff_outputs[18]),
        .Q(ff_outputs [17])
    );
    
    CA90_FF Flip_flop_19 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[17]),
        .right(ff_outputs[19]),
        .Q(ff_outputs [18])
    );
    
    CA90_FF Flip_flop_20 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[18]),
        .right(ff_outputs[20]),
        .Q(ff_outputs [19])
    );
    
    CA90_FF Flip_flop_21 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[19]),
        .right(ff_outputs[21]),
        .Q(ff_outputs [20])
    );
    
    CA150_FF Flip_flop_22 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[20]),
        .prev(ff_outputs[21]),
        .right(ff_outputs[22]),
        .Q(ff_outputs [21])
    );
    
    CA90_FF Flip_flop_23 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[21]),
        .right(ff_outputs[23]),
        .Q(ff_outputs [22])
    );
    
    CA90_FF Flip_flop_24 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[22]),
        .right(ff_outputs[24]),
        .Q(ff_outputs [23])
    );
    
    CA90_FF Flip_flop_25 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[23]),
        .right(ff_outputs[25]),
        .Q(ff_outputs [24])
    );
    
    CA90_FF Flip_flop_26 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[24]),
        .right(ff_outputs[26]),
        .Q(ff_outputs [25])
    );
    
    CA90_FF Flip_flop_27 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[25]),
        .right(ff_outputs[27]),
        .Q(ff_outputs [26])
    );
    
    CA90_FF Flip_flop_28 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[26]),
        .right(ff_outputs[28]),
        .Q(ff_outputs [27])
    );
    
    CA90_FF Flip_flop_29 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[27]),
        .right(ff_outputs[29]),
        .Q(ff_outputs [28])
    );
    
    CA90_FF Flip_flop_30 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[28]),
        .right(ff_outputs[30]),
        .Q(ff_outputs [29])
    );
    
    CA90_FF Flip_flop_31 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[29]),
        .right(ff_outputs[31]),
        .Q(ff_outputs [30])
    );
    
    CA90_FF Flip_flop_32 (
        .reset(reset),
        .clock(clock),
        .left(ff_outputs[30]),
        .right(0),
        .Q(ff_outputs [31])
    );   
    
endmodule
