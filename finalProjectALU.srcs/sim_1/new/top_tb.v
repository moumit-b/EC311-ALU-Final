`timescale 1ns / 1ps

module top_tb;

// Inputs
reg [3:0] A;
reg [3:0] B;
reg [2:0] opcode;
reg clk;
reg rst;

// Outputs
wire [6:0] seg1;
wire [6:0] seg2;
wire [6:0] seg3;

// Instantiate the Unit Under Test (UUT)
top uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .clk(clk),
    .rst(rst),
    .seg1(seg1),
    .seg2(seg2),
    .seg3(seg3)
);

// Clock generation
always #5 clk = ~clk; // Toggle clock every 5ns (10ns period)

initial begin
    // Initialize inputs
    clk = 0;
    rst = 1;  // Assert reset
    A = 4'b0000;
    B = 4'b0000;
    opcode = 3'b000;

    // Apply reset
    #15 rst = 0;  // Deassert reset after 15ns

    // Apply test cases
    #10;  // Wait for reset to clear

    // Test addition
    A = 4'd5; B = 4'd3; opcode = 3'b001;
    #20; // Wait for results

    // Test subtraction
    A = 4'd9; B = 4'd4; opcode = 3'b010;
    #20;

    // Test multiplication
    A = 4'd2; B = 4'd3; opcode = 3'b011;
    #20;

    // Test division
    A = 4'd8; B = 4'd2; opcode = 3'b100;
    #20;

    // Test modulo
    A = 4'd7; B = 4'd3; opcode = 3'b101;
    #20;

    // Test XOR
    A = 4'd6; B = 4'd3; opcode = 3'b110;
    #20;

    // Test AND
    A = 4'd6; B = 4'd3; opcode = 3'b111;
    #20;

    // Test OR
    A = 4'd6; B = 4'd3; opcode = 3'b000;
    #20;

    // End simulation
    #50;
    $stop;
end

endmodule
