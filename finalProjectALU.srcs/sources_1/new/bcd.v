`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:48:02 AM
// Design Name: 
// Module Name: bcd
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


module bcd(
    input [7:0] number,         // 8-bit number to convert to BCD
    output reg [3:0] dig1,      // 1st 4-bit digit (ones)
    output reg [3:0] dig2,      // 2nd 4-bit digit (tens)
    output reg [3:0] dig3       // 3rd 4-bit digit (hundreds)
);

always @(number) begin
    dig1 <= number % 10;         // Get ones digit
    dig2 <= (number / 10) % 10;  // Get tens digit
    dig3 <= (number / 100) % 10; // Get hundreds digit
end

endmodule

