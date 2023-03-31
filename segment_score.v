`timescale 1ns / 1ps

module segment_score(
    input clock,
    input score,
    output an,
    output seg,
    output dp
    );
    
    reg [6:0] cathodecontrol = 7'b1111111;
    reg [3:0] anodecontrol = 4'b1111;
    reg dpcontrol = 1;
    
    assign seg = cathodecontrol;
    assign an = anodecontrol;
    assign dp = dpcontrol;
    
    always @ (posedge clock) begin
    
    case (score)
    0: begin
    if(cathodecontrol == 7'b1000000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b1011;
    end
    end
    1: begin
    if(cathodecontrol == 7'b1111001 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b1011;
    end
    end
    2: begin
    if(cathodecontrol == 7'b0100100 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b1011;
    end
    end
    3: begin
    if(cathodecontrol == 7'b0110000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0110000; //3
    anodecontrol = 4'b1011;
    end
    end
    4: begin
    if(cathodecontrol == 7'b0011001 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0011001; //4
    anodecontrol = 4'b1011;
    end
    end
    5: begin
    if(cathodecontrol == 7'b0010010 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0010010; //5
    anodecontrol = 4'b1011;
    end
    end
    6: begin
    if(cathodecontrol == 7'b0000010 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0000010; //6
    anodecontrol = 4'b1011;
    end
    end
    7: begin
    if(cathodecontrol == 7'b1111000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1111000; //7
    anodecontrol = 4'b1011;
    end
    end
    8: begin
    if(cathodecontrol == 7'b0000000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0000000; //8
    anodecontrol = 4'b1011;
    end
    end
    9: begin
    if(cathodecontrol == 7'b0010000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0010000; //9
    anodecontrol = 4'b1011;
    end
    end
    10: begin
    if(cathodecontrol== 7'b1000000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b1011;
    end
    end
    11: begin
    if(cathodecontrol == 7'b1111001 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b1011;
    end
    end
    12: begin
    if(cathodecontrol == 7'b0100100 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b1011;
    end
    end
    13: begin
    if(cathodecontrol == 7'b0110000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0110000; //3
    anodecontrol = 4'b1011;
    end
    end
    14: begin
    if(cathodecontrol == 7'b0011001 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0011001; //4
    anodecontrol = 4'b1011;
    end
    end
    15: begin
    if(cathodecontrol == 7'b0010010 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0010010; //5
    anodecontrol = 4'b1011;
    end
    end
    16: begin
    if(cathodecontrol == 7'b0000010 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0000010; //6
    anodecontrol = 4'b01011;
    end
    end
    17: begin
    if(cathodecontrol == 7'b1111000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1111000; //7
    anodecontrol = 4'b1011;
    end
    end
    18: begin
    if(cathodecontrol == 7'b0000000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0000000; //8
    anodecontrol = 4'b1011;
    end
    end
    19: begin
    if(cathodecontrol == 7'b0010000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0010000; //9
    anodecontrol = 4'b1011;
    end
    end
    20: begin
    if(cathodecontrol == 7'b1000000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b1011;
    end
    end
    21: begin
    if(cathodecontrol == 7'b1111001 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1111001; //1
    anodecontrol = 4'b1011;
    end
    end
    22: begin
    if(cathodecontrol == 7'b0100100 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b1011;
    end
    end
    23: begin
    if(cathodecontrol == 7'b0110000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0110000; //3
    anodecontrol = 4'b1011;
    end
    end
    24: begin
    if(cathodecontrol == 7'b0011001 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0011001; //4
    anodecontrol = 4'b1011;
    end
    end
    25: begin
    if(cathodecontrol == 7'b0010010 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0010010; //5
    anodecontrol = 4'b1011;
    end
    end
    26: begin
    if(cathodecontrol == 7'b0000010 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0000010; //6
    anodecontrol = 4'b1011;
    end
    end
    27: begin
    if(cathodecontrol == 7'b1111000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1111000; //7
    anodecontrol = 4'b1011;
    end
    end
    28: begin
    if(cathodecontrol == 7'b0000000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0000000; //8
    anodecontrol = 4'b1011;
    end
    end
    29: begin
    if(cathodecontrol == 7'b0010000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0100100; //2
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b0010000; //9
    anodecontrol = 4'b1011;
    end
    end
    30: begin
    if(cathodecontrol == 7'b1000000 && anodecontrol == 4'b1011) begin
    cathodecontrol = 7'b0110000; //3
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b1011;
    end
    end
    default: begin
    if(cathodecontrol == 7'b1000000 && anodecontrol == 4'b0111) begin
    cathodecontrol = 7'b0110000; //3
    anodecontrol = 4'b0111;
    end
    else begin
    cathodecontrol = 7'b1000000; //0
    anodecontrol = 4'b1011;
    end
    end
    endcase
    
    end

endmodule
