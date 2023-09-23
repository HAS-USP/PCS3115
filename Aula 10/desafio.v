module muxsimples2 (a, b, s, y);
    input [1:0] a, b;
    input s;
    output [1:0] y;

    assign y = s ? b: a;
    
endmodule

module codpri16_4 (i, y);
    input  [15:0] i;
    output [3:0] y;

    assign y = (i[15] == 1'b1)? 4'b1111:
    (i[15:14] == 2'b01)? 4'b1110:
    (i[15:13] == 3'b001)? 4'b1101:
    (i[15:12] == 4'b0001)? 4'b1100:
    (i[15:11] == 5'b00001)? 4'b1011:
    (i[15:10] == 6'b000001)? 4'b1010:
    (i[15:9] == 7'b0000001)? 4'b1001:
    (i[15:8] == 8'b00000001)? 4'b1000:
    (i[15:7] == 9'b000000001)? 4'b0111:
    (i[15:6] == 10'b0000000001)? 4'b0110:
    (i[15:5] == 11'b00000000001)? 4'b0101:
    (i[15:4] == 12'b000000000001)? 4'b0100:
    (i[15:3] == 13'b0000000000001)? 4'b0011:
    (i[15:2] == 14'b00000000000001)? 4'b0010:
    (i[15:1] == 15'b000000000000001)? 4'b0001:
    4'b0000;

endmodule

module mux16 (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, cp, y);
    input [1:0] a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p;
    input [3:0] cp;
    output [1:0] y;

    assign y = (cp == 4'b0000) ?
    a: cp == 4'b0001 ?
    b: cp == 4'b0010 ?
    c: cp == 4'b0011 ?
    d: cp == 4'b0100 ?
    e: cp == 4'b0101 ?
    f: cp == 4'b0110 ?
    g: cp == 4'b0111 ?
    h: cp == 4'b1000 ?
    i: cp == 4'b1001 ?
    j: cp == 4'b1010 ?
    k: cp == 4'b1011 ?
    l: cp == 4'b1100 ?
    m: cp == 4'b1101 ?
    n: cp == 4'b1110 ?
    o:p;
    
endmodule


module solucao (
    input m, 
    input [31:0] int,
    input [15:0] s, 
    output reg [1:0] y);
    // m é a chave geral (sempre da prioridade para o inta, que nesse desafio
    //     corresponde ao int[1:0]).
    // int são os comandos dos interruptores, o vetor está "packed", ou seja, 
    //     int[1:0]=inta, int[3:2]=intb e assim por diante. No total, são 16 
    //     interruptores de 2 bits.
    // s são os sensores, s[0] corresponde ao sensor sa.
    // y é a saída, note que o int é de 2 bits, então a saída também é.

    // Escreva sua solução a partir aqui
    wire [1:0] y1;
    wire [3:0] cp;
    wire [1:0] mux0;
    input [1:0] a, b, c, d, e, f, g, h, i, j, k, l, mi, n, o, p;
    assign a=int[1:0], b=int[3:2], c=int[5:4], d=int[7:6], e=int[9:8], f=int[11:10], g=int[13:12], h=int[15:14], i=int[17:16], j=int[19:18], k=int[21:20], l=int[23:22], mi=int[25:24], n=int[27:26], o=int[29:28], p=int[31:30];

    codpri16_4 uut(s, cp);
    mux16 dut(a, b, c, d, e, f, g, h, i, j, k, l, mi, n, o, p, cp, mux0);
    muxsimples2 aut(a, mux0, m, y1);
    always @* begin
        y = y1;
    end

endmodule
