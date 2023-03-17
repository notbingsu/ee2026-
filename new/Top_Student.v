`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    // Delete this comment and include Basys3 inputs and outputs here
    input clock, J_MIC_Pin3,
    input [2:0] sw,
    output J_MIC_Pin1, J_MIC_Pin4, 
    output [8:0]led,
    output [3:0]an, 
    output [6:0]seg,
    output [7:0]JC
    );

    // Delete this comment and write your codes and instantiations here
    wire clk_20K;
    wire clk_20;
    wire [11:0] mic_in;
    wire [10:0] num;
    
    
    wire [6:0] x,y;
    wire [15:0]oled_data, oled_wave, oled_vol; // to be fed into oled display
    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    wire clk6p25m;
    wire freeze;

     
    clock_divider cs(.clock(clock), .k(2500) , .out(clk_20K)); //20KHz
    clock_divider cs2(.clock(clock), .k(2500000) , .out(clk_20)); //20Hz for display
    clock_divider cs3(.clock(clock), .k(8), .out(clk6p25m));//6.25MHz for oled
    
    assign oled_data = sw[0] ? oled_wave : oled_vol;
    Audio_Input MIC_in(.CLK(clock), .cs(clk_20K), .MISO(J_MIC_Pin3), .clk_samp(J_MIC_Pin1), .sclk(J_MIC_Pin4), .sample(mic_in));
    
    interval_max_output maxout (.clk_display(clk_20), .clk_peak(clk_20K), .signal(mic_in), .k(1000), .led(led), .an(an), .seg(seg), .num(num));
    
    vol_bar_oled vol_bar(.num(num), .x(x), .y(y), .oled_data(oled_vol));
    
    wave_oled WAVE_OLED(.sw(sw[1]), .freeze(sw[2]),.mic_in(mic_in), .clk(clk_20K), .x(x), .y(y), .oled_data(oled_wave));
    
    Oled_Display od0 (.clk(clk6p25m), .reset(0), .pixel_data(oled_data), .frame_begin(frame_begin), 
            .sending_pixels(sending_pixels), .sample_pixel(sample_pixel), .pixel_index(pixel_index), 
            .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), 
            .pmoden(JC[7]));
    // convert output pixel_index to x & y coordinates
    convert_xy xy0(pixel_index, x, y);
    


endmodule