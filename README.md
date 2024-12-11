### **Read Me**

# **Project Name: ALU Calculator**
GROUP 16
## **Team Members:**

* Moumit Bhattacharjee  
* Arnav Shah  
* Bryan Ginenthal

**Project Overview**

- FPGA-based Arithmetic Logic Unit calculator project. This project performs essential arithmetic and logical operations without relying on a complex processor. It then displays the results instantly on a seven-segment display for easy readability. It’s a simple yet powerful design that demonstrates the capabilities of FPGA-based systems."

## **Project Demo Video:**

https://youtu.be/FNwH1zIkTnE

## **How To Run Project:**

1. Clone the repo into Vivado

git clone https://github.com/moumit-b/EC311-ALU-Final

2. Synthesize the project then generate the bitstream  
3. Make sure the FPGA is plugged in and turned on  
4. Open the hardware manager and program the device using the bitstream  
5. Here are the available operations and their commands:

**Available Operations and Their Commands:**

**Performing Operations on the FPGA Board**

1. **Set Inputs:**

   * **A (4-bit):** Use switches SW\[0\]–SW\[3\].  
   * **B (4-bit):** Use switches SW\[4\]–SW\[7\].  
2. **Set Operation (3-bit Opcode):**

   * **Addition:** Set SW\[13\] \= OFF, SW\[14\] \= OFF, SW\[15\] \= ON (`3'b001`).  
   * **Subtraction:** Set SW\[13\] \= OFF, SW\[14\] \= ON, SW\[15\] \= OFF (`3'b010`).  
   * **Multiplication:** Set SW\[13\] \= OFF, SW\[14\] \= ON, SW\[15\] \= ON (`3'b011`).  
   * **Division:** Set SW\[13\] \= ON, SW\[14\] \= OFF, SW\[15\] \= OFF (`3'b100`).  
   * **Modulo:** Set SW\[13\] \= ON, SW\[14\] \= OFF, SW\[15\] \= ON (`3'b101`).  
   * **XOR:** Set SW\[13\] \= ON, SW\[14\] \= ON, SW\[15\] \= OFF (`3'b110`).  
   * **AND:** Set SW\[13\] \= ON, SW\[14\] \= ON, SW\[15\] \= ON (`3'b111`).  
   * **OR:** Set SW\[13\] \= OFF, SW\[14\] \= OFF, SW\[15\] \= OFF (`3'b000`).  
3. **Reset:**  
   * Use BTN\[0\] to clear the result and reset.  
4. **View Results:**  
   * Check the 7-segment displays for the output.  
6. Calculate\!

*\*\*This project is only compatible with the Artix-7 xc7a100tcsg324-1 FPGA*

## **Code Structure:**

**Sources**

* **alu.v**: The ALU module handles arithmetic and logical computations based on the opcode.  
* **bcd.v**: This module converts binary numbers to Binary-Coded Decimal for display purposes.  
* **clk\_divider.v**: Generates a slower clock signal to cycle through display segments.  
* **decoder.v**: Converts BCD digits into cathode signals for the seven-segment displays.

**\- Top Module**

* **top.v**: This module manages the flow of data from the switches to the displays. It integrates the ALU for computations, the BCD converter for decimal formatting, and the clock divider/decoder for display and segment control.


