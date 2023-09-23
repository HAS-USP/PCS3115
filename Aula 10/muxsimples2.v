module muxsimples2 (a, b, s, y);
    input [1:0] a, b;
    input s;
    output [1:0] y;

    assign y = s ? b: a;
    
endmodule