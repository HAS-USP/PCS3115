module multiplicador_fd 
    #(parameter WIDTH=8)    
    (
        input clk, rst, a_rst,
              a_en, b_en, q_en, cnt_en,
              a_ld, b_ld, q_ld, cnt_ld,
        output qlsb, zero,
        input  [WIDTH-1:0] B_in, Q_in,
        output [WIDTH*2-1:0] P_out
    );

    reg [WIDTH-1:0] B_in, Q_in;
    wire [WIDTH-1:0] q_b, q_a, q_s, q_q;

    shiftr_reg #(parameter WIDTH) reg_B(
        .clk(clk),
        .rst(rst),
        .en(b_en),
        .load(b_ld),
        .si(0),
        .d(B_in), 
        .q(q_b)
    );


    shiftr_reg #(parameter WIDTH) reg_A(
        .clk(clk),
        .rst(rst),
        .en(a_en),
        .load(a_ld),
        .si(0),
        .d(q_s),
        .q(q_a)
    );

    shiftr_reg #(parameter WIDTH) reg_Q(
        .clk(clk),
        .rst(rst),
        .en(q_en),
        .load(q_ld),
        .si(q_a[0]),
        .d(Q_in),
        .q(q_q)
    );

    wire [$clog2(WIDTH)-1:0] q_cont, d_cont;
    wire zero;

    counter_dec #(parameter $clog2(WIDTH)) cont(
        .clk(clk),
        .rst(rst), 
        .en(cnt_en),
        .ld(cnt_ld),
        .d(d_cont),
        .q(q_cont),
        .z(zero)
    );

    wire qlsb;
    assign qlsb = q_q[0];

    wire [WIDTH*2-1:0] P_out;
    assign P_out = {q_a, q_q};

    always @(posedge clk or posedge rst)begin
        if(qlsb)
            q_s = q_b + q_a; 
        if(a_rst)
            q_s = 0;
        if(a_ld == 1)
            q_s = 0;
        if(cnt_ld == 1)
            d_count = $clog2(WIDTH)-1;
    end





endmodule
