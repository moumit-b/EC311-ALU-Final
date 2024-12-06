`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:55:12 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top module with ALU and 3-digit 7-segment display logic
// 
// Dependencies: ALU, bcd, decoder, clk_divider
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input [3:0] A,             // 4-bit input A
    input [3:0] B,             // 4-bit input B
    input [2:0] opcode,        // 3-bit opcode (to match the 8 operations)
    input clk,                 // Clock signal
    input rst,                 // Reset signal

    output [6:0] cathode,      // 7-segment cathode signals
    output reg [7:0] anode     // Anode control for 7-segment displays
);

wire [7:0] alu_result;         // 8-bit ALU result
wire [3:0] dig1, dig2, dig3;  // BCD digits for display
reg [3:0] decodeVal;          // Current value to decode
wire slowClk;                 // Slow clock for display multiplexing
reg [1:0] state;              // State for multiplexing

// Initialization
initial begin
    anode = 8'b11111110;      // Enable the first display (least significant digit)
    state = 2'b00;            // Start with the first display
end

// State-based multiplexing for anodes and decoding values
always @(posedge slowClk) begin
    case (state)
        2'b00: begin
            anode <= 8'b11111110;  // Enable ones digit
            decodeVal <= dig1;
            state <= 2'b01;
        end
        2'b01: begin
            anode <= 8'b11111101;  // Enable tens digit
            decodeVal <= dig2;
            state <= 2'b10;
        end
        2'b10: begin
            anode <= 8'b11111011;  // Enable hundreds digit
            decodeVal <= dig3;
            state <= 2'b00;
        end
        default: state <= 2'b00;
    endcase
end

// ALU instance
ALU alu (
    .A(A),
    .B(B),
    .opcode(opcode),
    .clk(clk),
    .rst(rst),
    .result(alu_result)
);

// BCD instance to convert ALU result to 3-digit BCD
bcd bcd_converter (
    .number(alu_result),
    .dig1(dig1),
    .dig2(dig2),
    .dig3(dig3)
);

// Decoder instance for the 7-segment display
decoder seg_decoder (
    .number(decodeVal),
    .cathode(cathode)
);

// Clock divider to generate a slower clock for multiplexing
clk_divider slowClock (
    .clk_in(clk),
    .divided_clk(slowClk)
);

endmodule
