`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:40:37 AM
// Design Name: 
// Module Name: alu
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


module ALU (
    input [3:0] A,          // 4-bit input A
    input [3:0] B,          // 4-bit input B
    input [3:0] opcode,     // 4-bit opcode
    input clk,              // Clock signal
    input rst,              // Reset signal

    output reg [7:0] result, // 8-bit result (for 3-digit 7-segment output)
    output reg overflow     // Overflow flag
);

reg [7:0] msbProd;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        result <= 0;
        overflow <= 0;
    end else begin
        case (opcode)
            3'b001: result <= {4'b0000, A} + {4'b0000, B};       // Addition
            3'b010: result <= {4'b0000, A} - {4'b0000, B};       // Subtraction
            3'b011: begin                                           // Multiplication
                {msbProd, result} = {4'b0000, A} * {4'b0000, B};
                overflow = msbProd[0] | msbProd[1] | msbProd[2] | msbProd[3];
            end
            3'b100: result <= {4'b0000, A} / {4'b0000, B};       // Division
            3'b101: result <= {4'b0000, A} % {4'b0000, B};       // Modulo
            3'b110: result <= A ^ B;                              // XOR (bitwise)
            3'b111: result <= A & B;                              // AND (bitwise)
            3'b000: result <= A | B;                              // OR (bitwise)
            default: result <= 0;                                 // Undefined operation
        endcase
    end
end

endmodule

