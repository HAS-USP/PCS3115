`timescale 1ns/1ns
`include "solucao.v"

module solucao_tb;
    reg inta, intb, intc, intd, sa, sb, sc, sd, m;
    wire y;

    solucao zut(m, inta, intb, intc, intd, sa, sb, sc, sd, y);
 
    initial begin
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; intd = 0; sd=1;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; intd = 1; sd=1;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; intc = 0;  sc=1; sd=0;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; intc = 1;  sc=1; sd=0;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; intb = 0; sb=1; sc=0; sd=0;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; intb = 1; sb=1; sc=0; sd=0;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; inta = 0; sa=1; sb=0; sc=0; sd=0;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 1; inta = 1; sa=1; sb=0; sc=0; sd=0;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 0; inta = 0; sa=0; sb=0; sc=0; sd=1;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);
        #1 m = 0; inta = 1; sa=0; sb=0; sc=0; sd=1;
        $monitor("m = %x, inta = %x, intb = %x, intc = %x, intd = %x, sa=%x, sb=%x, sc=%x, sd=%x, y = %x", m, inta, intb, intc, intd, sa, sb, sc, sd, y);

        $finish;
    end
endmodule