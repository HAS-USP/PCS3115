// Bruno Albertini
// Somador subtrator funcional genérico
module somasub #(
    parameter WIDTH = 4
) (
    input sub,
    input  [WIDTH-1:0] A, B,
    output [WIDTH-1:0] R,
    output co
);
    assign {co,R} = sub ? A-B : A+B;
endmodule