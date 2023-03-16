# Sim's OLED Individual Task

To use, call the module with the following parameters:
module oled_indiv_task(input clock, input [15:0] sw, output [7:0] JC);

Inside, Oled_Display is called, as well as pixel_index_to_xy and display_task. First is to initialise the Oled display, second converts pixel data from the oled display to x and y coordinates, and third is for the display task.

A clock divider has been created as well, but can be removed for standardisation when integrating.