`timescale 1ns / 1ps

module oled_score(
    input clock,
    input score,
    input [6:0] x, y,
    output reg [15:0] oled_data
    );
    
    wire Y = ((x==10 || x==11 || x==18 || x==19) &&  (y==12 || y==13)) || ((x==12 || x==13 || x==16 || x==17) && (y==14 || y==15)) || ((x==14 || x==15) && (y>=16 && y<=21)) ;
    wire O2 = ((x==22 || x==23 || x==26 || x==27) && (y>=12 && y<=21)) || ((x==24 || x==25) && (y==12 || y==13 || y==20 || y==21));
    wire U = ((x==30 || x==31 || x==34 || x==35) && (y>=12 && y<=21)) || ((x==32 || x==33) && (y==20 || y==21));
    wire R1 = ((x==38 || x==39) && (y>=12 && y<=21)) || ((x==40 || x==41) && (y==14 || y==15)) || ((x==42 || x==43) && (y==12 || y==13));
    
    wire S = ((x==48 || x==49) && ((y>=12 && y<=17) || (y==20 || y==21))) || ((x==50 || x==51) && (y==12 || y==13 || y==16 || y==17 || y==20 || y==21)) || ((x==52 || x==53) && (y==12 || y==13 || (y>=16 && y<=21)));
    wire C2 = ((x==56 || x==57) &&(y>=12 && y<=21)) || ((x>=58 && x<=61) && (y==12 || y==13 || y==20 || y==21));
    wire O3 = ((x==64 || x==65 || x==68 || x==69) && (y>=12 && y<=21)) || ((x==66 || x==67) && (y==12 || y==13 || y==20 || y==21));
    wire R2 = ((x==72 || x==73) && (y>=12 && y<=21)) || ((x==74 || x==75) && (y==14 || y==15)) || ((x==76 || x==77) && (y==12 || y==13)) ;
    wire E2 = ((x==80 || x==81) && (y>=12 && y<=21)) || ((x==82 || x==83) && (y==12 || y==13 || y==16 || y==17 ||  y==20 || y==21))|| ((x==84 || x==85) && ((y>=12 && y<=17) || y==20 || y==21));
    
    wire YOUR_SCORE = Y || O2 || U || R1 || S|| C2 || O3 || R2 || E2;
    
    wire left_0 = ((x==28 || x==29 || x==44 || x==45) && (y>=32 && y<=47)) || ((x==30 || x==31|| x==42|| x==43) && (y>=30 && y<=49)) || ((x == 32 || x==33 || x==40 || x==41) && (y>=28 && y<=51)) || ((x>=34 && x<=39) && ((y>=28 && y<=35) || (y>=46 && y<=51)));
    wire left_1 = ((x==30 || x==31) && (y==32 || y==33 || (y>=48 && y<=51))) || ((x==32 || x==33) && ((y>=30 && y<=33) || (y>=48 && y<=51))) || ((x==34 || x==35) &&((y>=28 && y<=33) || (y>=48 && y<=51))) || ((x>=36 && x<=39) && (y>=28 && y<=51)) || ((x>=40 && x<=45) && (y>=48 && y<=51));
    wire left_2 = ((x==30 || x==31) && ((y>=46 && y<=51) || (y>=30 && y<=35))) || ((x==32 || x==33) && ((y>=44 && y<=51) || (y>=28 && y<=35))) || ((x==34 || x==35) &&((y>=28 && y<=31) || (y>=42 && y<=51))) || ((x==36 || x==37) &&((y>=28 && y<=31) || (y>=40 && y<=43) || (y>=48 && y<=51))) || ((x==38|| x==39) &&((y>=28 && y<=43) || (y>=48 && y<=51))) || ((x==40 || x==41) &&((y>=30 && y<=41) || (y>=48 && y<=51))) || ((x==42 || x==43) && (y>=48 && y<=51));
    wire left_3 = ((x>=30 && x<= 39) && ((y>=28 && y<=31) || (y>=38 && y<=41) || (y>=40 && y<=45))) || ((x>=40 && x<=45) && (y>=28 && y<=51));
    
    wire right_0 = ((x==48 || x==49 || x==64 || x==65) && (y>=32 && y<=47)) || ((x==50 || x==51|| x==62|| x==63) && (y>=30 && y<=49)) || ((x == 52 || x==53 || x==60 || x==61) && (y>=28 && y<=51)) || ((x>=54 && x<=59) && ((y>=28 && y<=35) || (y>=46 && y<=51)));
    wire right_1 = ((x==50 || x==51) && (y==32 || y==33 || (y>=48 && y<=51))) || ((x==52 || x==53) && ((y>=30 && y<=33) || (y>=48 && y<=51))) || ((x==54 || x==55) &&((y>=28 && y<=33) || (y>=48 && y<=51))) || ((x>=56 && x<=59) && (y>=28 && y<=51)) || ((x>=60 && x<=65) && (y>=48 && y<=51));
    wire right_2 = ((x==52 || x==53) && ((y>=46 && y<=51) || (y>=30 && y<=35))) || ((x==54 || x==55) && ((y>=44 && y<=51) || (y>=28 && y<=35))) || ((x==56 || x==57) &&((y>=28 && y<=31) || (y>=42 && y<=51))) || ((x==58 || x==59) &&((y>=28 && y<=31) || (y>=40 && y<=43) || (y>=48 && y<=51))) || ((x==60|| x==61) &&((y>=28 && y<=43) || (y>=48 && y<=51))) || ((x==62 || x==63) &&((y>=30 && y<=41) || (y>=48 && y<=51))) || ((x==64 || x==65) && (y>=48 && y<=51));
    wire right_3 = ((x>=50 && x<= 59) && ((y>=28 && y<=31) || (y>=38 && y<=41) || (y>=48 && y<=51))) || ((x>=60 && x<=65) && (y>=28 && y<=51));
    wire right_4 = ((x==50 || x==51) && (y>=38 && y<=43)) || ((x==52 || x==53) && (y>=34 && y<=43)) || ((x>=54 && x<=55) && ((y>=28 && y<=37) || (y>=40 && y<= 43))) || ((x==56 || x==57) && ((y>=28 && y<=33) || (y>=40 && y<=43))) || ((x==58 || x==59) && (y>=40 && y<=43)) || ((x>=60 && x<=63) && (y>=28 && y<=51)) || ((x>=64 && x<=67) && (y>=40 && y<=43));
    wire right_5 = ((x>=52 && x<=55) && ((y>=28 && y<=39) || (y>=46 && y<= 51))) || ((x>=56 && x<=59) && ((y>=28 && y<=31) || (y>=36 && y<=39) || (y>=48 && y<=51))) || ((x>=60 && x<=63) && ((y>=28 && y<=31) || (y>=36 && y<=51))) || ((x==64 || x==65) && ((y>=28 && y<=31) || (y>=38 && y<=49)));
    wire right_6 = ((x>=52 && x<=55) && (y>=28 && y<=51)) || ((x>=56 && x<=61) && ((y>=28 && y<=31) || (y>=36 && y<=39) || (y>=48 && y<=51))) || ((x>=62 && x<=65) && ((y>=28 && y<=31) || (y>=36 && y<=51)));
    wire right_7 = ((x==50 || x==51) && (y>=28 && y<=31)) || ((x== 52 || x==53) && ((y>=28 && y<=31) || (y>=48 && y<=51))) || ((x== 54 || x==55) && ((y>=28 && y<=31) || (y>=46 && y<=51))) || ((x==56 || x==57) && ((y>=28 && y<=31) || (y>=42 && y<=49))) || ((x==58 || x==59) && ((y>=28 && y<=31) || (y>= 38 && y<= 45))) || ((x==60 || x==61) && ((y>=28 && y<=31) || (y>=36 && y<=41))) || ((x==62 || x==63) && (y>=28 && y<=39)) || ((x==64 || x==65) && (y>=28 && y<=37));
    wire right_8 = ((x==52 || x==53 || x==64 || x==65) && ((y>=30 && y<=39) || (y>=42 && y<=49))) || ((x==54 || x==55 || x==62 || x==63) && ((y>=28 && y<=51))) || ((x>=56 && x<=61) && ((y>=28 && y<=31) || (y>=38 && y<=41) || (y>=48 && y<=51)));
    wire right_9 = ((x==52 || x==53 ) && ((y>=30 && y<=39))) || ((x==54 || x==55 ) && ((y>=28 && y<=41) || y==50 || y==51)) || ((x==56 || x==57 ) && ((y>=28 && y<=31) || (y>=38 && y<=41) || (y>=48 && y<=51))) || ((x==58 || x==59 ) && ((y>=28 && y<=31) || (y>=38 && y<=41) || (y>=46 && y<=51))) || ((x==60 || x==61 ) && ((y>=28 && y<=31) || (y>=38 && y<=41) || (y>=44 && y<=49))) || ((x==62 || x==63 ) && (y>=30 && y<=47)) || ((x==64 || x==65 ) && (y>=32 && y<=45));  

    always @(posedge clock) begin
     case (score)
       0: begin
           if(YOUR_SCORE || left_0 || right_0)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       1: begin
           if(YOUR_SCORE || left_0 || right_1)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
           end
       2: begin
           if(YOUR_SCORE || left_0 || right_2)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       3: begin
           if(YOUR_SCORE || left_0 || right_3)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       4: begin
           if(YOUR_SCORE || left_0 || right_4)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
           end
       5: begin
           if(YOUR_SCORE || left_0 || right_5)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       6: begin
           if(YOUR_SCORE || left_0 || right_6)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       7: begin
           if(YOUR_SCORE || left_0 || right_7)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       8: begin
           if(YOUR_SCORE || left_0 || right_8)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       9: begin
           if(YOUR_SCORE || left_0 || right_9)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       10: begin
           if(YOUR_SCORE || left_1 || right_0)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       11: begin
           if(YOUR_SCORE || left_1 || right_1)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       12: begin
           if(YOUR_SCORE || left_1 || right_2)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       13: begin
           if(YOUR_SCORE || left_1 || right_3)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       14: begin
           if(YOUR_SCORE || left_1 || right_4)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       15: begin
           if(YOUR_SCORE || left_1 || right_5)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       16: begin
           if(YOUR_SCORE || left_1 || right_6)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       17: begin
           if(YOUR_SCORE || left_1 || right_7)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       18: begin
           if(YOUR_SCORE || left_1 || right_8)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       19: begin
           if(YOUR_SCORE || left_1 || right_9)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       20: begin
           if(YOUR_SCORE || left_2 || right_0)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       21: begin
           if(YOUR_SCORE || left_2 || right_1)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       22: begin
           if(YOUR_SCORE || left_2 || right_2)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       23: begin
           if(YOUR_SCORE || left_2 || right_3)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       24: begin
           if(YOUR_SCORE || left_2 || right_4)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       25: begin
           if(YOUR_SCORE || left_2 || right_5)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       26: begin
           if(YOUR_SCORE || left_2 || right_6)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       27: begin
           if(YOUR_SCORE || left_2 || right_7)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       28: begin
           if(YOUR_SCORE || left_2 || right_8)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       29: begin
           if(YOUR_SCORE || left_2 || right_9)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       30: begin
           if(YOUR_SCORE || left_3 || right_0)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       default: begin
           if(YOUR_SCORE || left_0 || right_0)
           oled_data = `WHITE;
           else
           oled_data = `NAVYBLUE;
       end
       endcase
   end
endmodule
