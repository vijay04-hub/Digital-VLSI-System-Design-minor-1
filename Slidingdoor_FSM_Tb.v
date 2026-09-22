`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 12:23:55 PM
// Design Name: 
// Module Name: Slidingdoor_FSM_Tb
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


module test();
reg clk=0, rst_n=0, sensor=0, door_full_open=0, door_full_closed=0;
wire door_open, door_close;
sliding_door_fsm uut (clk, rst_n, sensor, door_full_open, door_full_closed, door_open, door_close);

always #5 clk = ~clk;
initial begin
#15 rst_n = 1;
#10 sensor = 1; // Person detected -> OPENING
#20 door_full_open = 1; // Fully open -> OPEN
#30 sensor = 0; door_full_open = 0; // Person leaves -> CLOSING
#20 door_full_closed = 1; // Fully closed -> IDLE
#20 $finish;
end
endmodule
