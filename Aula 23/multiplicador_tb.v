`timescale 1ns/1ps

module BinaryMultiplier_TB;

  // Inputs
  reg [3:0] operand_a;
  reg [3:0] operand_b;
  reg clk, rst;

  // Outputs
  wire [7:0] result;

  // Instantiate the binary multiplier module
  BinaryMultiplier uut (
    .operand_a(operand_a),
    .operand_b(operand_b),
    .result(result)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Test cases
  initial begin
    // Test Case 1
    operand_a = 4'b1010;
    operand_b = 4'b0011;

    // Apply inputs and observe outputs for a few clock cycles
    #20 operand_a = 4'b1100;
    #20 operand_b = 4'b0101;
    #20 operand_a = 4'b1111;

    // Add more test cases as needed

    // Assertion to check the result after a certain time
    #50 if (result !== 8'b11001010) $fatal("Test Case 1 Failed");


    // Add more assertions for other test cases
    // ...

    // Stop simulation
    #60 $finish;
  end

endmodule
