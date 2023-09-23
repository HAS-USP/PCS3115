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