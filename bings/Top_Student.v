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
    input btnU,
    input btnD,
    input [15:0]sw,
    //input btnC,
    output [3:0] JX
    
    );
    
    wire clock20k, clock50, clock10;
    my_clock clk50M(clock, 50000000, clock50);
    my_clock clk20k(clock, 20000, clock20k);
    my_clock clk10(clock, 10, clock10);
  
    
    // Delete this comment and write your codes and instantiations here
    reg [11:0] audio_output = 0;
    reg [11:0] timer = 0;
    reg [11:0] current_time = 0;
    reg [11:0] ratio = 2;
    reg [11:0] counter = 0;
    
    always @ (posedge clock10) begin
        timer <= (timer == 0 | timer == 5) ? 0 : timer + 1;
        if (btnU == 1 & timer == 0) begin
            timer <= timer + 1;
            ratio <= (ratio <= 2) ? 2 : ratio - 1;
            end
        if (btnD == 1 & timer == 0) begin 
            timer <= timer + 1;
            ratio <= (ratio >= 10) ? 10 : ratio + 1;
            end
        end    
            
    always @ (posedge clock20k) begin
        counter <= counter + 1;
        if (counter >= ratio) begin
            counter <= 0;
            if (sw[0])
                audio_output <= (audio_output == 0) ? 12'b001000000000 : 0;
            if (sw[0] & sw[1])
                audio_output <= (audio_output == 0) ? 12'b010000000000 : 0;
            end
    end
    
    
    
    
    Audio_Output boomz(
    .CLK(clock50), 
    .START(clock20k),
    .DATA1(audio_output), 
    .DATA2(0),
    //.RST(0),
    .D1(JX[1]),
    .D2(JX[2]),
    .CLK_OUT(JX[3]),
    .nSYNC(JX[0]));
    
    
    
endmodule