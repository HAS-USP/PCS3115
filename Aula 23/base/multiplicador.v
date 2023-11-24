module multiplicador
#(parameter WIDTH=4)
(
    input  clk, rst, start,
    output done,
    input  [WIDTH-1:0]   B_in, Q_in,
    output [WIDTH*2-1:0] P_out
);

wire a_en, b_en, q_en, cnt_en, a_ld, b_ld, q_ld, cnt_ld, qlsb, zero;

multiplicador_uc 
    #(WIDTH)
    uc(clk, rst, start, qlsb, zero, a_rst,
       a_en, b_en, q_en, cnt_en,
       a_ld, b_ld, q_ld, cnt_ld, done);

multiplicador_fd
    #(WIDTH)
    fd(clk, rst, a_rst,
       a_en, b_en, q_en, cnt_en,
       a_ld, b_ld, q_ld, cnt_ld,
       qlsb, zero,
       B_in, Q_in,
       P_out);

endmodule