// Bruno Albertini
// Multiplicador em ROM
module multiplicador5x5 (
    input  [4:0] A, B,
    output [9:0] R
);
    wire [9:0] address;
    assign address = {B,A};

    reg [9:0] mem [0:1023];
    initial begin
        $readmemh("mulrom.data",mem);
    end

    assign R = mem[address];
endmodule
