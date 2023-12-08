// Bruno Albertini
// GCD comportamental
// Esta é uma solução completa e funcional, porém não é sintetizável
// Investigue os casos que podem dar problema.
module gcd_comportamental
    #( parameter W = 16 ) // parameterize for better reuse
    (
        input  clk, rst, start,
        output reg done,
        input  [W-1:0] inA, inB,
        output reg [W-1:0] outR
    );
    
    reg [W-1:0] A, B, out, swap;
    
    always @(posedge clk, start) begin
        if (!start) begin
            done = 1'b0;
            A = inA; B = inB;
        end else 
            while ( !done ) begin
                if ( A < B ) begin
                    swap = A;
                    A = B;
                    B = swap;
                end else if ( B != 0 )
                    A = A - B;
                else
                    done = 1'b1;
                end
            outR = A;
        end
endmodule