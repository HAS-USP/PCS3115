// Versão com o BugFix da Fernanda
module karatusuba8_fd 
(
    input  clk, rst,
    input  x_ld, y_ld, a_ld, b_ld, c_ld, d_ld, e_ld, sub, a_sel, c_sel,
    input  [1:0] mul_sel, 
    input  [2:0] ss_sel,
    input  [7:0] X, Y,
    output [15:0] R
);

// Multiplicador    
wire [4:0] A_mul; wire [4:0] B_mul; wire [9:0] R_mul;
multiplicador5x5 mul (A_mul, B_mul, R_mul);
// Somador-Subtrator
wire [15:0] A_ss; wire [15:0] B_ss; wire [15:0] R_ss; wire co;
somasub #(16) ss(sub, A_ss, B_ss, R_ss, co);

// Regs
wire [7:0] X_out, Y_out;
registrador #(8) Xr(clk, rst, x_ld, X, X_out);
registrador #(8) Yr(clk, rst, y_ld, Y, Y_out);
wire [15:0] A_in, A_out;
registrador #(16) A(clk, rst, a_ld, A_in, A_out);
wire [9:0] B_out;
registrador #(10)  B(clk, rst, b_ld, R_mul, B_out);
wire [9:0] C_in, C_out;
registrador #(10) C(clk, rst, c_ld, C_in, C_out);
wire [4:0] D_out;
registrador #(5)  D(clk, rst, d_ld, R_ss[4:0], D_out);
wire [8:0] E_in, E_out;
registrador #(9)  E(clk, rst, e_ld, R_ss[8:0], E_out);

// Muxes Multiplicador
assign A_mul = mul_sel==2'b00 ? {1'b0,X_out[3:0]} :
               mul_sel==2'b01 ? {1'b0,X_out[7:4]} :  
               C_out[4:0];
assign B_mul = mul_sel==2'b00 ? {1'b0,Y_out[3:0]} :
               mul_sel==2'b01 ? {1'b0,Y_out[7:4]} :  
               D_out;
// MUX Somador-Subtrator
assign A_ss = ss_sel==3'b000 ? {12'h000,X_out[7:4]} :
              ss_sel==3'b001 ? {12'h000,Y_out[7:4]} :
              ss_sel==3'b011 ? {6'h00,C_out} :
              A_out;
assign B_ss = ss_sel==3'b000 ? {12'h000,X_out[3:0]} :
              ss_sel==3'b001 ? {12'h000,Y_out[3:0]} :
              ss_sel==3'b011 ? {7'h00,E_out} :
              ss_sel==3'b100 ? B_out<<8 :
              ss_sel==3'b101 ? {2'b00,C_out,4'b0000} :
              {6'h00,B_out};

// MUXes regs
assign A_in = a_sel ? R_ss : {6'b000000,R_mul};
assign C_in = c_sel ? R_ss : {6'b000000,R_mul};

assign R = A_out;

endmodule