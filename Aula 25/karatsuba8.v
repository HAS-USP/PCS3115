// Bruno Albertini
// Toplevel
module karatsuba8 (
    input  clk, rst, start,
    output done,
    input  [7:0] X, Y,
    output [15:0] R
);

    wire x_ld, y_ld, a_ld, b_ld, c_ld, d_ld, e_ld, sub, a_sel, c_sel;
    wire [1:0] mul_sel; wire [2:0] ss_sel;
    karatusuba8_fd fd (clk, rst,
        x_ld, y_ld, a_ld, b_ld, c_ld, d_ld, e_ld, 
        sub, a_sel, c_sel, mul_sel, ss_sel,
        X, Y, R);
    karatusuba8_uc uc(clk, rst, start,
        x_ld, y_ld, a_ld, b_ld, c_ld, d_ld, e_ld, 
        sub, a_sel, c_sel, done, mul_sel, ss_sel);

endmodule