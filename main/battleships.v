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

module battleships_1(
    input clock,
    input who_start,
    input other_player_turn,
    input btnC,
    input other_player_dead,
    input [3:0] machine_state,
    input [6:0] x, y,
    input [11:0] mouse_x, mouse_y,
    input left, right,
    output reg [15:0] oled_data,
    output reg dead,
    output reg game_phase,
    output reg player_1_done_setup,
    output [15:0] led
    );
   
    integer i = 0; //for loop
    integer counter = 0;
    
    //wires for mapping out grids
    wire [95:0] grid = 96'b0;
    wire [95:0] mouse_over_grid = 96'b0;
    reg [95:0] fleet_grid = 96'b0;
    reg [95:0] bombed_fleet = 96'b0;
    reg [95:0] bombed_empty = 96'b0;
    wire grid_line = ((y==0 || y==8 || y==16 || y==23 || y==31 || y==39 || y==47 || y==55 || y==63) || (x==0 || x==7 || x==15 || x==23 || x==31 || x==39 || x==47 || x==55 || x==63 || x==71 || x==79 || x==87 || x==95)); 
    wire mouse_cursor  = (x>=mouse_x && x<=(mouse_x+2) && y>=mouse_y && y<=(mouse_y+2));
    
    assign led = fleet_grid[15:0];
    
    assign grid[0] = (x>0 && x<7 && y>0 && y<8);
    assign grid[1] = (x>7 && x<15 && y>0 && y<8);
    assign grid[2]= (x>15 && x<23 && y>0 && y<8);
    assign grid[3] = (x>23 && x<31 && y>0 && y<8);
    assign grid[4] = (x>31 && x<39 && y>0 && y<8);
    assign grid[5] = (x>39 && x<47 && y>0 && y<8);
    assign grid[6] = (x>47 && x<55 && y>0 && y<8);
    assign grid[7] = (x>55 && x<63 && y>0 && y<8);
    assign grid[8] = (x>63 && x<71 && y>0 && y<8);
    assign grid[9] = (x>71 && x<79 && y>0 && y<8);
    assign grid[10] = (x>79 && x<87 && y>0 && y<8);
    assign grid[11] = (x>87 && x<95 && y>0 && y<8);
    
    assign grid[12] = (x>0 && x<7 && y>8 && y<16);
    assign grid[13] = (x>7 && x<15 && y>8 && y<16);
    assign grid[13] = (x>15 && x<23 && y>8 && y<16);
    assign grid[15] = (x>23 && x<31 && y>8 && y<16);
    assign grid[16] = (x>31 && x<39 && y>8 && y<16);
    assign grid[17] = (x>39 && x<47 && y>8 && y<16);
    assign grid[18] = (x>47 && x<55 && y>8 && y<16);
    assign grid[19] = (x>55 && x<63 && y>8 && y<16);
    assign grid[20] = (x>63 && x<71 && y>8 && y<16);
    assign grid[21] = (x>71 && x<79 && y>8 && y<16);
    assign grid[22] = (x>79 && x<87 && y>8 && y<16);
    assign grid[23] = (x>87 && x<95 && y>8 && y<16);
    
    assign grid[24] = (x>0 && x<7 && y>16 && y<23);
    assign grid[25] = (x>7 && x<15 && y>16 && y<23);
    assign grid[26] = (x>15 && x<23 && y>16 && y<23);
    assign grid[27] = (x>23 && x<31 && y>16 && y<23);
    assign grid[28] = (x>31 && x<39 && y>16 && y<23);
    assign grid[29] = (x>39 && x<47 && y>16 && y<23);
    assign grid[30] = (x>47 && x<55 && y>16 && y<23);
    assign grid[31] = (x>55 && x<63 && y>16 && y<23);
    assign grid[32] = (x>63 && x<71 && y>16 && y<23);
    assign grid[33] = (x>71 && x<79 && y>16 && y<23);
    assign grid[34] = (x>79 && x<87 && y>16 && y<23);
    assign grid[35] = (x>87 && x<95 && y>16 && y<23);
    
    assign grid[36] = (x>0 && x<7 && y>23 && y<31);
    assign grid[37] = (x>7 && x<15 && y>23 && y<31);
    assign grid[38] = (x>15 && x<23 && y>23 && y<31);
    assign grid[39] = (x>23 && x<31 && y>23 && y<31);
    assign grid[40] = (x>31 && x<39 && y>23 && y<31);
    assign grid[41] = (x>39 && x<47 && y>23 && y<31);
    assign grid[42] = (x>47 && x<55 && y>23 && y<31);
    assign grid[43] = (x>55 && x<63 && y>23 && y<31);
    assign grid[44] = (x>63 && x<71 && y>23 && y<31);
    assign grid[45] = (x>71 && x<79 && y>23 && y<31);
    assign grid[46] = (x>79 && x<87 && y>23 && y<31);
    assign grid[47] = (x>87 && x<95 && y>23 && y<31);
    
    assign grid[48] = (x>0 && x<7 && y>31 && y<39);
    assign grid[49] = (x>7 && x<15 && y>31 && y<39);
    assign grid[50] = (x>15 && x<23 && y>31 && y<39);
    assign grid[51] = (x>23 && x<31 && y>31 && y<39);
    assign grid[52] = (x>31 && x<39 && y>31 && y<39);
    assign grid[53] = (x>39 && x<47 && y>31 && y<39);
    assign grid[54] = (x>47 && x<55 && y>31 && y<39);
    assign grid[55] = (x>55 && x<63 && y>31 && y<39);
    assign grid[56] = (x>63 && x<71 && y>31 && y<39);
    assign grid[57] = (x>71 && x<79 && y>31 && y<39);
    assign grid[58] = (x>79 && x<87 && y>31 && y<39);
    assign grid[59] = (x>87 && x<95 && y>31 && y<39);
    
    assign grid[60] = (x>0 && x<7 && y>39 && y<47);
    assign grid[61] = (x>7 && x<15 && y>39 && y<47);
    assign grid[62] = (x>15 && x<23 && y>39 && y<47);
    assign grid[63] = (x>23 && x<31 && y>39 && y<47);
    assign grid[64] = (x>31 && x<39 && y>39 && y<47);
    assign grid[65] = (x>39 && x<47 && y>39 && y<47);
    assign grid[66] = (x>47 && x<55 && y>39 && y<47);
    assign grid[67] = (x>55 && x<63 && y>39 && y<47);
    assign grid[68] = (x>63 && x<71 && y>39 && y<47);
    assign grid[69] = (x>71 && x<79 && y>39 && y<47);
    assign grid[70] = (x>79 && x<87 && y>39 && y<47);
    assign grid[71] = (x>87 && x<95 && y>39 && y<47);
    
    assign grid[72] = (x>0 && x<7 && y>47 && y<55);
    assign grid[73] = (x>7 && x<15 && y>47 && y<55);
    assign grid[74] = (x>15 && x<23 && y>47 && y<55);
    assign grid[75] = (x>23 && x<31 && y>47 && y<55);
    assign grid[76] = (x>31 && x<39 && y>47 && y<55);
    assign grid[77] = (x>39 && x<47 && y>47 && y<55);
    assign grid[78] = (x>47 && x<55 && y>47 && y<55);
    assign grid[79] = (x>55 && x<63 && y>47 && y<55);
    assign grid[80] = (x>63 && x<71 && y>47 && y<55);
    assign grid[81] = (x>71 && x<79 && y>47 && y<55);
    assign grid[82] = (x>79 && x<87 && y>47 && y<55);
    assign grid[83] = (x>87 && x<95 && y>47 && y<55);
    
    assign grid[84] = (x>0 && x<7 && y>55 && y<63);
    assign grid[85] = (x>7 && x<15 && y>55 && y<63);
    assign grid[86] = (x>15 && x<23 && y>55 && y<63);
    assign grid[87] = (x>23 && x<31 && y>55 && y<63);
    assign grid[88] = (x>31 && x<39 && y>55 && y<63);
    assign grid[89] = (x>39 && x<47 && y>55 && y<63);
    assign grid[90] = (x>47 && x<55 && y>55 && y<63);
    assign grid[91] = (x>55 && x<63 && y>55 && y<63);
    assign grid[92] = (x>63 && x<71 && y>55 && y<63);
    assign grid[93] = (x>71 && x<79 && y>55 && y<63);
    assign grid[94] = (x>79 && x<87 && y>55 && y<63);
    assign grid[95] = (x>87 && x<95 && y>55 && y<63);
    
    assign mouse_over_grid[0] = (mouse_x>0 && mouse_x<7 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[1] = (mouse_x>7 && mouse_x<15 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[2]= (mouse_x>15 && mouse_x<23 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[3] = (mouse_x>23 && mouse_x<31 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[4] = (mouse_x>31 && mouse_x<39 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[5] = (mouse_x>39 && mouse_x<47 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[6] = (mouse_x>47 && mouse_x<55 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[7] = (mouse_x>55 && mouse_x<63 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[8] = (mouse_x>63 && mouse_x<71 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[9] = (mouse_x>71 && mouse_x<79 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[10] = (mouse_x>79 && mouse_x<87 && mouse_y>0 && mouse_y<8);
    assign mouse_over_grid[11] = (mouse_x>87 && mouse_x<95 && mouse_y>0 && mouse_y<8);
    
    assign mouse_over_grid[12] = (mouse_x>0 && mouse_x<7 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[13] = (mouse_x>7 && mouse_x<15 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[13] = (mouse_x>15 && mouse_x<23 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[15] = (mouse_x>23 && mouse_x<31 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[16] = (mouse_x>31 && mouse_x<39 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[17] = (mouse_x>39 && mouse_x<47 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[18] = (mouse_x>47 && mouse_x<55 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[19] = (mouse_x>55 && mouse_x<63 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[20] = (mouse_x>63 && mouse_x<71 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[21] = (mouse_x>71 && mouse_x<79 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[22] = (mouse_x>79 && mouse_x<87 && mouse_y>8 && mouse_y<16);
    assign mouse_over_grid[23] = (mouse_x>87 && mouse_x<95 && mouse_y>8 && mouse_y<16);
    
    assign mouse_over_grid[24] = (mouse_x>0 && mouse_x<7 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[25] = (mouse_x>7 && mouse_x<15 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[26] = (mouse_x>15 && mouse_x<23 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[27] = (mouse_x>23 && mouse_x<31 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[28] = (mouse_x>31 && mouse_x<39 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[29] = (mouse_x>39 && mouse_x<47 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[30] = (mouse_x>47 && mouse_x<55 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[31] = (mouse_x>55 && mouse_x<63 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[32] = (mouse_x>63 && mouse_x<71 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[33] = (mouse_x>71 && mouse_x<79 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[34] = (mouse_x>79 && mouse_x<87 && mouse_y>16 && mouse_y<23);
    assign mouse_over_grid[35] = (mouse_x>87 && mouse_x<95 && mouse_y>16 && mouse_y<23);
    
    assign mouse_over_grid[36] = (mouse_x>0 && mouse_x<7 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[37] = (mouse_x>7 && mouse_x<15 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[38] = (mouse_x>15 && mouse_x<23 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[39] = (mouse_x>23 && mouse_x<31 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[40] = (mouse_x>31 && mouse_x<39 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[41] = (mouse_x>39 && mouse_x<47 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[42] = (mouse_x>47 && mouse_x<55 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[43] = (mouse_x>55 && mouse_x<63 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[44] = (mouse_x>63 && mouse_x<71 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[45] = (mouse_x>71 && mouse_x<79 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[46] = (mouse_x>79 && mouse_x<87 && mouse_y>23 && mouse_y<31);
    assign mouse_over_grid[47] = (mouse_x>87 && mouse_x<95 && mouse_y>23 && mouse_y<31);
    
    assign mouse_over_grid[48] = (mouse_x>0 && mouse_x<7 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[49] = (mouse_x>7 && mouse_x<15 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[50] = (mouse_x>15 && mouse_x<23 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[51] = (mouse_x>23 && mouse_x<31 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[52] = (mouse_x>31 && mouse_x<39 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[53] = (mouse_x>39 && mouse_x<47 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[54] = (mouse_x>47 && mouse_x<55 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[55] = (mouse_x>55 && mouse_x<63 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[56] = (mouse_x>63 && mouse_x<71 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[57] = (mouse_x>71 && mouse_x<79 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[58] = (mouse_x>79 && mouse_x<87 && mouse_y>31 && mouse_y<39);
    assign mouse_over_grid[59] = (mouse_x>87 && mouse_x<95 && mouse_y>31 && mouse_y<39);
    
    assign mouse_over_grid[60] = (mouse_x>0 && mouse_x<7 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[61] = (mouse_x>7 && mouse_x<15 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[62] = (mouse_x>15 && mouse_x<23 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[63] = (mouse_x>23 && mouse_x<31 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[64] = (mouse_x>31 && mouse_x<39 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[65] = (mouse_x>39 && mouse_x<47 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[66] = (mouse_x>47 && mouse_x<55 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[67] = (mouse_x>55 && mouse_x<63 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[68] = (mouse_x>63 && mouse_x<71 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[69] = (mouse_x>71 && mouse_x<79 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[70] = (mouse_x>79 && mouse_x<87 && mouse_y>39 && mouse_y<47);
    assign mouse_over_grid[71] = (mouse_x>87 && mouse_x<95 && mouse_y>39 && mouse_y<47);
    
    assign mouse_over_grid[72] = (mouse_x>0 && mouse_x<7 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[73] = (mouse_x>7 && mouse_x<15 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[74] = (mouse_x>15 && mouse_x<23 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[75] = (mouse_x>23 && mouse_x<31 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[76] = (mouse_x>31 && mouse_x<39 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[77] = (mouse_x>39 && mouse_x<47 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[78] = (mouse_x>47 && mouse_x<55 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[79] = (mouse_x>55 && mouse_x<63 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[80] = (mouse_x>63 && mouse_x<71 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[81] = (mouse_x>71 && mouse_x<79 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[82] = (mouse_x>79 && mouse_x<87 && mouse_y>47 && mouse_y<55);
    assign mouse_over_grid[83] = (mouse_x>87 && mouse_x<95 && mouse_y>47 && mouse_y<55);
    
    assign mouse_over_grid[84] = (mouse_x>0 && mouse_x<7 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[85] = (mouse_x>7 && mouse_x<15 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[86] = (mouse_x>15 && mouse_x<23 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[87] = (mouse_x>23 && mouse_x<31 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[88] = (mouse_x>31 && mouse_x<39 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[89] = (mouse_x>39 && mouse_x<47 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[90] = (mouse_x>47 && mouse_x<55 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[91] = (mouse_x>55 && mouse_x<63 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[92] = (mouse_x>63 && mouse_x<71 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[93] = (mouse_x>71 && mouse_x<79 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[94] = (mouse_x>79 && mouse_x<87 && mouse_y>55 && mouse_y<63);
    assign mouse_over_grid[95] = (mouse_x>87 && mouse_x<95 && mouse_y>55 && mouse_y<63);
    
    always @ (posedge clock) begin
    if(machine_state == 4'd10) begin
        case(game_phase)
        0: begin //setup ships
            player_1_done_setup = 0;
            dead = 0;
            bombed_fleet = 96'b0;
            bombed_empty = 96'b0;
            fleet_grid = 96'b0;
            
            if(btnC && fleet_grid != 96'b0) begin
            player_1_done_setup = 1;
            game_phase = who_start;
            end
            
            if (~player_1_done_setup) begin
            for (i = 0; i < 96; i = i + 1) begin //initialise by left clicking grids to be counted as fleet
                if(left && mouse_over_grid[i]) 
                fleet_grid[i] = 1;
                
                if (mouse_cursor)
                oled_data = `MILDRED;
                else if(fleet_grid[i] && grid[i]) //only if grid is part of fleet, then colour
                oled_data = `NAVYBLUE;
                else if (grid_line)
                oled_data = `BLUE;
                else
                oled_data = `WHITE;
            end
            end
           
        end
        1: begin //under attack
            if(other_player_turn == 2 || other_player_turn == 0)begin
            if (bombed_fleet == fleet_grid) begin
            game_phase = 3;
            dead = 1; 
            end
            
            else begin
            for (i = 0; i < 96; i = i + 1) begin
                if(right && fleet_grid[i] && mouse_over_grid[i])begin
                bombed_fleet[i] = 1;
                game_phase = 2;
                end
                else if (right && ~fleet_grid[i] && mouse_over_grid[i]) begin
                bombed_empty[i] = 1;
                game_phase = 2;
                end
                
                if (mouse_cursor)
                oled_data = `MILDRED;
                else if(bombed_fleet[i] && grid[i])
                oled_data = `RED;
                else if (bombed_empty[i] && grid[i])
                oled_data = `BROWN;
                else if (grid_line)
                oled_data = `BLUE;
                else
                oled_data = `WHITE;        
            end
            end
            end
        end
        2: begin //launching attack
            if(other_player_turn == 1)begin
            if(other_player_dead)
            game_phase = 3;
         
            else begin
            for (i = 0; i < 96; i = i + 1) begin
            if(bombed_fleet[i] && grid[i])
            oled_data = `RED;
            else if (bombed_empty[i] && grid[i])
            oled_data = `BROWN;
            else if (grid_line)
            oled_data = `BLUE;
            else
            oled_data = `WHITE;
            end
            end
            end
        end
        3: begin //win/lose
            counter = counter + 1;
            if(counter>=1000000000) begin
            game_phase = 0;
            counter = 0;
            end
            else begin
            if(other_player_dead) begin
            oled_data = `RED;
            end
            else if (dead) begin
            oled_data = `GREEN;
            end
            end
        end
        endcase
    end
    end
    
endmodule
