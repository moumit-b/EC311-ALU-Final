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
// Description: 
// 
// Dependencies: 
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

    output [6:0] seg1,         // 7-segment display for digit 1 (hundreds)
    output [6:0] seg2,         // 7-segment display for digit 2 (tens)
    output [6:0] seg3          // 7-segment display for digit 3 (ones)
);

wire [7:0] alu_result;         // 8-bit ALU result
wire [3:0] dig1, dig2, dig3;  // BCD digits for display

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

// Decoders for each 7-segment digit
decoder dig1_decoder (
    .number(dig1),
    .cathode(seg1)
);

decoder dig2_decoder (
    .number(dig2),
    .cathode(seg2)
);

decoder dig3_decoder (
    .number(dig3),
    .cathode(seg3)
);

endmodule

