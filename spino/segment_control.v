module segment_control(
    input clock,
    input sw,
    input [6:0] seg_audio_in,
    input [3:0] an_audio_in,
    input [3:0] num,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    
    wire clock500hz;
    reg [6:0] cathodecontrol = 7'b1111111;
    reg [3:0] anodecontrol = 4'b1111;
    reg dpcontrol = 1;
    
    assign seg = cathodecontrol;
    assign an = anodecontrol;
    assign dp = dpcontrol;
    
    Clock_mHz(
        .clock(clock),
        .m(500),
        .khzclock(clock500hz)
        );
    
    always @(posedge clock500hz)
    begin
    
    if(sw) begin
    case(num)
    4'b0000:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b1111001;//1
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b1111001 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end
    end
    
    4'b0001:
    begin          
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b0100100; //2
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b0100100 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end         
    end
    
    4'b0010:
    begin  
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b0110000; //3
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b0110000 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end  
    end
    
    4'b0011:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b0011001; //4
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b0011001 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end   
    end
    
    4'b0100:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b0010010; //5
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b0010010 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end   
    end
    
    4'b0101:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b0000010; //6
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b0000010 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end 
    end
    
    4'b0110:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b1111000; //7
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b1111000 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end  
    end
    
    4'b0111:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b0000000; //8
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b0000000 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end  
    end
    
    4'b1000:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1000000 && dpcontrol == 0) begin
            anodecontrol = 4'b1011;
            cathodecontrol = 7'b0010000; //9
            dpcontrol = 1;
        end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b0010000 && dpcontrol == 1) begin
            anodecontrol = an_audio_in;
            cathodecontrol = seg_audio_in;
            dpcontrol = 1;
        end
        else begin
            anodecontrol = 4'b0111;
            cathodecontrol = 7'b1000000;
            dpcontrol = 0;
        end 
    end
    
    4'b1001:
    begin
        if(anodecontrol == 4'b0111 && cathodecontrol == 7'b1111001 && dpcontrol == 0) begin
        anodecontrol = 4'b1011;
        cathodecontrol = 7'b1000000;//1
        dpcontrol = 1;
    end
        else if(anodecontrol == 4'b1011 && cathodecontrol == 7'b1000000 && dpcontrol == 1) begin
        anodecontrol = an_audio_in;
        cathodecontrol = seg_audio_in;
        dpcontrol = 1;
    end
    else begin
        anodecontrol = 4'b0111;
        cathodecontrol = 7'b1111001;
        dpcontrol = 0;
    end 
    end
    
    default:
    begin
        anodecontrol = an_audio_in;
        cathodecontrol = seg_audio_in;
        dpcontrol = 1;
    end
    
    endcase
    
    end
    
    else
    begin
        anodecontrol = an_audio_in;
        cathodecontrol = seg_audio_in;
        dpcontrol = 1;
    end
end
    
endmodule
