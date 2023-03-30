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

module grp_oled(
    input clock,
    input clock8hz,
    input [31:0] random_num_1,
    input [31:0] random_num_2,
    input [6:0] x, y,
    input reset,
    input [11:0] mouse_x, mouse_y,
    input [3:0] mouse_z,
    input left, middle, right,
    output reg [15:0] oled_data,
    output reg [3:0] num_state = 4'b1111,
    output reg cursorflag = 0
    );
    reg [1:0] color; // white, green, red, black
    integer i; // used in for loops
    integer random_x_1, random_y_1, random_x_2, random_y_2, random_x_3, random_y_3, random_x_4, random_y_4, 
            random_x_5, random_y_5, random_x_6, random_y_6, random_x_7, random_y_7, random_x_8, random_y_8; //random numbers used for mouse game
            
    reg color_mode_1, color_mode_2 = 0; //used to decide what color to show randomly
    
    always@(random_num_1) begin
        random_x_1 = random_num_1 [7:0] % 95; //modulo to keep value within display range 
        random_y_1 = random_num_1 [7:0] % 63;
        random_x_2 = random_num_1 [15:8] % 95;  
        random_y_2 = random_num_1 [15:8] % 63;
        random_x_3 = random_num_1 [23:16] % 95;  
        random_y_3 = random_num_1 [23:16] % 63;
        random_x_4 = random_num_1 [31:24] % 95;  
        random_y_4 = random_num_1 [31:24] % 63;
        
        if(random_num_1 > 1073741824)
            color_mode_1 = 5;
        else if(random_num_1 > 134217728)
            color_mode_1 = 4;
        else if(random_num_1 > 16777216)
            color_mode_1 = 3;
        else if(random_num_1 > 2097152)
            color_mode_1 = 2;
        else if(random_num_1 > 262144)
            color_mode_1 = 1;
        else
            color_mode_1 = 0;
    end
    
    always@(random_num_2) begin
        random_x_5 = random_num_2 [7:0] % 95; //modulo to keep value within display range 
        random_y_5 = random_num_2 [7:0] % 63;
        random_x_6 = random_num_2 [15:8] % 95;  
        random_y_6 = random_num_2 [15:8] % 63;
        random_x_7 = random_num_2 [23:16] % 95;  
        random_y_7 = random_num_2 [23:16] % 63;
        random_x_8 = random_num_2 [31:24] % 95;  
        random_y_8 = random_num_2 [31:24] % 63;
        
        if(random_num_2 > 1073741824)
            color_mode_2 = 5;
        else if(random_num_2 > 134217728)
            color_mode_2 = 4;
        else if(random_num_2 > 16777216)
            color_mode_2 = 3;
        else if(random_num_2 > 2097152)
            color_mode_2 = 2;
        else if(random_num_2 > 262144)
            color_mode_2 = 1;
        else
            color_mode_2 = 0;
    end
    
    
    // Green Lines
    // sw[8] controls display of green lines
    wire border1, border2, border;
    assign border1 = ((x <= 59) && (y >= 57 && y <= 59));
    assign border2 = ((x >= 57 && x <= 59) && (y <= 59));
    assign border = border1 || border2;

    // We simulate a 7-segment display
    wire [6:0] oled_seg;

    assign oled_seg[0] = (x >= 15 && x <= 39) && (y >= 9 && y <= 13);
    assign oled_seg[1] = (x >= 35 && x <= 39) && (y >= 9 && y <= 28);
    assign oled_seg[2] = (x >= 35 && x <= 39) && (y >= 26 && y <= 45);
    assign oled_seg[3] = (x >= 15 && x <= 39) && (y >= 41 && y <= 45);
    assign oled_seg[4] = (x >= 15 && x <= 19) && (y >= 26 && y <= 45);
    assign oled_seg[5] = (x >= 15 && x <= 19) && (y >= 9 && y <= 28);
    assign oled_seg[6] = (x >= 15 && x <= 39) && (y >= 25 && y <= 29);
    
    wire [6:0] mouse_seg;
    
    assign mouse_seg[0] = (mouse_x >= 15 && mouse_x <= 39) && (mouse_y >= 9 && mouse_y <= 13);
    assign mouse_seg[1] = (mouse_x >= 35 && mouse_x <= 39) && (mouse_y >= 9 && mouse_y <= 28);
    assign mouse_seg[2] = (mouse_x >= 35 && mouse_x <= 39) && (mouse_y >= 26 && mouse_y <= 45);
    assign mouse_seg[3] = (mouse_x >= 15 && mouse_x <= 39) && (mouse_y >= 41 && mouse_y <= 45);
    assign mouse_seg[4] = (mouse_x >= 15 && mouse_x <= 19) && (mouse_y >= 26 && mouse_y <= 45);
    assign mouse_seg[5] = (mouse_x >= 15 && mouse_x <= 19) && (mouse_y >= 9 && mouse_y <= 28);
    assign mouse_seg[6] = (mouse_x >= 15 && mouse_x <= 39) && (mouse_y >= 25 && mouse_y <= 29);

    wire [9:0] num;

    assign num[0] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[4] || oled_seg[5];
    assign num[1] = oled_seg[1] || oled_seg[2];
    assign num[2] = oled_seg[0] || oled_seg[1] || oled_seg[3] || oled_seg[4] || oled_seg[6];
    assign num[3] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[6];
    assign num[4] = oled_seg[1] || oled_seg[2] || oled_seg[5] || oled_seg[6];
    assign num[5] = oled_seg[0] || oled_seg[2] || oled_seg[3] || oled_seg[5] || oled_seg[6];
    assign num[6] = oled_seg[0] || oled_seg[2] || oled_seg[3] || oled_seg[4] || oled_seg[5] || oled_seg[6];
    assign num[7] = oled_seg[0] || oled_seg[1] || oled_seg[2];
    assign num[8] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[4] || oled_seg[5] || oled_seg[6];
    assign num[9] = oled_seg[0] || oled_seg[1] || oled_seg[2] || oled_seg[3] || oled_seg[5] || oled_seg[6];

    // 7-segment border
    wire [13:0] seg_border; // goes from top to bottom or left to right

    assign seg_border[0] = (x >= 15 && x <= 39) && (y == 9);
    assign seg_border[1] = (x >= 15 && x <= 39) && (y == 13);
    assign seg_border[2] = (x == 35) && (y >= 9 && y <= 28);
    assign seg_border[3] = (x == 39) && (y >= 9 && y <= 28);
    assign seg_border[4] = (x == 35) && (y >= 26 && y <= 45);
    assign seg_border[5] = (x == 39) && (y >= 26 && y <= 45);
    assign seg_border[6] = (x >= 15 && x <= 39) && (y == 41);
    assign seg_border[7] = (x >= 15 && x <= 39) && (y == 45);
    assign seg_border[8] = (x == 15) && (y >= 26 && y <= 45);
    assign seg_border[9] = (x == 19) && (y >= 26 && y <= 45);
    assign seg_border[10] = (x == 15) && (y >= 9 && y <= 28);
    assign seg_border[11] = (x == 19) && (y >= 9 && y <= 28);
    assign seg_border[12] = (x >= 15 && x <= 39) && (y == 25);
    assign seg_border[13] = (x >= 15 && x <= 39) && (y == 29);

    // seg_state stores which segments are on
    reg [6:0] seg_state = 7'b0000000;
    // num_state stores number which is displayed on oled
    
    reg change_cursor = 0;
    
    always @ (posedge clock) begin

        if (~change_cursor && mouse_x == x && mouse_y == y)
            oled_data = `RED;
        else if(change_cursor && (((mouse_x == x) && ((mouse_y == y) || (mouse_y == y - 1) || (mouse_y == y - 2) || (mouse_y == y - 3) || (mouse_y == y - 4))) || ((mouse_x == x - 1) && ((mouse_y == y - 1) || (mouse_y == y - 2) || (mouse_y == y - 3) || (mouse_y == y - 4))) || ((mouse_x == x - 2) && ((mouse_y == y - 2) || (mouse_y == y - 3) || (mouse_y == y - 4) || (mouse_y == y - 5))) || ((mouse_x == x-3) && (mouse_y == y - 3))))
            oled_data = `YELLOW;
        else if((random_x_1 == x && random_y_1 == y) || (random_x_2 == x && random_y_2 == y) || (random_x_3 == x && random_y_3 == y) ||(random_x_4 == x && random_y_4 == y)) 
            begin
                case(color_mode_1)
                0: oled_data = `MAGENTA;
                1: oled_data = `GREEN;
                2: oled_data = `BLUE;
                3: oled_data = `YELLOW;
                4: oled_data = `RED;
                5: oled_data = `CYAN;
                endcase
            end
        else if((random_x_5 == x && random_y_5 == y) || (random_x_6 == x && random_y_6 == y) || (random_x_7 == x && random_y_7 == y) ||(random_x_8 == x && random_y_8 == y))
            begin
                case(color_mode_2)
                0: oled_data = `CYAN;
                1: oled_data = `YELLOW;
                2: oled_data = `BLUE;
                3: oled_data = `GREEN;
                4: oled_data = `RED;
                5: oled_data = `MAGENTA;
                endcase
            end
        else if (seg_border)
            oled_data = `WHITE;
        else if (border)
            oled_data = `GREEN;
        else
            oled_data = `BLACK;

        for (i = 0; i < 7; i = i + 1) begin
            if (seg_state[i] && oled_seg[i])
                oled_data = `WHITE;
        end
        
            
        if(reset)
            seg_state = 7'b0000000;
            
        // num_state outputs 1111 when not a num, the number otherwise
        case (seg_state)
            7'b0111111: num_state = 4'b0000;
            7'b0000110: num_state = 4'b0001;
            7'b1011011: num_state = 4'b0010;
            7'b1001111: num_state = 4'b0011;
            7'b1100110: num_state = 4'b0100;
            7'b1101101: num_state = 4'b0101;
            7'b1111101: num_state = 4'b0110;
            7'b0000111: num_state = 4'b0111;
            7'b1111111: num_state = 4'b1000;
            7'b1101111: num_state = 4'b1001;
            default: num_state = 4'b1111;
        endcase
        
