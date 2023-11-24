// Shift right register
// load enable external load
// enable is global
module shiftr_reg
    #(parameter WIDTH=8)
    (
        input  clk, rst, en, load, si, 
        input  [WIDTH-1:0] d, 
        output [WIDTH-1:0] q);

reg [WIDTH-1:0] sreg;

always @(posedge clk or posedge rst)
    begin
    if (rst)
        sreg = 0;        
    else if (en)
        if (load) 
            sreg = d;
        else 
            sreg = {si, sreg[WIDTH-1:1]};
end

assign q = sreg;

endmodule