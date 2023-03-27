`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 11:07:48
// Design Name: 
// Module Name: debouncer
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


module debouncer(input clock, input btn, output reg debounced_btn);

parameter CNT_MAX = 50000000; // Counter maximum value
reg [31:0] cnt; // Counter

always @(posedge clock) begin
  if (btn == 1) begin // Button is pressed
    if (cnt < CNT_MAX) begin // Count until maximum
      cnt <= cnt + 1;
    end
    else begin // Button is stable
      debounced_btn <= 1;
    end
  end
  else begin // Button is not pressed
    if (cnt > 0) begin // Count until zero
      cnt <= cnt - 1;
    end
    else begin // Button is stable
      debounced_btn <= 0;
    end
  end
end

endmodule

