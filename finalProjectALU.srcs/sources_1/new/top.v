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
// Description: Top module with ALU and 7-segment display logic
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
    input [2:0] opcode,        // 3-bit opcode
    input clk,                 // Clock signal
    input rst,                 // Reset signal

    output [6:0] cathode,      // 7-segment cathode signals
    output reg [7:0] anode,     // Anode control for 7-segment displays
    
    output wire colon
);

wire [7:0] alu_result;         // 8-bit ALU result
wire [3:0] A_dig1, A_dig2;     // BCD digits for operand A
wire [3:0] B_dig1, B_dig2;     // BCD digits for operand B
wire [3:0] res_dig1, res_dig2, res_dig3; // BCD digits for result
reg [3:0] decodeVal;           // Current value to decode
wire slowClk;                  // Slow clock for display multiplexing
reg [2:0] state;               // State for multiplexing

assign colon = 1'b1;

// Initialization
initial begin
    anode = 8'b11111110;       // Enable the first display (rightmost digit)
    state = 3'b000;            // Start with the first display
end

// State-based multiplexing for anodes and decoding values
always @(posedge slowClk or posedge rst) begin
    if (rst) begin
        state <= 3'b000;
    end else begin
        case (state)
            3'b000: begin
                anode <= 8'b11111110;  // Enable rightmost digit (Result ones)
                decodeVal <= res_dig1;
                state <= 3'b001;
            end
            3'b001: begin
                anode <= 8'b11111101;  // Enable second digit from right (Result tens)
                decodeVal <= res_dig2;
                state <= 3'b010;
            end
            3'b010: begin
                anode <= 8'b11111011;  // Enable third digit from right (Result hundreds)
                decodeVal <= res_dig3;
                state <= 3'b011;
            end
            3'b011: begin
                anode <= 8'b11110111;  // Enable fourth digit from right (blank)
                decodeVal <= 4'b1111;  // Assuming 4'b1111 maps to blank in decoder
                state <= 3'b100;
            end
            3'b100: begin
                anode <= 8'b11101111;  // Enable fifth digit from right (B ones)
                decodeVal <= B_dig1;
                state <= 3'b101;
            end
            3'b101: begin
                anode <= 8'b11011111;  // Enable sixth digit from right (B tens)
                decodeVal <= B_dig2;
                state <= 3'b110;
            end
            3'b110: begin
                anode <= 8'b10111111;  // Enable seventh digit from right (A ones)
                decodeVal <= A_dig1;
                state <= 3'b111;
            end
            3'b111: begin
                anode <= 8'b01111111;  // Enable leftmost digit (A tens)
                decodeVal <= A_dig2;
                state <= 3'b000;
            end
            default: state <= 3'b000;
        endcase
    end
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

// BCD conversion for operand A
bcd operandA_bcd (
    .number({4'b0000, A}), // Extend A to 8 bits
    .dig1(A_dig1),
    .dig2(A_dig2),
    .dig3()               // Unused
    //.dig4()                // Unused
);

// BCD conversion for operand B
bcd operandB_bcd (
    .number({4'b0000, B}), // Extend B to 8 bits
    .dig1(B_dig1),
    .dig2(B_dig2),
    .dig3()               // Unused
    //.dig4()                // Unused
);

// BCD conversion for ALU result
bcd result_bcd (
    .number(alu_result),
    .dig1(res_dig1),
    .dig2(res_dig2),
    .dig3(res_dig3)
    //.dig4()                // Unused
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
