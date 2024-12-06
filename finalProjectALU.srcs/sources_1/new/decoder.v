`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:48:58 AM
// Design Name: 
// Module Name: decoder
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


module decoder(
    input [3:0] number,         // 4-bit number to decode
    output reg [6:0] cathode    // 7-segment cathode output
);

always @(number) begin
    case(number)
        4'd0: cathode <= 7'b0000001; // 0
        4'd1: cathode <= 7'b1001111; // 1
        4'd2: cathode <= 7'b0010010; // 2
        4'd3: cathode <= 7'b0000110; // 3
        4'd4: cathode <= 7'b1001100; // 4
        4'd5: cathode <= 7'b0100100; // 5
        4'd6: cathode <= 7'b0100000; // 6
        4'd7: cathode <= 7'b0001111; // 7
        4'd8: cathode <= 7'b0000000; // 8
        4'd9: cathode <= 7'b0000100; // 9
        10:cathode<=7'b0001000;
        11:cathode<=7'b1100000;
        12:cathode<=7'b0110001;
        13:cathode<=7'b1000010;
        14:cathode<=7'b0110000;
        15:cathode<=7'b0111000;
        default: cathode <= 7'b1111111; // Error or undefined value
    endcase
end

endmodule
