module multiplicador_uc(
     input  clk, rst, start, qlsb, zero,
     output a_rst, a_en, b_en, q_en, cnt_en,
            a_ld, b_ld, q_ld, cnt_ld, done
);

parameter START = 3'b000, EN_LOAD = 3'b001, EVAL = 3'b010, SUM = 3'b011, SHIFT = 3'b100, DONE = 3'b101;

wire clk, rst, start, qlsb, zero;
wire a_rst, a_en, b_en, q_en, cnt_en, a_ld, b_ld, q_ld, cnt_ld, done;
reg [2:0] state;
assign state = START;

always @(posedge clk or posedge rst) begin
    if (rst) begin
          a_rst = 1;
        end
    end else begin
        case (state)
            START: begin
                    if (start)
                         state = EN_LOAD;
                end
            EN_LOAD: begin
                    a_en=1, b_en=1, q_en=1, cnt_en=1;
                    a_ld=1, b_ld=1, q_ld=1, cnt_ld=1;
                    state = EVAL;
                end
            EVAL: begin
                    if (qlsb)
                         state = SUM;
                    else
                         state = SHIFT;   
            end
            SUM: begin
                state = SHIFT;
            end
            SHIFT: begin
                 a_en=1, q_en=1;
                 a_ld=0, q_ld=0;
            end
            DONE: begin
                start <= 0;
            end
            default: begin
                // Do nothing
            end
        endcase
    end
end

endmodule