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
    input btnD,
    input btnU,
    input btnL,
    input btnR,
    output [3:0] JX,
    output reg [6:0] seg,
    output reg dp,
    output reg [3:0] an
   
    );
    
    wire clock20k, clock50, clock190, clock10;
    my_clock clk50M(clock, 50000000, clock50);
    my_clock clk20k(clock, 20000, clock20k);
    my_clock clk190(clock, 190, clock190);
    my_clock clk10(clock, 10, clock10);
  
    
    // Delete this comment and write your codes and instantiations here
//    reg [11:0] audio_output;
    reg halver = 0;
    reg [31:0] timer = 100000000;
    reg generate_signal = 0;
    reg [11:0] counter = 0;
    wire [12:0] alarm;
    wire trigger;
    reg Trigger = 0;
    assign trigger = Trigger;
    
    //alarm tone
    my_alarm_tone alarmfunc(clock, sw[15:0], trigger, alarm);
    
    reg [31:0] m10 = 0;
    reg [31:0] m1 = 1;
    reg [31:0] s10 = 0;
    reg [31:0] s1 = 5;
    
    
 
    
    my_clock fps(clock, 120, FPS);
    my_clock btn(clock, 10, buttons);
    
    reg [1:0] cooldown = 0;
    reg [11:0] second_counter = 0;
    reg [4:0] switcher = 0;
    reg [4:0] index = 0;
    
    always @(posedge buttons) begin
        second_counter <= (second_counter >= 9) ? 0 : second_counter + 1;
        cooldown <= (cooldown == 0) ? 0: cooldown + 1;
        if (second_counter == 0) begin
        if (sw[15]) begin
                if (m10 == 0 & m1 == 0 & s10 == 0 & s1 == 0) begin 
                    Trigger <= 1;
                end
                else begin
                    if (s1 > 0)
                        s1 <= s1 - 1;
                    else begin
                        if (s10 > 0) begin
                            s1 <= 9;
                            s10 <= s10 - 1;
                        end
                        else begin 
                            if (m1 > 0) begin
                                s10 <= 5;
                                s1 <= 9;
                                m1 <= m1 - 1;
                            end
                            else begin
                                if (m10 > 0) begin
                                    m1 <= 9;
                                    s10 <= 5;
                                    s1 <= 9;
                                    m10 <= m10 - 1;
                                    end
                                end
                            end
                        end
                    end
                end
                else begin
                    Trigger <= 0;
                end
            end
        
        if (cooldown == 0) begin
        if (btnL | btnR | btnU | btnD) begin
        cooldown <= cooldown + 1;
        if (btnL & index > 0)
            index <= index - 1;
        if (btnR & index < 3)
            index <= index + 1;
        if (btnU) begin
            case (index)
                0: m10 <= (m10 == 9) ? 9 : m10 + 1;
                1: m1 <= (m10 == 9) ? 9 : m1 + 1;
                2: s10 <= (s10 == 5) ? 5 : s10 + 1;
                3: s1 <= (s1 == 9) ? 9 : s1 + 1;
            endcase
        end
        if (btnD) begin
            case (index)
                0: m10 <= (m10 == 0) ? 0 : m10 - 1;
                1: m1 <= (m10 == 0) ? 0 : m1 - 1;
                2: s10 <= (s10 == 0) ? 0 : s10 - 1;
                3: s1 <= (s1 == 0) ? 0 : s1 - 1;
            endcase
        end
        end
        end
    end
    
    always @(posedge FPS) begin        
        switcher <= (switcher >= 3) ? 0 : switcher + 1;
        dp <= 1;
        if (switcher == 0) begin
         if (~sw[15]) begin 
            if (switcher == index)
            dp <= 0;
            end
            an <= 4'b0111;
            case (m10)
                0: seg <= 7'b1000000;
                1: seg <= 7'b1111001;
                2: seg <= 7'b0100100;
                3: seg <= 7'b0110000;
                4: seg <= 7'b0011001;
                5: seg <= 7'b0010010;
                6: seg <= 7'b0000010;
                7: seg <= 7'b1111000;
                8: seg <= 7'b0000000;
                9: seg <= 7'b0010000;
                default: seg <= 7'b0000000;
            endcase
        end
        if (switcher == 1) begin
            if (~sw[15]) begin 
                if (switcher == index)
                dp <= 0;
                end
            an <= 4'b1011;
            case (m1)
                0: seg <= 7'b1000000;
                1: seg <= 7'b1111001;
                2: seg <= 7'b0100100;
                3: seg <= 7'b0110000;
                4: seg <= 7'b0011001;
                5: seg <= 7'b0010010;
                6: seg <= 7'b0000010;
                7: seg <= 7'b1111000;
                8: seg <= 7'b0000000;
                9: seg <= 7'b0010000;
                default: seg <= 7'b0000000;
            endcase
        end
        if (switcher == 2) begin
            if (~sw[15]) begin 
                if (switcher == index)
                dp <= 0;
                end
            an <= 4'b1101;
            case (s10)
                0: seg <= 7'b1000000;
                1: seg <= 7'b1111001;
                2: seg <= 7'b0100100;
                3: seg <= 7'b0110000;
                4: seg <= 7'b0011001;
                5: seg <= 7'b0010010;
                6: seg <= 7'b0000010;
                7: seg <= 7'b1111000;
                8: seg <= 7'b0000000;
                9: seg <= 7'b0010000;
                default: seg <= 7'b0000000;
            endcase
        end
        if (switcher == 3) begin
            if (~sw[15]) begin 
                if (switcher == index)
                dp <= 0;
                end
            an <= 4'b1110;
            case (s1)
                0: seg <= 7'b1000000;
                1: seg <= 7'b1111001;
                2: seg <= 7'b0100100;
                3: seg <= 7'b0110000;
                4: seg <= 7'b0011001;
                5: seg <= 7'b0010010;
                6: seg <= 7'b0000010;
                7: seg <= 7'b1111000;
                8: seg <= 7'b0000000;
                9: seg <= 7'b0010000;
                default: seg <= 7'b0000000;
            endcase
        end
    end
    
    Audio_Output boomz(
    .CLK(clock50), 
    .START(clock20k),
    .DATA1(alarm), 
    .DATA2(0),
    //.RST(0),
    .D1(JX[1]),
    .D2(JX[2]),
    .CLK_OUT(JX[3]),
    .nSYNC(JX[0]));
    
endmodule