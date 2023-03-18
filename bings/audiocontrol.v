module audiocontrol(
    input clock,
    input btnC,
    input sw0,
    input sw15,
    input [3:0] num,
    output [3:0] JB
    );
    
    wire clock20, clock50, clock190, clock380;
    reg [11:0] audio_output = 0;
    reg [31:0] timercounter = 0;
    
    Clock_mHz clk50M(clock, 50000000, clock50);
    Clock_mHz clk20k(clock, 20000, clock20);
    Clock_mHz clk190(clock, 190, clock190);
    Clock_mHz clk380(clock, 380, clock380);
    
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
    
    always @ (posedge clock380) begin
    
    if(~sw15) begin
        if (generate_signal) begin
            if (sw0) begin
                halver <= ~halver;
                if (halver)
                    audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
            end     
            else
                audio_output <= (audio_output == 0) ? 12'b010000000000 : 0;
        end
        
        else
            audio_output = 0;
    end
    
    else if ((num != 4'b1111) && sw15) begin
        case(num)
                4'b0000:
                    begin
                        timercounter = (timercounter>10000000)? 10000000: timercounter + 1;
                        if(timercounter == 10000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b0001:
                    begin
                        timercounter = (timercounter>20000000)? 20000000: timercounter + 1;
                        if(timercounter == 20000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b0010:
                    begin
                        timercounter = (timercounter>30000000)? 30000000: timercounter + 1;
                        if(timercounter == 30000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b0011:
                    begin
                        timercounter = (timercounter>40000000)? 40000000: timercounter + 1;
                        if(timercounter == 40000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b0100:
                    begin
                        timercounter = (timercounter>50000000)? 50000000: timercounter + 1;
                        if(timercounter == 50000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b0101:
                    begin
                        timercounter = (timercounter>60000000)? 60000000: timercounter + 1;
                        if(timercounter == 60000000)
                           audio_output = 0;
                       else
                           audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b0110:
                    begin
                        timercounter = (timercounter>70000000)? 70000000: timercounter + 1;
                        if(timercounter == 70000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b0111:
                    begin
                        timercounter = (timercounter>80000000)? 80000000: timercounter + 1;
                        if(timercounter == 80000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b1000:
                    begin
                        timercounter = (timercounter>90000000)? 90000000: timercounter + 1;
                        if(timercounter == 90000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    4'b1001:
                    begin
                        timercounter = (timercounter>100000000)? 100000000: timercounter + 1;
                        if(timercounter == 100000000)
                            audio_output = 0;
                        else
                            audio_output <= (audio_output == 0) ? 12'b100000000000 : 0;
                    end
                    
                    default:
                    begin
                        audio_output = 0;
                        timercounter = 0;
                    end
                    
                endcase
            end
    end
    

Audio_Output boomz(
    .CLK(clock50), 
    .START(clock20),
    .DATA1(audio_output), 
    .DATA2(0),
    //.RST(0),
    .D1(JB[1]),
    .D2(JB[2]),
    .CLK_OUT(JB[3]),
    .nSYNC(JB[0])
    );

endmodule
