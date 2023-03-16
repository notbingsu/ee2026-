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
    input clock,
    input [15:0]sw,
    input btnC,
    output [3:0] JX
    
    );
    
    wire clock20, clock50, clock190;
    my_clock clk50M(clock, 50000000, clock50);
    my_clock clk20k(clock, 20000, clock20);
    my_clock clk190(clock, 190, clock190);
    my_clock clk380(clock, 380, clock380);
  
    
    // Delete this comment and write your codes and instantiations here
    reg [11:0] audio_output = 0;
    reg halver = 0;
    reg [31:0] timer = 100000000;
    reg generate_signal = 0;
    
    always @ (posedge clock) begin
    if (btnC)
        generate_signal <= 1;
    if (generate_signal) begin
        timer <= timer - 1;
        if (timer == 0) begin
            timer <= 100000000;
            generate_signal <= 0;
            end
        end
    end
    
    
    always @ (posedge clock380)
        begin
        if (generate_signal) begin
            if (sw[0]) begin
                halver <= ~halver;
                if (halver)
                    audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                end     
            else
            audio_output <= (audio_output == 0) ? 12'b010000000000 : 0;
        end
    end
    
    Audio_Output boomz(
    .CLK(clock50), 
    .START(clock20),
    .DATA1(audio_output), 
    .DATA2(0),
    //.RST(0),
    .D1(JX[1]),
    .D2(JX[2]),
    .CLK_OUT(JX[3]),
    .nSYNC(JX[0]));
    
    
    
endmodule