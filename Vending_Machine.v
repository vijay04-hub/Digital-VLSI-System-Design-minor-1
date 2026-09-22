`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 12:33:40 PM
// Design Name: 
// Module Name: Vending_Machine
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


module vending_machine (
    input  wire clk,rst_n,coin5, coin10,  
    output reg  dispense  
    );  
    localparam S0  = 2'b00,S5= 2'b01,S10=2'b10;
    reg [1:0] state, next_state;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end
    always @(*) begin
        next_state = state;

        case (state)
            S0: begin
                if (coin10)       next_state = S10;
                else if (coin5)   next_state = S5;
            end

            S5: begin
                if (coin10)       next_state = S0; // 5 + 10 = 15
                else if (coin5)   next_state = S10; // 5 + 5 = 10
            end

            S10: begin
                if (coin5 || coin10) next_state = S0; // 10 + 5 = 15 (or 10 + 10 = 20)
            end

            default: next_state = S0;
        endcase
    end


    always @(*) begin
        dispense = 1'b0;

        case (state)
            S0:  dispense = 1'b0;
            S5:  if (coin10)          dispense = 1'b1;
            S10: if (coin5 || coin10) dispense = 1'b1;
            default: dispense = 1'b0;
        endcase
    end

endmodule
