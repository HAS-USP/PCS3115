module adder_rc 
    #(parameter N=4)
     (input [N-1:0] a,
      input [N-1:0] b,
      input ci,
      output [N-1:0] s,
      output co);
    // Escreva sua solução a partir daqui
    wire [N-1:0] carry;
    genvar i;
    generate
      for (i = 0; i < N; i = i + 1) begin
        // Instantiate a single-bit full adder for each bit position
        fa fa_inst (
          .a(a[i]),
          .b(b[i]),
          .ci((i != 0) ? carry[i-1] : 1'b0), 
          .s(s[i]),
          .co(carry[i])
        );
      end
      assign co = carry[N-1];
    endgenerate

endmodule