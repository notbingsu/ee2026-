`define WIDTH 96
`define HEIGHT 64
`define REDCOLOR 16'hE924
`define BLUECOLOR 16'h23DD
`define PINKCOLOR 16'hFDDF
`define NAVYCOLOR 16'h18CE
`define YELLOWCOLOR 16'hFFB5

module Mouse_Control_Centre (
    input clock,
    inout ps2_clk,
    inout ps2_data,
    input cursorflag,
    output [11:0] mouse_xpos,
    output [11:0] mouse_ypos,
    output left,
    output right,
    output middle,
    output clock8hz
    );
    
    //wires for mouse input signals
    wire [11:0] Mouseposvalue;
    wire reset = 0;
    wire setmax_x, setmax_y, setx, sety;
    
    //wires for unused mouse outputs
    wire [3:0] zpos;
    wire new_event;

    //wires for xy converter output signals
    wire [6:0]curr_x;
    wire [6:0]curr_y;

   
MouseCtl(
    .clk(clock),
    .rst(reset), 
    .xpos(mouse_xpos), 
    .ypos(mouse_ypos), 
    .zpos(zpos), 
    .left(left), 
    .middle(middle), 
    .right(right), 
    .new_event(new_event), 
    .value(Mouseposvalue), 
    .setx(setx), 
    .sety(sety), 
    .setmax_x(setmax_x), 
    .setmax_y(setmax_y), 
    .ps2_clk(ps2_clk), 
    .ps2_data(ps2_data)
    );


Clock_mHz clock5hz(
    .clock(clock),
    .m(8),
    .khzclock(clock8hz)
    );
    
Mouse_config(
    .clock(clock),
    .cursorflag(cursorflag),
    .setmax_x(setmax_x),
    .setmax_y(setmax_y),
    .value(Mouseposvalue)
    );
    
endmodule