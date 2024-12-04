`timescale 1ns / 1ps

module alu_tb;

    // Inputs to the DUT (Device Under Test)
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] opcode;
    reg clk;
    reg rst;

    // Outputs from the DUT
    wire [6:0] seg1;
    wire [6:0] seg2;
    wire [6:0] seg3;

    // Instantiate the top module (DUT)
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

    // Clock generation (period = 10ns, 100 MHz)
    always begin
        #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Initialize the inputs
        clk = 0;
        rst = 0;
        A = 4'b0000;
        B = 4'b0000;
        opcode = 3'b000;

        // Apply reset
        rst = 1;
        #10;
        rst = 0;

        // Test Case 1: Addition (A = 5, B = 3)
        A = 4'b0101;  // A = 5
        B = 4'b0011;  // B = 3
        opcode = 3'b001; // Addition opcode
        #10;

        // Test Case 2: Subtraction (A = 7, B = 4)
        A = 4'b0111;  // A = 7
        B = 4'b0100;  // B = 4
        opcode = 3'b010; // Subtraction opcode
        #10;

        // Test Case 3: Multiplication (A = 3, B = 2)
        A = 4'b0011;  // A = 3
        B = 4'b0010;  // B = 2
        opcode = 3'b011; // Multiplication opcode
        #10;

        // Test Case 4: Division (A = 8, B = 2)
        A = 4'b1000;  // A = 8
        B = 4'b0010;  // B = 2
        opcode = 3'b100; // Division opcode
        #10;

        // Test Case 5: Modulo (A = 9, B = 4)
        A = 4'b1001;  // A = 9
        B = 4'b0100;  // B = 4
        opcode = 3'b101; // Modulo opcode
        #10;

        // Test Case 6: XOR (A = 5, B = 3)
        A = 4'b0101;  // A = 5
        B = 4'b0011;  // B = 3
        opcode = 3'b110; // XOR opcode
        #10;

        // Test Case 7: AND (A = 5, B = 3)
        A = 4'b0101;  // A = 5
        B = 4'b0011;  // B = 3
        opcode = 3'b111; // AND opcode
        #10;

        // Test Case 8: OR (A = 5, B = 3)
        A = 4'b0101;  // A = 5
        B = 4'b0011;  // B = 3
        opcode = 3'b000; // OR opcode
        #10;

        // End the simulation after running the test cases
        $finish;
    end

    // Monitor the results
    initial begin
        $monitor("At time %t, A = %d, B = %d, Opcode = %b, Seg1 = %b, Seg2 = %b, Seg3 = %b", 
                 $time, A, B, opcode, seg1, seg2, seg3);
    end

endmodule
