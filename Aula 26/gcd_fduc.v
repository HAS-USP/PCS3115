module MUX3 
    #(parameter W=8) 
    (
        input  [W-1:0] in0, in1, in2,
        input  [1:0] sel,
        output [W-1:0] out
    );
    assign out = 
        sel == 0 ? in0 :
        sel == 1 ? in1 :
                 in2;
endmodule

module MUX2
    #(parameter W=8) 
    (
        input  [W-1:0] in0, in1,
        input  sel,
        output [W-1:0] out
    );
    assign out = sel ? in1 : in0;
endmodule

module EQ_comp
    #(parameter W=8) 
    (
        input  [W-1:0] in0, in1,
        output out
    );
    assign out = in0==in1;
endmodule

module LT_comp
    #(parameter W=8) 
    (
        input  [W-1:0] in0, in1,
        output out
    );
    assign out = in0<in1;
endmodule

module subtrator
    #(parameter W=8) 
    (
        input  [W-1:0] in0, in1,
        output [W-1:0] out
    );
    assign out = in0-in1;
endmodule

module registrador
    #(parameter W=8) 
    (
        input  clk, en_p,
        input  [W-1:0] d_p,
        output reg [W-1:0] q_np
    );
    always @(posedge clk) begin
        if (en_p)
            q_np = d_p;
    end
endmodule

module gdc_fd
    #( parameter W = 16 )
    (
        input  clk, rst, sel_B, en_A, en_B,
        input [1:0] sel_A,
        output Beq0, AltB,
        input  [W-1:0] inA, inB,
        output [W-1:0] outR
    );
    wire [W-1:0] d_A, q_A, d_B, q_B, q_sub;
    assign outR = q_A;

    registrador #(W) A
    (
        .clk(clk),
        .en_p(en_A),
        .d_p(d_A),
        .q_np(q_A)
    );

    registrador #(W) B
    (
        .clk(clk),
        .en_p(en_B),
        .d_p(d_B),
        .q_np(q_B)
    );

    subtrator  #(W) eqSubtrator
    (
        .in0(q_A),
        .in1(q_B),
        .out(q_sub)
    );

    EQ_comp #(W) eqComp
    (
        .in0({W{1'b0}}),
        .in1(q_B),
        .out(Beq0)
    );

    LT_comp #(W) ltComp
    (
        .in0(q_A),
        .in1(q_B),
        .out(AltB)
    );

    MUX2 #(W) mux2
    (
        .in0(inB),
        .in1(q_A),
        .sel(sel_B),
        .out(d_B)
    );

    MUX3 #(W) mux3
    (
        .in0(inA),
        .in1(q_B),
        .in2(q_sub),
        .sel(sel_A),
        .out(d_A)
    );
endmodule


module gdc_uc
    #(parameter W = 16)
    (
        input clk, rst, start, Beq0, AltB,
        output sel_B, en_B, en_A,
        output reg done,
        output [1:0] sel_A
    );
    reg [4:0] signal;
    assign {sel_B, sel_A, en_A, en_B} = signal;
    reg[2:0] state;
    
    localparam WAIT = 3'b000;
    localparam ALTB = 3'b001;
    localparam SUB = 3'b010;
    localparam DONE = 3'b011;
    localparam EVAL = 3'b100;

    always @(state) begin
        case(state)
            WAIT: begin
                signal = 5'b0_00_1_1;
                done = 1'b0;
            end
            EVAL: begin
                signal = 5'b0_00_0_0;
                done = 1'b0;
            end
            ALTB: begin
                signal = 5'b1_01_1_1;
                done = 1'b0;
            end
            SUB: begin
                signal = 5'bx_10_1_0;
                done = 1'b0;
            end
            DONE: begin
                signal = 5'bx_xx_0_0;
                done = 1'b1;
            end
            default: begin
                signal = 5'b0_00_1_1;
                done = 1'b0;
            end 
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state = WAIT;
        end

        case(state)
        WAIT: begin
            if (start) begin
                state = EVAL;
            end
        end
        EVAL: begin
            if (Beq0)
                state = DONE;
            else if (AltB)
                state = ALTB;
            else
                state = SUB;
        end
        ALTB: begin
            state = SUB;
        end
        SUB: begin
            state = EVAL;
        end
        DONE: begin
            if(!start)
                state = WAIT;
        end
        default: begin
            state = WAIT;
        end
        endcase
    end
endmodule

module gcd_fduc
    #( parameter W = 16 )
    (
        input  clk, rst, start,
        output done,
        input  [W-1:0] inA, inB,
        output [W-1:0] outR
    );
    wire sel_B, en_A, en_B, Beq0, AltB;
    wire [1:0] sel_A;


    gdc_fd #(W) fd_instance
    (
        .clk(clk),
        .rst(rst),
        .sel_B(sel_B),
        .en_A(en_A),
        .en_B(en_B),
        .sel_A(sel_A),
        .inA(inA),
        .inB(inB),
        .Beq0(Beq0),
        .AltB(AltB),
        .outR(outR)
    );
    
    gdc_uc #(W) uc_instance
    (
        .clk(clk),
        .rst(rst),
        .start(start),
        .Beq0(Beq0),
        .AltB(AltB),
        .sel_B(sel_B),
        .en_B(en_B),
        .en_A(en_A),
        .sel_A(sel_A),
        .done(done)
    );
endmodule

    


