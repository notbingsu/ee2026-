`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 17:28:10
// Design Name: 
// Module Name: my_alarm_tone
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module my_alarm_tone(
        input clock,
        input [15:0] sw,
        input trigger,
        output reg [11:0] audio_output
    );
    
    wire clock10;
    my_clock clk10(clock, 10, clock10);
    my_clock clk10k(clock, 10000, clock10k);
    
    reg [11:0] counter;
    reg generate_signal;
    reg halver;
    
    always @ (posedge clock10) begin
        counter <= (counter >= 9) ? 0 : counter + 1;
        if (sw[1] | trigger) begin
            if (counter < 7) 
                generate_signal <= ~generate_signal;
            else
                generate_signal <= 0;
            end
        else
            generate_signal <= 0;
        end
        
        
        always @ (posedge clock10k)
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
endmodule
