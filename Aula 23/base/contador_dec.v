module counter_dec
    #(parameter WIDTH=3)
    (
        input  clk, rst, en, ld,
        input  [WIDTH-1:0] d,
        output [WIDTH-1:0] q,
        output z
    );

    reg [WIDTH-1:0] cnt;

    always @ (posedge clk)
    begin
        if (rst)
            cnt=0;
        else if (en)
            if (ld)
                cnt = d;
            else 
                cnt = cnt-1;
    end 

    assign q = cnt;
    assign z = cnt==0 ? 1'b1 : 1'b0;

endmodule