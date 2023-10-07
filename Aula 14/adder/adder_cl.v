module adder_cl 
    #(parameter N=4)
     (input [N-1:0] a,
      input [N-1:0] b,
      input ci,
      output [N-1:0] s,
      output co);
    // Escreva sua solução a partir daqui
    wire [N:0] carry;
    wire [N-1:0] gen;
    wire [N-1:0] prop;
    assign carry[0] = 0;
    genvar i;
    generate
      for (i = 0; i < N; i = i + 1) begin
        // Instantiate a single-bit full adder for each bit position, ignoring Cout
        fa fa_inst (
          .a(a[i]),
          .b(b[i]),
          .ci(carry[i]), 
          .s(s[i]),
          .co()
        );
      end
      for (i = 0; i < N; i = i + 1) begin
        // Propagate and Generate
        assign prop[i] = a[i] | b[i];
        assign gen[i] = a[i] & b[i];
      end
      for (i = 0; i < N; i = i + 1) begin
        // Recursive carries
        assign carry[i+1] = gen[i] | (prop[i] & carry[i]);
      end
      assign co = carry[N];
    endgenerate

endmodule