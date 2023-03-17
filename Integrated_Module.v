module integrated_grp(
    input clock,
    inout ps2_clk,
    inout ps2_data,
    input [15:0] sw,
    output [15:0] led,
    output [7:0] JC,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    
    //wires for clocks
    wire clock8hz;
    
    //wires from mouse module to OLED module
    wire [11:0] mouse_x, mouse_y;
    wire left, right, middle, cursorflag;
    
    // Oled wires
    wire [6:0] oled_x, oled_y;
    wire [15:0] oled_data;
    
    // number displayed on oled as selected if applicable
    wire [3:0] num;
    
    // reset state flag
    wire reset;
    
    Mouse_Control_Centre (
        .clock(clock),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .cursorflag(cursorflag),
        .mouse_xpos(mouse_x),
        .mouse_ypos(mouse_y),
        .left(left),
        .right(right),
        .middle(middle),
        .clock8hz(clock8hz)
        );
        
    grp_oled(
        .clock(clock),
        .clock8hz(clock8hz),
        .x(oled_x),
        .y(oled_y),
        .reset(reset),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .left(left), 
        .middle(middle), 
        .right(right),
        .oled_data(oled_data),
        .num_state(num),
        .cursorflag(cursorflag)
        );
        
    init_grp_oled(
        .clock(clock),
        .oled_data(oled_data),
        .x(oled_x), 
        .y(oled_y),
        .JC(JC)
        );
        
    segment_control(
        .clock(clock),
        .num(num),
        .seg(seg),
        .an(an),
        .dp(dp)
        );
        
    valid_num(
        .clock(clock),
        .num(num), 
        .sw(sw[15]), 
        .reset(reset), 
        .led(led[15])
        );
    
endmodule