//        case (color)
//            2'b11: oled_data = `WHITE;
//            2'b10: oled_data = `GREEN;
//            2'b01: oled_data = `RED;
//            2'b00: oled_data = `BLACK;
//        endcase
 
    // Check when left/right click within segment to set/clear seg_state
    // Not sure if i can use posedge like this tho
    // if click in segment, set associated seg_state to 1        
    
        if(left && mouse_seg[0] && ~seg_state[0])
            seg_state[0] = 1;
        else if (right && mouse_seg[0] && seg_state[0])
            seg_state[0] = 0;
            
        if(left && mouse_seg[1] && ~seg_state[1])
            seg_state[1] = 1;        
        else if(right && mouse_seg[1] && seg_state[1])
           seg_state[1] = 0;
           
        if(left && mouse_seg[2] && ~seg_state[2])
            seg_state[2] = 1;
        else if(right && mouse_seg[2] && seg_state[2])
           seg_state[2] = 0;
           
        if(left && mouse_seg[3] && ~seg_state[3])
            seg_state[3] = 1;
        else if(right && mouse_seg[3] && seg_state[3])
           seg_state[3] = 0;
           
        if(left && mouse_seg[4] && ~seg_state[4])
            seg_state[4] = 1;
        else if(right && mouse_seg[4] && seg_state[4])
            seg_state[4] = 0;
            
        if(left && mouse_seg[5] && ~seg_state[5])
            seg_state[5] = 1;
        else if(right && mouse_seg[5] && seg_state[5])
               seg_state[5] = 0;        
       
       if(left && mouse_seg[6] && ~seg_state[6])
            seg_state[6] = 1;
        else if(right && mouse_seg[6] && seg_state[6])
           seg_state[6] = 0;
           
    end
    
    // Check when middle click to change cursor
    always @ (posedge clock8hz) begin
        if(middle) begin
            change_cursor = ~change_cursor;
            cursorflag = ~cursorflag;
        end
    end
        
endmodule
