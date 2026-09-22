`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 12:21:54 PM
// Design Name: 
// Module Name: Slidingdoor_FSM
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

module sliding_door_fsm(
input clk, rst_n,sensor,door_full_open,door_full_closed,
output reg door_open,door_close
);
parameter IDLE = 2'b00;
parameter OPENING = 2'b01;
parameter OPEN = 2'b10;
parameter CLOSING = 2'b11;
reg [1:0] state;
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
state <= IDLE;
end else begin
case (state)
IDLE: begin
door_open <= 1'b0;
door_close <= 1'b0;
if (sensor) state <= OPENING;
end
OPENING: begin
door_open <= 1'b1;
door_close <= 1'b0;
if (door_full_open) state <= OPEN;
end
OPEN: begin
door_open <= 1'b0;
door_close <= 1'b0;
if (!sensor) state <= CLOSING; // Here was the error
end
CLOSING: begin
door_open <= 1'b0;
door_close <= 1'b1;
if (door_full_closed) state <= IDLE;
end
default: begin
state <= IDLE;
door_open <= 1'b0;
door_close <= 1'b0;
end
endcase
end
end
endmodule
