module muxsimples (a, b, s, y);
    input a, b, s;
    output y;

    assign y = s ? b: a;
    
endmodule