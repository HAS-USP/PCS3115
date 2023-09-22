/*
 * Generated by Digital. Don't modify this file!
 * Any changes will be lost if this file is regenerated.
 */
module PriorityEncoder2 (
    input in0,
    input in1,
    input in2,
    input in3,
    output reg [1:0] num,
    output any
);
    always @ (*) begin
        if (in3 == 1'b1)
            num = 2'h3;
        else if (in2 == 1'b1)
            num = 2'h2;
        else if (in1 == 1'b1)
            num = 2'h1;
        else 
            num = 2'h0;
    end

    assign any = in0 | in1 | in2 | in3;
endmodule


module Mux_4x1
(
    input [1:0] sel,
    input in_0,
    input in_1,
    input in_2,
    input in_3,
    output reg out
);
    always @ (*) begin
        case (sel)
            2'h0: out = in_0;
            2'h1: out = in_1;
            2'h2: out = in_2;
            2'h3: out = in_3;
            default:
                out = 'h0;
        endcase
    end
endmodule


module Mux_2x1
(
    input [0:0] sel,
    input in_0,
    input in_1,
    output reg out
);
    always @ (*) begin
        case (sel)
            1'h0: out = in_0;
            1'h1: out = in_1;
            default:
                out = 'h0;
        endcase
    end
endmodule


module solucao_dig (
  input M,
  input INTA,
  input INTB,
  input INTC,
  input INTD,
  input SA,
  input SB,
  input SC,
  input SD,
  output Y
);
  wire [1:0] s0;
  wire s1;
  PriorityEncoder2 PriorityEncoder2_i0 (
    .in0( SA ),
    .in1( SB ),
    .in2( SC ),
    .in3( SD ),
    .num( s0 )
  );
  Mux_4x1 Mux_4x1_i1 (
    .sel( s0 ),
    .in_0( INTA ),
    .in_1( INTB ),
    .in_2( INTC ),
    .in_3( INTD ),
    .out( s1 )
  );
  Mux_2x1 Mux_2x1_i2 (
    .sel( M ),
    .in_0( INTA ),
    .in_1( s1 ),
    .out( Y )
  );
endmodule
