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