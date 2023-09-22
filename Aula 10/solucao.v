module solucao (m, inta, intb, intc, intd, sa, sb, sc, sd, y);
    // Preencha com sua solução aqui

    input inta, intb, intc, intd, sa, sb, sc, sd, m;
    wire [1:0] cp;
    wire muxs0;
    wire muxs1;
    wire muxsmestra;
    wire [3:0] i;
    output wire y;

    assign i[0] = sa;
    assign i[1] = sb;
    assign i[2] = sc;
    assign i[3] = sd;
    
    wire en = 1'b1;

    codprisimples uut(i, en, cp);
    muxsimples dut(inta, intb, cp[0], muxs0);
    muxsimples aut(intc, intd, cp[0], muxs1);
    muxsimples but(muxs0, muxs1, cp[1], muxsmestra);
    muxsimples cut(inta, muxsmestra, m, y);

endmodule
// Não inclua os módulos na sua solução!
// O juiz contém os módulos codprisimples e muxsimples fornecidos com este arquivo