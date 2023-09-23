`timescale 1ns/1ns
`include "desafio.v"

module desafio_tb;
    reg m;
    reg [31:0] int;
    reg [15:0] s;
    wire [1:0] y;

    solucao zut(m, int, s, y);
 
    initial begin
        $monitor("m = %x, s = %x, int = %x, y = %x", m, s, int, y);
        #1 m = 1; s = 16'b0000001011000000; int = 32'b10000000110011100000000011000000;
        $monitor("m = %x, s = %x, int = %x, y = %x", m, s, int, y);

        $finish;
    end
endmodule