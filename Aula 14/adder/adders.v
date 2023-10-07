`timescale 1ns/1ps
// Somadores para usar no exercício.
// NÃO envie este arquivo para o juiz, ele já tem estes módulos.
module ha (
    input a,
    input b,
    output s,
    output co
);
    assign #5 s = a ^ b;
    assign #2 co = a & b;
endmodule

module fa (
    input a,
    input b,
    input ci,
    output s,
    output co
);
    wire axorb, and1, and2;
    assign #5 axorb = a ^ b;
    assign #5 s = axorb ^ ci;
    assign #2 and1 = axorb & ci;
    assign #2 and2 = a & b;
    assign #2 co = and1 | and2;
endmodule




