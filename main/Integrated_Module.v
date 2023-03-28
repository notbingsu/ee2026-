module integrated_grp(
    input clock,
    inout ps2_clk,
    inout ps2_data,
    input [15:0] sw,
    input btnC,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input J_MIC_Pin3,
    output [15:0] led,
    output [3:0] JB,
    output [7:0] JC,
    output J_MIC_Pin1, 
    output J_MIC_Pin4,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    
    //wires for clocks
    wire clock8hz, clock20khz, clock20hz;
    
    //wires from mouse module to OLED module
    wire [11:0] mouse_x, mouse_y;
    wire left, right, middle, cursorflag;
    
    // Oled wires
    wire [6:0] oled_x, oled_y;
    wire [15:0] oled_data;
    // registers for oled control
    wire [15:0] oled_state_0;
    wire [15:0] oled_state_1;
    wire [15:0] oled_state_2;
    wire [15:0] oled_state_3;
    wire [15:0] oled_state_4;
    wire [15:0] oled_state_5;
    wire [15:0] oled_state_6;
    wire [15:0] oled_state_7;
    wire [15:0] oled_state_8;
    
    // number displayed on oled as selected if applicable
    wire [3:0] num;
    
    // reset state flag
    wire reset;
    
    //wires for segment control signals
    wire [6:0] seg_audio_in;
    wire [3:0] an_audio_in;
    
    //wires for audio input module signals
    wire [11:0] mic_in;
    wire [10:0] mic_num;
    
    //wires for led control from different modules
    wire led15; //from valid_num
    wire [8:0] led_audio_in; //from audio_in

    // menu state machine
    reg [2:0] machine_state = 3'b0;
    wire [2:0] menu_state;
    reg [31:0] release_count = 0;
	reg [1:0] btnC_state = 0;
    reg [1:0] btnL_state = 0;
    
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
        .sw(sw[15]),
        .seg_audio_in(seg_audio_in),
        .an_audio_in(an_audio_in),
        .num(num),
        .seg(seg),
        .an(an),
        .dp(dp)
        );
        
    led_control(
        .led15(led15),
        .led_audio_in(led_audio_in),
        .led(led)
        );
        
    valid_num(
        .clock(clock),
        .num(num), 
        .sw(sw[15]), 
        .reset(reset), 
        .led(led15)
        );
        
    audiocontrol(
        .clock(clock),
        .btnC(btnC),
        .sw0(sw[0]),
        .sw15(sw[15]),
        .num(num),
        .JB(JB)
        );
        
    Audio_Input MIC_in(
        .CLK(clock), 
        .cs(clock20khz), 
        .MISO(J_MIC_Pin3), 
        .clk_samp(J_MIC_Pin1), 
        .sclk(J_MIC_Pin4), 
        .sample(mic_in)
        );
        
    interval_max_output(
        .clk_display(clock20hz), 
        .clk_peak(clock20khz), 
        .signal(mic_in), 
        .k(1000),
        .led(led_audio_in),
        .an(an_audio_in),
        .seg(seg_audio_in),
        .num(mic_num) 
        );
    
    Clock_mHz(
        .clock(clock),
        .m(20000),
        .khzclock(clock20khz)
        );
        
    Clock_mHz(
        .clock(clock),
        .m(20),
        .khzclock(clock20hz)
        );
        
    // for menu selection

    always @ (posedge clock) begin
        if (machine_state == 2'b0) begin
            // Centre button
            if (btnC && btnC_state == 2'b0)
                btnC_state = 2'b01;
            if (btnC_state == 2'b01) begin
                if (!btnC) begin
                    release_count = release_count + 1;
                    if (release_count == 31'd6_250_000)
                        btnC_state = 2'b10;
                end
                else
                    release_count = 0;
            end
            if (btnC_state == 2'b10) begin
                btnC_state = 2'b0;
                machine_state <= menu_state;
            end
        end
        else begin
            if (btnL && btnL_state == 2'b0)
                btnL_state = 2'b01;
            if (btnL_state == 2'b01) begin
                if (!btnL) begin
                    release_count = release_count + 1;
                    if (release_count == 31'd6_250_000)
                        btnL_state = 2'b10;
                end
                else
                    release_count = 0;
            end
            if (btnL_state == 2'b10) begin
                btnL_state = 2'b0;
                machine_state <= 2'b0;
            end
        end
	end

    oled_control (.machine_state(machine_state), .oled_s0(oled_state_0), .oled_s1(oled_state_1), .oled_s2(oled_state_2), .oled_s3(oled_state_3), .oled_s4(oled_state_4), .oled_s5(oled_state_5), .oled_s6(oled_state_6), .oled_s7(oled_state_7), .oled_s8(oled_state_8), .oled_data(oled_data));
    menu (.clock(clock), .btnL(btnL), .btnR(btnR), .x(oled_x), .y(oled_y), .oled_data(oled_state_0), .machine_state(machine_state), .menu_state(menu_state));
    gif (.clock(clock), .x(oled_x), .y(oled_y), .oled_data(oled_state_7), .machine_state(machine_state));

endmodule