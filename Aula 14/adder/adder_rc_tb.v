`timescale 1ns/1ps

module adder_rc_tb;

    parameter N = 5;
    reg [N-1:0] a;
    reg [N-1:0] b;
    reg ci;
    wire [N-1:0] s;
    wire co;

    adder_rc #(N) dut_rca(
        .a(a),
        .b(b),
        .ci(ci),
        .s(s),
        .co(co)
    );

  initial begin
    $dumpfile ("adder_rc_tb.vcd");
    $dumpvars(0, adder_rc_tb);
    // Initialize inputs
    a = 4'b0000;
    b = 4'b0000;
    ci = 0;
    //integer i;

    // Apply inputs and observe outputs
    $display("s must start at 00000 and increment by 1 after each line");
    $display("Time a b ci | s co");
    $display("--------------------");
    for (integer i = 0; i < 32; i = i + 1) begin
      #100; // Wait for one clock cycle
      $display("%t %b %b  %b | %b  %b", $time, a, b, ci, s, co);
      // Increment inputs for the next iteration
      a = a + 2;
      b = b - 1;
      ci = ~ci;
    end

    $finish; // End simulation
  end
    
endmodule