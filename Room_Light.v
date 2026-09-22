`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 12:49:08 PM
// Design Name: 
// Module Name: Room_Light
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


module room_light (
    input  wire occupancy,
    input  wire is_dark,
    input  wire manual_on,
    output wire light_on,
    output reg  light_latch
);

    wire auto_condition = occupancy && is_dark;

    always @(*) begin
        if (manual_on) begin
            light_latch = 1'b1; // Set latch when manual override is ON
        end else if (!auto_condition) begin
         
            light_latch = 1'b0;
        end
    end

    assign light_on = auto_condition || manual_on || light_latch;

endmodule
