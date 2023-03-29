`timescale 1ns / 1ps

`define YELLOW 16'hFE2C
`define RED 16'hF800
`define WHITE 16'hFFFF
`define GREEN 16'h07E0
`define BLACK 16'h0000
`define CYAN 16'h07FF
`define MAGENTA 16'hF81F
`define BLUE 16'h001F
`define PINK 16'hFD34
`define YELLOWOCHRE 16'hFD8F
`define MILDRED 16'hF32C
`define NAVYBLUE 16'h2107
`define BROWN 16'hD510
`define BIEGE 16'hFF5B
`define PALEBLUE 16'h867F
`define PURPLE 16'hDC1F
`define DARKPURPLE 16'h3889
`define DARKRED 16'h48A2
`define SHADYBLUE 16'h3B11
`define GLOWBLUE 16'hA7BF
`define GLOWGREEN 16'h97F9

module whack_a_mole(
    input clock,
    input clock2hz,
    input SW,
    input [31:0] random_num_2Hz,
    input [31:0] random_num_1Hz,
    input [31:0] random_num_p5Hz,
    input [6:0] x, y,
    input [11:0] mouse_x, mouse_y,
    input [3:0] mouse_z,
    input left, middle, right,
    output reg [15:0] oled_data,
    output reg [4:0] score = 0
    );
    
    //difficulty level set by how fast the mole changes position
   
    //total number of moles whacked
    
    //position of mole
    integer random_x_2Hz, random_y_2Hz, random_x_2_2Hz, random_y_2_2Hz, random_x_1Hz, random_y_1Hz, random_x_p5Hz, random_y_p5Hz;
    
    //mechanism for deciding how fast mole teleports
    always@(random_num_2Hz) begin
        random_x_2Hz = random_num_2Hz[15:0]% 95; //modulo to keep value within display range 
        random_y_2Hz = random_num_2Hz[15:0] % 63;
        random_x_2_2Hz = random_num_2Hz[31:16]% 95;
        random_y_2_2Hz = random_num_2Hz[31:16] % 63;
    end
    
    always@(random_num_1Hz) begin
        random_x_1Hz = random_num_1Hz % 95;  
        random_y_1Hz = random_num_1Hz % 63;
    end
    
    always@(random_num_p5Hz) begin
        random_x_p5Hz = random_num_1Hz % 95; 
        random_y_p5Hz = random_num_1Hz % 63;
    end
    
    //wires for menu displays
    wire W = ((x==16 || x==17 || x==28 || x==29) && y>=4 && y<=9) || ((x==18 || x==19 || x==26 || x==27) && (y==10 || y==11)) || ((x==20 || x==21 || x==24 || x==25) && (y==12 || y==13)) || ((x==22 || x==23) && y>=4 && y<=11);
    wire H = ((x==32 || x==33) &&  y>=4 && y<=13) || ((x==34 ||x==35) && (y==8 || y==9)) || ((x==36 || x==37) && y>=8 && y<=13);
    wire A1 = ((x==40 || x==41 || x==44 || x==45) &&  y>=4 && y<=13) || ((x==42 || x==43) && (y==8 || y==9 || y==4 || y==5));
    wire C = ((x==48 || x==49) && y>=4 && y<=13) || ((x>=50 && x<=53) && (y==4 || y==5 || y==12 || y==13)) ;
    wire K = ((x==56 || x==57) && y>=4 && y<=13) || ((x==58 || x==59) && (y==8 || y==9)) ||((x==60 || x==61) && (y==6 || y==7 || y==10 || y==11)) || ((x==62 || x==63) && (y==4 || y==5 || y==12 || y==13));
    wire WHACK = W || H || A1 || C || K;
    
    wire A2 = ((x==70 || x==71 || x==76 || x==77) && y>=4 && y<=13) || ((x>=72 && x<=75) && (y==4 || y==5 || y==8 || y==9));
    
    wire M = ((x==18 || x==19 || x==30 || x==31) && y>=20 && y<=29) || ((x==20 || x==21 || x==28 || x==29) && (y==20 || y==21)) || ((x==22 | x==23 || x==26 || x==27) && y>=22 && y<=25) || ((x==24 || x==25) && y>=24 && y<=27);
    wire O = ((x==34 || x==35 || x==40 || x==41) && y>=20 && y<=29) || ((x>=36 && x<=39) && (y==20 || y==21 || y==28 || y==29)) ;
    wire L = ((x==44 || x==45) && y>=20 && y<=29) || ((x>=46 && x<=49) && (y==28 || y==29));
    wire E = ((x==52 || x==53) && y>=20 && y<=29) || ((x>=54 && x<=57) && (y==20 || y==21 || y==24 || y==25 || y==28 || y==29)) ;
    wire MOLE = M || O || L || E ;
    
    wire exclamation1 = ((x>=64 && x<=67) && ((y>=20 && y<=25) || y==28 || y==29));
    wire exclamation2 = ((x>=70 && x<=73)&& ((y>=20 && y<=25) || y==28 || y==29));
    wire exclamation3 = ((x>=76 && x<=79)&& ((y>=20 && y<=25) || y==28 || y==29));
    
    wire WHACK_A_MOLE = WHACK || A2 || MOLE || exclamation1 || exclamation2 || exclamation3;
    
    wire level_1 = ((x==18||x==19) && (y>=36 && y<=43)) || ((x==20 || x==21) && (y==42 || y==43)) || ((x==24 || x==25 || x==28 || x==29) && (y>=36 && y<=41)) || ((x==26 || x==27) && (y==42 ||y==43)) || ((x==32 || x==33) && (y>=36 && y<=43)) || ((x==34 || x==35) && (y==42 || y==43)) || ((x==38 || x==39) && (y==36 || y==37 || y==42 || y==43)) || ((x==40 || x==41) && (y>=36 && y<=43)) || ((x==42 || x==43) && (y==42 || y==43));
    wire level_2 = ((x==52||x==53) && (y>=36 && y<=43)) || ((x==54 || x==55) && (y==42 || y==43)) || ((x==58 || x==59 || x==62 || x==63) && (y>=36 && y<=41)) || ((x==60 || x==61) && (y==42 ||y==43)) || ((x==66 || x==67) && (y>=36 && y<=43)) || ((x==68 || x==35) && (y==67 || y==43)) || ((x==72 || x==73) && (y==36 || y==37 ||( y>=40 && y<=43))) || ((x==74 || x==75) && (y==42 || y==43 ||( y>=36 && y<=39)));
    wire level_0 = ((x==18||x==19) && (y>=52 && y<=59)) || ((x==20 || x==21) && (y==58 || y==59)) || ((x==24 || x==25 || x==28 || x==29) && (y>=52 && y<=59)) || ((x==26 || x==27) && (y==58 ||y==59)) || ((x==32 || x==33) && (y>=52 && y<=59)) || ((x==34 || x==35) && (y==58 || y==59)) || ((x==38 || x==39) && (y>=52 && y<=59)) || ((x==40 || x==41) && (y==52 || y==53 || y==58 || y==59)) || ((x==42 || x==43) && (y>=52 && y<=59)); 
    wire box_1 = ((x>=16 && x<=45) && (y>=34 && y<=45));
    wire box_2 = ((x>=50 && x<=77) && (y>=34 && y<=45));
    wire box_0 = ((x>=16 && x<=45) && (y>=50 && y<=61)); 
    
    wire levels = level_1 || level_2 || level_0;
    
    //wires for level displays
    
    wire hammer_body = ((x == mouse_x) && (y == mouse_y-1 || y == mouse_y+1 || y == mouse_y+2)) || ((x == mouse_x+1) && (y == mouse_y || y == mouse_y-1 || y == mouse_y-2)) || ((x == mouse_x+2) && (y == mouse_y || y == mouse_y-1 || y == mouse_y-2 || y == mouse_y -3)) || ((x == mouse_x+3) && (y == mouse_y-1 || y == mouse_y-2)) || ((x == mouse_x-1) && (y == mouse_y || y == mouse_y+1 || y == mouse_y+2 || y==mouse_y+3)) || ((x == mouse_x-2) && (y == mouse_y+1 || y == mouse_y+2 || y==mouse_y+3)) || ((x == mouse_x-3) && (y == mouse_y+2));
    wire hammer_top = ((x == mouse_x) && (y == mouse_y-2)) || ((x == mouse_x+1) && (y == mouse_y-3)) || ((x == mouse_x-1) && (y == mouse_y-1)) || ((x == mouse_x-2) && (y == mouse_y)) || ((x == mouse_x-3) && (y == mouse_y+1));
    wire hammer_handle = ((x == mouse_x+1) && (y == mouse_y+1)) || ((x == mouse_x+2) && (y == mouse_y+2)) || ((x == mouse_x+3) && (y == mouse_y+3)) || ((x == mouse_x+4) && (y == mouse_y+4)) || ((x == mouse_x+5) && (y == mouse_y+5));
    
    wire whacked_hammer_body = ((x == mouse_x) && (y == mouse_y-1 || y == mouse_y-2 || y == mouse_y-3 || y == mouse_y+1 || y == mouse_y+2 || y == mouse_y+3)) || ((x == mouse_x-1) && (y == mouse_y-1 || y == mouse_y-2 || y == mouse_y-3 || y==mouse_y || y == mouse_y+1 || y == mouse_y+2 || y == mouse_y+3)) || ((x == mouse_x+1) && (y == mouse_y-1 || y == mouse_y-2 || y == mouse_y+1 || y == mouse_y+2));
    wire whacked_hammer_top = ((x == mouse_x-2) && (y == mouse_y-2 || y == mouse_y-1 || y == mouse_y || y == mouse_y+1 || y == mouse_y+2));
    wire whacked_hammer_handle = ((x == mouse_x +1 || x == mouse_x +2 || x == mouse_x +3 || x == mouse_x +4 || x == mouse_x +5 || x == mouse_x +6) && (y == mouse_y));
    
    wire normal_mole_body_2Hz = ((x==random_x_2Hz) && (y==random_y_2Hz+2 || y==random_y_2Hz+1 || y==random_y_2Hz-1 || y==random_y_2Hz-2 || y==random_y_2Hz-3 || y==random_y_2Hz-4)) || ((x==random_x_2Hz+1 || x==random_x_2Hz-1) && (y==random_y_2Hz+2 || y==random_y_2Hz+1 || y==random_y_2Hz-3 || y==random_y_2Hz-4)) || ((x==random_x_2Hz+2 || x==random_x_2Hz-2) && (y==random_y_2Hz+2 || y==random_y_2Hz+1 || y==random_y_2Hz || y==random_y_2Hz-3 || y==random_y_2Hz-4)) || ((x==random_x_2Hz+3 || x==random_x_2Hz-3) && (y==random_y_2Hz+2 || y==random_y_2Hz+1 || y==random_y_2Hz || y==random_y_2Hz-1 || y==random_y_2Hz-2 || y==random_y_2Hz-3));
    wire normal_mole_mouth_2Hz = ((x==random_x_2Hz || x==random_x_2Hz+1 || x==random_x_2Hz-1) && (y==random_y_2Hz));
    wire whacked_mole_body_2Hz = ((x==random_x_2Hz) && (y==random_y_2Hz+2 || y==random_y_2Hz-2 || y==random_y_2Hz-3 ||  y==random_y_2Hz-4)) || ((x==random_x_2Hz+1 || x==random_x_2Hz-1) && (y==random_y_2Hz+2 || y==random_y_2Hz-4)) || ((x==random_x_2Hz+2 || x==random_x_2Hz-2) && (y==random_y_2Hz+2 || y==random_y_2Hz-4)) || ((x==random_x_2Hz+3 || x==random_x_2Hz-3) && (y==random_y_2Hz+2 || y==random_y_2Hz+1 || y==random_y_2Hz || y==random_y_2Hz-1 || y==random_y_2Hz-2 || y==random_y_2Hz-3));
    wire whacked_mole_mouth_2Hz = ((x==random_x_2Hz || x==random_x_2Hz+1 || x==random_x_2Hz-1) && (y==random_y_2Hz || y==random_y_2Hz+1)) || ((x==random_x_2Hz+2 || x==random_x_2Hz-2) && (y==random_y_2Hz || y==random_y_2Hz-1 || y==random_y_2Hz+1));
    wire whacked_mole_tongue_2Hz = ((x==random_x_2Hz || x==random_x_2Hz+1 || x==random_x_2Hz-1) && (y==random_y_2Hz+1));
    wire whacked_exclamation_2Hz = ((x==random_x_2Hz-5 || x==random_x_2Hz-6 || x==random_x_2Hz-3) || (y==random_y_2Hz+2 || y==random_y_2Hz || y==random_y_2Hz-1 || y==random_y_2Hz-2 || y==random_y_2Hz-3));
    
    wire normal_mole_body_2_2Hz = ((x==random_x_2_2Hz) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz+1 || y==random_y_2_2Hz-1 || y==random_y_2_2Hz-2 || y==random_y_2_2Hz-3 || y==random_y_2_2Hz-4)) || ((x==random_x_2_2Hz+1 || x==random_x_2_2Hz-1) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz+1 || y==random_y_2_2Hz-3 || y==random_y_2_2Hz-4)) || ((x==random_x_2_2Hz+2 || x==random_x_2_2Hz-2) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz+1 || y==random_y_2_2Hz || y==random_y_2_2Hz-3 || y==random_y_2_2Hz-4)) || ((x==random_x_2_2Hz+3 || x==random_x_2_2Hz-3) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz+1 || y==random_y_2_2Hz || y==random_y_2_2Hz-1 || y==random_y_2_2Hz-2 || y==random_y_2_2Hz-3));
    wire normal_mole_mouth_2_2Hz = ((x==random_x_2_2Hz || x==random_x_2_2Hz+1 || x==random_x_2_2Hz-1) && (y==random_y_2_2Hz));
    wire whacked_mole_body_2_2Hz = ((x==random_x_2_2Hz) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz-2 || y==random_y_2_2Hz-3 ||  y==random_y_2_2Hz-4)) || ((x==random_x_2_2Hz+1 || x==random_x_2_2Hz-1) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz-4)) || ((x==random_x_2_2Hz+2 || x==random_x_2_2Hz-2) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz-4)) || ((x==random_x_2_2Hz+3 || x==random_x_2_2Hz-3) && (y==random_y_2_2Hz+2 || y==random_y_2_2Hz+1 || y==random_y_2_2Hz || y==random_y_2_2Hz-1 || y==random_y_2_2Hz-2 || y==random_y_2_2Hz-3));
    wire whacked_mole_mouth_2_2Hz = ((x==random_x_2_2Hz || x==random_x_2_2Hz+1 || x==random_x_2_2Hz-1) && (y==random_y_2_2Hz || y==random_y_2_2Hz+1)) || ((x==random_x_2_2Hz+2 || x==random_x_2_2Hz-2) && (y==random_y_2_2Hz || y==random_y_2_2Hz-1 || y==random_y_2_2Hz+1));
    wire whacked_mole_tongue_2_2Hz = ((x==random_x_2_2Hz || x==random_x_2_2Hz+1 || x==random_x_2_2Hz-1) && (y==random_y_2_2Hz+1));
    wire whacked_exclamation_2_2Hz = ((x==random_x_2_2Hz-5 || x==random_x_2_2Hz-6 || x==random_x_2_2Hz-3) || (y==random_y_2_2Hz+2 || y==random_y_2_2Hz || y==random_y_2_2Hz-1 || y==random_y_2_2Hz-2 || y==random_y_2_2Hz-3));

    wire normal_mole_body_1Hz = ((x==random_x_1Hz) && (y==random_y_1Hz+2 || y==random_y_1Hz+1 || y==random_y_1Hz-1 || y==random_y_1Hz-2 || y==random_y_1Hz-3 || y==random_y_1Hz-4)) || ((x==random_x_1Hz+1 || x==random_x_1Hz-1) && (y==random_y_1Hz+2 || y==random_y_1Hz+1 || y==random_y_1Hz-3 || y==random_y_1Hz-4)) || ((x==random_x_1Hz+2 || x==random_x_1Hz-2) && (y==random_y_1Hz+2 || y==random_y_1Hz+1 || y==random_y_1Hz || y==random_y_1Hz-3 || y==random_y_1Hz-4)) || ((x==random_x_1Hz+3 || x==random_x_1Hz-3) && (y==random_y_1Hz+2 || y==random_y_1Hz+1 || y==random_y_1Hz || y==random_y_1Hz-1 || y==random_y_1Hz-2 || y==random_y_1Hz-3));
    wire normal_mole_mouth_1Hz = ((x==random_x_1Hz || x==random_x_1Hz+1 || x==random_x_1Hz-1) && (y==random_y_1Hz));
    wire whacked_mole_body_1Hz = ((x==random_x_1Hz) && (y==random_y_1Hz+2 || y==random_y_1Hz-2 || y==random_y_1Hz-3 ||  y==random_y_1Hz-4)) || ((x==random_x_1Hz+1 || x==random_x_1Hz-1) && (y==random_y_1Hz+2 || y==random_y_1Hz-4)) || ((x==random_x_1Hz+2 || x==random_x_1Hz-2) && (y==random_y_1Hz+2 || y==random_y_1Hz-4)) || ((x==random_x_1Hz+3 || x==random_x_1Hz-3) && (y==random_y_1Hz+2 || y==random_y_1Hz+1 || y==random_y_1Hz || y==random_y_1Hz-1 || y==random_y_1Hz-2 || y==random_y_1Hz-3));
    wire whacked_mole_mouth_1Hz = ((x==random_x_1Hz || x==random_x_1Hz+1 || x==random_x_1Hz-1) && (y==random_y_1Hz || y==random_y_1Hz+1)) || ((x==random_x_1Hz+2 || x==random_x_1Hz-2) && (y==random_y_1Hz || y==random_y_1Hz-1 || y==random_y_1Hz+1));
    wire whacked_mole_tongue_1Hz = ((x==random_x_1Hz || x==random_x_1Hz+1 || x==random_x_1Hz-1) && (y==random_y_1Hz+1));
    wire whacked_exclamation_1Hz = ((x==random_x_1Hz-5 || x==random_x_1Hz-6 || x==random_x_1Hz-3) || (y==random_y_1Hz+2 || y==random_y_1Hz || y==random_y_1Hz-1 || y==random_y_1Hz-2 || y==random_y_1Hz-3));

    wire normal_mole_body_p5Hz = ((x==random_x_p5Hz) && (y==random_y_p5Hz+2 || y==random_y_p5Hz+1 || y==random_y_p5Hz-1 || y==random_y_p5Hz-2 || y==random_y_p5Hz-3 || y==random_y_p5Hz-4)) || ((x==random_x_p5Hz+1 || x==random_x_p5Hz-1) && (y==random_y_p5Hz+2 || y==random_y_p5Hz+1 || y==random_y_p5Hz-3 || y==random_y_p5Hz-4)) || ((x==random_x_p5Hz+2 || x==random_x_p5Hz-2) && (y==random_y_p5Hz+2 || y==random_y_p5Hz+1 || y==random_y_p5Hz || y==random_y_p5Hz-3 || y==random_y_p5Hz-4)) || ((x==random_x_p5Hz+3 || x==random_x_p5Hz-3) && (y==random_y_p5Hz+2 || y==random_y_p5Hz+1 || y==random_y_p5Hz || y==random_y_p5Hz-1 || y==random_y_p5Hz-2 || y==random_y_p5Hz-3));
    wire normal_mole_mouth_p5Hz = ((x==random_x_p5Hz || x==random_x_p5Hz+1 || x==random_x_p5Hz-1) && (y==random_y_p5Hz));
    wire whacked_mole_body_p5Hz = ((x==random_x_p5Hz) && (y==random_y_p5Hz+2 || y==random_y_p5Hz-2 || y==random_y_p5Hz-3 ||  y==random_y_p5Hz-4)) || ((x==random_x_p5Hz+1 || x==random_x_p5Hz-1) && (y==random_y_p5Hz+2 || y==random_y_p5Hz-4)) || ((x==random_x_p5Hz+2 || x==random_x_p5Hz-2) && (y==random_y_p5Hz+2 || y==random_y_p5Hz-4)) || ((x==random_x_p5Hz+3 || x==random_x_p5Hz-3) && (y==random_y_p5Hz+2 || y==random_y_p5Hz+1 || y==random_y_p5Hz || y==random_y_p5Hz-1 || y==random_y_p5Hz-2 || y==random_y_p5Hz-3));
    wire whacked_mole_mouth_p5Hz = ((x==random_x_p5Hz || x==random_x_p5Hz+1 || x==random_x_p5Hz-1) && (y==random_y_p5Hz || y==random_y_p5Hz+1)) || ((x==random_x_p5Hz+2 || x==random_x_p5Hz-2) && (y==random_y_p5Hz || y==random_y_p5Hz-1 || y==random_y_p5Hz+1));
    wire whacked_mole_tongue_p5Hz = ((x==random_x_p5Hz || x==random_x_p5Hz+1 || x==random_x_p5Hz-1) && (y==random_y_p5Hz+1));
    wire whacked_exclamation_p5Hz = ((x==random_x_p5Hz-5 || x==random_x_p5Hz-6 || x==x==random_x_p5Hz-3) || (y==random_y_p5Hz+2 || y==random_y_p5Hz || y==random_y_p5Hz-1 || y==random_y_p5Hz-2 || y==random_y_p5Hz-3));

    wire on_level_0 = ((mouse_x>=16 && mouse_x<=45) && (mouse_y>=50 && mouse_y<=61));
    wire on_level_1 = ((mouse_x>=16 && mouse_x<=45) && (mouse_y>=34 && mouse_y<=45));
    wire on_level_2 = ((mouse_x>=50 && mouse_x<=77) && (mouse_y>=34 && mouse_y<=45));
    wire on_mole_2Hz = ((mouse_x==random_x_2Hz) && (mouse_y==random_y_2Hz+2 || mouse_y==random_y_2Hz+1 || mouse_y==random_y_2Hz-1 || mouse_y==random_y_2Hz-2 || mouse_y==random_y_2Hz-3 || mouse_y==random_y_2Hz-4)) || ((mouse_x==random_x_2Hz+1 || mouse_x==random_x_2Hz-1) && (mouse_y==random_y_2Hz+2 || mouse_y==random_y_2Hz+1 || mouse_y==random_y_2Hz-3 || mouse_y==random_y_2Hz-4)) || ((mouse_x==random_x_2Hz+2 || mouse_x==random_x_2Hz-2) && (mouse_y==random_y_2Hz+2 || mouse_y==random_y_2Hz+1 || mouse_y==random_y_2Hz || mouse_y==random_y_2Hz-3 || mouse_y==random_y_2Hz-4)) || ((mouse_x==random_x_2Hz+3 || mouse_x==random_x_2Hz-3) && (mouse_y==random_y_2Hz+2 || mouse_y==random_y_2Hz+1 || mouse_y==random_y_2Hz || mouse_y==random_y_2Hz-1 || mouse_y==random_y_2Hz-2 || mouse_y==random_y_2Hz-3)) || ((mouse_x==random_x_2Hz || mouse_x==random_x_2Hz+1 || mouse_x==random_x_2Hz-1) && (mouse_y==random_y_2Hz));
    wire on_mole_2_2Hz = ((mouse_x==random_x_2_2Hz) && (mouse_y==random_y_2_2Hz+2 || mouse_y==random_y_2_2Hz+1 || mouse_y==random_y_2_2Hz-1 || mouse_y==random_y_2_2Hz-2 || mouse_y==random_y_2_2Hz-3 || mouse_y==random_y_2_2Hz-4)) || ((mouse_x==random_x_2_2Hz+1 || mouse_x==random_x_2_2Hz-1) && (mouse_y==random_y_2_2Hz+2 || mouse_y==random_y_2_2Hz+1 || mouse_y==random_y_2_2Hz-3 || mouse_y==random_y_2_2Hz-4)) || ((mouse_x==random_x_2_2Hz+2 || mouse_x==random_x_2_2Hz-2) && (mouse_y==random_y_2_2Hz+2 || mouse_y==random_y_2_2Hz+1 || mouse_y==random_y_2_2Hz || mouse_y==random_y_2_2Hz-3 || mouse_y==random_y_2_2Hz-4)) || ((mouse_x==random_x_2_2Hz+3 || mouse_x==random_x_2_2Hz-3) && (mouse_y==random_y_2_2Hz+2 || mouse_y==random_y_2_2Hz+1 || mouse_y==random_y_2_2Hz || mouse_y==random_y_2_2Hz-1 || mouse_y==random_y_2_2Hz-2 || mouse_y==random_y_2_2Hz-3)) || ((mouse_x==random_x_2_2Hz || mouse_x==random_x_2_2Hz+1 || mouse_x==random_x_2_2Hz-1) && (mouse_y==random_y_2_2Hz));
    wire on_mole_1Hz = ((mouse_x==random_x_1Hz) && (mouse_y==random_y_1Hz+2 || mouse_y==random_y_1Hz+1 || mouse_y==random_y_1Hz-1 || mouse_y==random_y_1Hz-2 || mouse_y==random_y_1Hz-3 || mouse_y==random_y_1Hz-4)) || ((mouse_x==random_x_1Hz+1 || mouse_x==random_x_1Hz-1) && (mouse_y==random_y_1Hz+2 || mouse_y==random_y_1Hz+1 || mouse_y==random_y_1Hz-3 || mouse_y==random_y_1Hz-4)) || ((mouse_x==random_x_1Hz+2 || mouse_x==random_x_1Hz-2) && (mouse_y==random_y_1Hz+2 || mouse_y==random_y_1Hz+1 || mouse_y==random_y_1Hz || mouse_y==random_y_1Hz-3 || mouse_y==random_y_1Hz-4)) || ((mouse_x==random_x_1Hz+3 || mouse_x==random_x_1Hz-3) && (mouse_y==random_y_1Hz+2 || mouse_y==random_y_1Hz+1 || mouse_y==random_y_1Hz || mouse_y==random_y_1Hz-1 || mouse_y==random_y_1Hz-2 || mouse_y==random_y_1Hz-3)) || ((mouse_x==random_x_1Hz || mouse_x==random_x_1Hz+1 || mouse_x==random_x_1Hz-1) && (mouse_y==random_y_1Hz));
    wire on_mole_p5Hz = ((mouse_x==random_x_p5Hz) && (mouse_y==random_y_p5Hz+2 || mouse_y==random_y_p5Hz+1 || mouse_y==random_y_p5Hz-1 || mouse_y==random_y_p5Hz-2 || mouse_y==random_y_p5Hz-3 || mouse_y==random_y_p5Hz-4)) || ((mouse_x==random_x_p5Hz+1 || mouse_x==random_x_p5Hz-1) && (mouse_y==random_y_p5Hz+2 || mouse_y==random_y_p5Hz+1 || mouse_y==random_y_p5Hz-3 || mouse_y==random_y_p5Hz-4)) || ((mouse_x==random_x_p5Hz+2 || mouse_x==random_x_p5Hz-2) && (mouse_y==random_y_p5Hz+2 || mouse_y==random_y_p5Hz+1 || mouse_y==random_y_p5Hz || mouse_y==random_y_p5Hz-3 || mouse_y==random_y_p5Hz-4)) || ((mouse_x==random_x_p5Hz+3 || mouse_x==random_x_p5Hz-3) && (mouse_y==random_y_p5Hz+2 || mouse_y==random_y_p5Hz+1 || mouse_y==random_y_p5Hz || mouse_y==random_y_p5Hz-1 || mouse_y==random_y_p5Hz-2 || mouse_y==random_y_p5Hz-3)) || ((mouse_x==random_x_p5Hz || mouse_x==random_x_p5Hz+1 || mouse_x==random_x_p5Hz-1) && (mouse_y==random_y_p5Hz));
    
    
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
        
    //gameplay only allowed for 30s
    integer counter, counter2 = 0;
    
    //state used to decide which screen to show
    integer toggle_screen = 0;

    //player given 30 seconds of gameplay and 10 seconds to look at final score
    //oled display setup
    always @ (posedge clock) begin
        
        case(toggle_screen)
        //menu screen displays
        0: begin
            counter = 0;
            if(~left) begin
                if(hammer_body)
                oled_data = `CYAN;
                else if (hammer_top)
                oled_data = `YELLOW;
                else if (hammer_handle)
                oled_data = `BIEGE;
                else if(H || A2 || E || exclamation3 || (box_0 && ~level_0))
                oled_data = `PINK;
                else if (W || O || exclamation2 || (box_1 && ~level_1))
                oled_data = `YELLOWOCHRE;
                else if (A1 || exclamation1 || (box_2 && ~level_2) || ((x == mouse_x) && (y==mouse_y)) )
                oled_data = `MILDRED;
                else if (C || K || M || L || levels || normal_mole_mouth_p5Hz)
                oled_data = `WHITE;
                else if (normal_mole_body_p5Hz)
                oled_data = `PALEBLUE;
                else 
                oled_data = `NAVYBLUE;
            end
            else begin
                if(on_level_0)
                    toggle_screen = 1;
                else if (on_level_1)
                    toggle_screen = 2;
                else if (on_level_2)
                    toggle_screen = 3;
                else begin
                    toggle_screen <= 0;
                    if(whacked_hammer_body)
                    oled_data = `CYAN;
                    else if (whacked_hammer_top)
                    oled_data = `YELLOW;
                    else if (whacked_hammer_handle)
                    oled_data = `BIEGE;
                    else if(H || A2 || E || exclamation3 || (box_0 && ~level_0))
                    oled_data = `PINK;
                    else if (W || O || exclamation2 || (box_1 && ~level_1))
                    oled_data = `YELLOWOCHRE;
                    else if (A1 || exclamation1 || (box_2 && ~level_2) || ((x == mouse_x) && (y==mouse_y)) )
                    oled_data = `MILDRED;
                    else if (C || K || M || L || levels || normal_mole_mouth_p5Hz)
                    oled_data = `WHITE;
                    else if (normal_mole_body_p5Hz)
                    oled_data = `PALEBLUE;
                    else 
                    oled_data = `NAVYBLUE;
                end
            end
        end
        
        //difficulty 1 displays
        1: begin
            counter = counter + 1;
            if(counter>=2000000000) begin
                toggle_screen = 4;
                counter = 0;
            end
            else begin
                if(~left) begin
                    if(hammer_body)
                    oled_data = `CYAN;
                    else if (hammer_top)
                    oled_data = `YELLOW;
                    else if (hammer_handle)
                    oled_data = `BIEGE;
                    else if (normal_mole_body_p5Hz)
                    oled_data = `PALEBLUE;
                    else if (normal_mole_mouth_p5Hz)
                    oled_data = `WHITE;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `NAVYBLUE;
                end
                else if (left && ~on_mole_p5Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `CYAN;
                    else if (whacked_hammer_top)
                    oled_data = `YELLOW;
                    else if (whacked_hammer_handle)
                    oled_data = `BIEGE;
                    else if (normal_mole_body_p5Hz)
                    oled_data = `PALEBLUE;
                    else if (normal_mole_mouth_p5Hz)
                    oled_data = `WHITE;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `NAVYBLUE;
                end
                else if (left && on_mole_p5Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `CYAN;
                    else if (whacked_hammer_top)
                    oled_data = `YELLOW;
                    else if (whacked_hammer_handle)
                    oled_data = `BIEGE;
                    else if (whacked_mole_body_p5Hz)
                    oled_data = `PALEBLUE;
                    else if (whacked_mole_mouth_p5Hz || whacked_exclamation_p5Hz)
                    oled_data = `WHITE;
                    else if (whacked_mole_tongue_p5Hz || ((x == mouse_x) && (y==mouse_y)))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `NAVYBLUE;
                end                     
            end
        end
        
       //difficulty 2 displays
        2: begin
            counter = counter + 1;
            if(counter>=2000000000) begin
                toggle_screen = 4;
                counter = 0;
            end
            else begin
                if(~left) begin
                    if(hammer_body)
                    oled_data = `CYAN;
                    else if (hammer_top)
                    oled_data = `YELLOW;
                    else if (hammer_handle)
                    oled_data = `BIEGE;
                    else if (normal_mole_body_1Hz)
                    oled_data = `PURPLE;
                    else if (normal_mole_mouth_1Hz)
                    oled_data = `WHITE;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `DARKPURPLE;
                end
                else if (left && ~on_mole_1Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `CYAN;
                    else if (whacked_hammer_top)
                    oled_data = `YELLOW;
                    else if (whacked_hammer_handle)
                    oled_data = `BIEGE;
                    else if (normal_mole_body_1Hz)
                    oled_data = `PURPLE;
                    else if (normal_mole_mouth_1Hz)
                    oled_data = `WHITE;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `DARKPURPLE;
                end
                else if (left && on_mole_1Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `CYAN;
                    else if (whacked_hammer_top)
                    oled_data = `YELLOW;
                    else if (whacked_hammer_handle)
                    oled_data = `BIEGE;
                    else if (whacked_mole_body_1Hz)
                    oled_data = `PURPLE;
                    else if (whacked_mole_mouth_1Hz || whacked_exclamation_1Hz)
                    oled_data = `WHITE;
                    else if (whacked_mole_tongue_1Hz || ((x == mouse_x) && (y==mouse_y)))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `DARKPURPLE;
                end
            end
        end
                    
        //difficulty 3 displays
        3: begin
            counter = counter + 1;
            if(counter>=2000000000) begin
                toggle_screen = 4;
                counter = 0;
            end
            else if (counter == (random_num_2Hz%2000000000))
                toggle_screen = 5;
            else begin
            if(~SW) begin
                if(~left) begin
                    if(hammer_body)
                    oled_data = `CYAN;
                    else if (hammer_top)
                    oled_data = `YELLOW;
                    else if (hammer_handle)
                    oled_data = `BIEGE;
                    else if (normal_mole_body_2Hz)
                    oled_data = `RED;
                    else if (normal_mole_mouth_2Hz)
                    oled_data = `WHITE;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `DARKRED;
                end
                else if (left && ~on_mole_2Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `CYAN;
                    else if (whacked_hammer_top)
                    oled_data = `YELLOW;
                    else if (whacked_hammer_handle)
                    oled_data = `BIEGE;
                    else if (normal_mole_body_2Hz)
                    oled_data = `RED;
                    else if (normal_mole_mouth_2Hz)
                    oled_data = `WHITE;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `DARKRED;
                end
                else if (left && on_mole_2Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `CYAN;
                    else if (whacked_hammer_top)
                    oled_data = `YELLOW;
                    else if (whacked_hammer_handle)
                    oled_data = `BIEGE;
                    else if (whacked_mole_body_2Hz)
                    oled_data = `RED;
                    else if (whacked_mole_mouth_2Hz || whacked_exclamation_2Hz)
                    oled_data = `WHITE;
                    else if (whacked_mole_tongue_2Hz || ((x == mouse_x) && (y==mouse_y)))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `DARKRED;
                end
            end
            else begin
                if(~left) begin
                if(hammer_body)
                oled_data = `CYAN;
                else if (hammer_top)
                oled_data = `YELLOW;
                else if (hammer_handle)
                oled_data = `BIEGE;
                else if (normal_mole_body_2Hz )
                oled_data = `RED;
                else if (normal_mole_body_2_2Hz )
                oled_data = `YELLOWOCHRE;
                else if (normal_mole_mouth_2Hz || normal_mole_mouth_2_2Hz)
                oled_data = `WHITE;
                else if ((x == mouse_x) && (y==mouse_y))
                oled_data = `MILDRED;
                else 
                oled_data = `DARKRED;
            end
            else if (left && ~on_mole_2Hz && ~on_mole_2_2Hz) begin
                if(whacked_hammer_body)
                oled_data = `CYAN;
                else if (whacked_hammer_top)
                oled_data = `YELLOW;
                else if (whacked_hammer_handle)
                oled_data = `BIEGE;
                else if (normal_mole_body_2Hz)
                oled_data = `RED;
                else if (normal_mole_body_2_2Hz )
                oled_data = `YELLOWOCHRE;
                else if (normal_mole_mouth_2Hz || normal_mole_mouth_2_2Hz)
                oled_data = `WHITE;
                else if ((x == mouse_x) && (y==mouse_y))
                oled_data = `MILDRED;
                else 
                oled_data = `DARKRED;
            end
            else if (left && on_mole_2Hz && ~on_mole_2_2Hz) begin
                if(whacked_hammer_body)
                oled_data = `CYAN;
                else if (whacked_hammer_top)
                oled_data = `YELLOW;
                else if (whacked_hammer_handle)
                oled_data = `BIEGE;
                else if (normal_mole_body_2_2Hz )
                oled_data = `YELLOWOCHRE;
                else if (whacked_mole_body_2Hz)
                oled_data = `RED;
                else if (whacked_mole_mouth_2Hz || whacked_exclamation_2Hz || normal_mole_mouth_2_2Hz)
                oled_data = `WHITE;
                else if (whacked_mole_tongue_2Hz || ((x == mouse_x) && (y==mouse_y)))
                oled_data = `MILDRED;
                else 
                oled_data = `DARKRED;
            end
            else if (left && ~on_mole_2Hz && on_mole_2_2Hz) begin
                if(whacked_hammer_body)
                oled_data = `CYAN;
                else if (whacked_hammer_top)
                oled_data = `YELLOW;
                else if (whacked_hammer_handle)
                oled_data = `BIEGE;
                else if (normal_mole_body_2Hz)
                oled_data = `RED;
                else if (whacked_mole_body_2_2Hz)
                oled_data = `YELLOWOCHRE;
                else if (whacked_mole_mouth_2_2Hz || whacked_exclamation_2_2Hz || normal_mole_mouth_2Hz)
                oled_data = `WHITE;
                else if (whacked_mole_tongue_2_2Hz || ((x == mouse_x) && (y==mouse_y)))
                oled_data = `MILDRED;
                else 
                oled_data = `DARKRED;
            end
            else if (left && on_mole_2Hz && on_mole_2_2Hz) begin
                if(whacked_hammer_body)
                oled_data = `CYAN;
                else if (whacked_hammer_top)
                oled_data = `YELLOW;
                else if (whacked_hammer_handle)
                oled_data = `BIEGE;
                else if (whacked_mole_body_2Hz)
                oled_data = `RED;
                else if (whacked_mole_body_2_2Hz)
                oled_data = `YELLOWOCHRE;
                else if (whacked_mole_mouth_2_2Hz || whacked_exclamation_2_2Hz || whacked_mole_mouth_2Hz || whacked_exclamation_2Hz )
                oled_data = `WHITE;
                else if (whacked_mole_tongue_2_2Hz || whacked_mole_tongue_2Hz || ((x == mouse_x) && (y==mouse_y)))
                oled_data = `MILDRED;
                else 
                oled_data = `DARKRED;
            end
            end
            end
        end
            
        //gameplay ends displays
        4: begin
            counter = counter + 1;
            if(counter>=1000000000) begin
            toggle_screen = 0;
            counter = 0;
            end
            else begin
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
        end  
        5: begin
            counter = counter +1;
            counter2 = counter2 + 1;
            if(counter2>=300000000 && counter < 2000000000) begin
                toggle_screen = 3;
                counter2 = 0;
            end
            else if (counter >= 2000000000) begin
                toggle_screen = 4;
                counter = 0;
            end
            else begin
                if(~SW) begin
                    if(~left) begin
                        if(hammer_body)
                        oled_data = `WHITE;
                        else if (hammer_top)
                        oled_data = `WHITE;
                        else if (hammer_handle)
                        oled_data = `WHITE;
                        else if (normal_mole_body_2Hz)
                        oled_data = `GLOWBLUE;
                        else if (normal_mole_mouth_2Hz)
                        oled_data = `BLACK;
                        else if ((x == mouse_x) && (y==mouse_y))
                        oled_data = `MILDRED;
                        else 
                        oled_data = `SHADYBLUE;
                    end
                    else if (left && ~on_mole_2Hz) begin
                        if(whacked_hammer_body)
                        oled_data = `WHITE;
                        else if (whacked_hammer_top)
                        oled_data = `WHITE;
                        else if (whacked_hammer_handle)
                        oled_data = `WHITE;
                        else if (normal_mole_body_2Hz)
                        oled_data = `GLOWBLUE;
                        else if (normal_mole_mouth_2Hz)
                        oled_data = `BLACK;
                        else if ((x == mouse_x) && (y==mouse_y))
                        oled_data = `MILDRED;
                        else 
                        oled_data = `SHADYBLUE;
                    end
                    else if (left && on_mole_2Hz) begin
                        if(whacked_hammer_body)
                        oled_data = `WHITE;
                        else if (whacked_hammer_top)
                        oled_data = `WHITE;
                        else if (whacked_hammer_handle)
                        oled_data = `WHITE;
                        else if (whacked_mole_body_2Hz)
                        oled_data = `GLOWBLUE;
                        else if (whacked_mole_mouth_2Hz || whacked_exclamation_2Hz)
                        oled_data = `BLACK;
                        else if (whacked_mole_tongue_2Hz || ((x == mouse_x) && (y==mouse_y)))
                        oled_data = `MILDRED;
                        else 
                        oled_data = `SHADYBLUE;
                    end
                end
                else begin
                    if(~left) begin
                    if(hammer_body)
                    oled_data = `WHITE;
                    else if (hammer_top)
                    oled_data = `WHITE;
                    else if (hammer_handle)
                    oled_data = `WHITE;
                    else if (normal_mole_body_2Hz )
                    oled_data = `GLOWBLUE;
                    else if (normal_mole_body_2_2Hz )
                    oled_data = `GLOWGREEN;
                    else if (normal_mole_mouth_2Hz || normal_mole_mouth_2_2Hz)
                    oled_data = `BLACK;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `SHADYBLUE;
                end
                else if (left && ~on_mole_2Hz && ~on_mole_2_2Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `WHITE;
                    else if (whacked_hammer_top)
                    oled_data = `WHITE;
                    else if (whacked_hammer_handle)
                    oled_data = `WHITE;
                    else if (normal_mole_body_2Hz)
                    oled_data = `GLOWBLUE;
                    else if (normal_mole_body_2_2Hz )
                    oled_data = `GLOWGREEN;
                    else if (normal_mole_mouth_2Hz || normal_mole_mouth_2_2Hz)
                    oled_data = `BLACK;
                    else if ((x == mouse_x) && (y==mouse_y))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `SHADYBLUE;
                end
                else if (left && on_mole_2Hz && ~on_mole_2_2Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `WHITE;
                    else if (whacked_hammer_top)
                    oled_data = `WHITE;
                    else if (whacked_hammer_handle)
                    oled_data = `WHITE;
                    else if (normal_mole_body_2_2Hz )
                    oled_data = `GLOWGREEN;
                    else if (whacked_mole_body_2Hz)
                    oled_data = `GLOWBLUE;
                    else if (whacked_mole_mouth_2Hz || whacked_exclamation_2Hz || normal_mole_mouth_2_2Hz)
                    oled_data = `BLACK;
                    else if (whacked_mole_tongue_2Hz || ((x == mouse_x) && (y==mouse_y)))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `SHADYBLUE;
                end
                else if (left && ~on_mole_2Hz && on_mole_2_2Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `WHITE;
                    else if (whacked_hammer_top)
                    oled_data = `WHITE;
                    else if (whacked_hammer_handle)
                    oled_data = `WHITE;
                    else if (normal_mole_body_2Hz)
                    oled_data = `GLOWBLUE;
                    else if (whacked_mole_body_2_2Hz)
                    oled_data = `GLOWGREEN;
                    else if (whacked_mole_mouth_2_2Hz || whacked_exclamation_2_2Hz || normal_mole_mouth_2Hz)
                    oled_data = `BLACK;
                    else if (whacked_mole_tongue_2_2Hz || ((x == mouse_x) && (y==mouse_y)))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `SHADYBLUE;
                end
                else if (left && on_mole_2Hz && on_mole_2_2Hz) begin
                    if(whacked_hammer_body)
                    oled_data = `WHITE;
                    else if (whacked_hammer_top)
                    oled_data = `WHITE;
                    else if (whacked_hammer_handle)
                    oled_data = `WHITE;
                    else if (whacked_mole_body_2Hz)
                    oled_data = `GLOWBLUE;
                    else if (whacked_mole_body_2_2Hz)
                    oled_data = `GLOWGREEN;
                    else if (whacked_mole_mouth_2_2Hz || whacked_exclamation_2_2Hz || whacked_mole_mouth_2Hz || whacked_exclamation_2Hz )
                    oled_data = `BLACK;
                    else if (whacked_mole_tongue_2_2Hz || whacked_mole_tongue_2Hz || ((x == mouse_x) && (y==mouse_y)))
                    oled_data = `MILDRED;
                    else 
                    oled_data = `SHADYBLUE;
                end
                end
            end
        end
        endcase
    end
    
    always @ (posedge left) begin
        if((on_mole_2Hz && toggle_screen == 3 && ~SW) || (on_mole_1Hz && toggle_screen == 2) || (on_mole_p5Hz && toggle_screen == 1) || (on_mole_2Hz && ~on_mole_2_2Hz && toggle_screen == 3 && SW) || (~on_mole_2Hz && on_mole_2_2Hz && toggle_screen == 3 && SW))
        score = score + 1;
        else if ((on_mole_2Hz && toggle_screen == 5 && ~SW) || (on_mole_2Hz && ~on_mole_2_2Hz && toggle_screen == 5 && SW) || (~on_mole_2Hz && on_mole_2_2Hz && toggle_screen == 5 && SW))
        score = (score==0)? 0: score - 1;
        else if (toggle_screen == 0)
        score = 0;
    end
    
endmodule
