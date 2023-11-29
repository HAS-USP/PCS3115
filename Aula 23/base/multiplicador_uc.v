module multiplicador_uc
#(parameter WIDTH=8)
(
     input  clk, rst, start, qlsb, zero,
     output reg a_rst, a_en, b_en, q_en, cnt_en,
            a_ld, b_ld, q_ld, cnt_ld, done
);

localparam WAIT = 3'b000; 
localparam EN_LOAD = 3'b001;
localparam EVAL = 3'b010;
localparam SUM = 3'b011;
localparam SHIFT = 3'b100;
localparam DONE = 3'b101;

reg [2:0] state;

initial begin
     state = WAIT;
end

always @(state) begin
     case(state)
          WAIT: begin
               a_en = 1'b0;
               b_en = 1'b0;
               q_en = 1'b0;
               cnt_en = 1'b0;
               a_ld = 1'b0;
               b_ld = 1'b0;
               q_ld = 1'b0;
               cnt_ld = 1'b0;
               a_rst = 1'b0;
               done = 1'b0;
          end
          EN_LOAD: begin
               a_en = 1'b1;
               b_en = 1'b1;
               q_en = 1'b1;
               cnt_en = 1'b1;
               a_ld = 1'b1;
               b_ld = 1'b1;
               q_ld = 1'b1;
               cnt_ld = 1'b1;
               a_rst = 1'b1;
               done = 1'b0;
          end
          EVAL: begin
               a_en = 1'b0;
               b_en = 1'b0;
               q_en = 1'b0;
               cnt_en = 1'b0;
               a_ld = 1'b0;
               b_ld = 1'b0;
               q_ld = 1'b0;
               cnt_ld = 1'b0;
               a_rst = 1'b0;
               done = 1'b0; 
          end
          SUM: begin
               a_en = 1'b1;
               b_en = 1'b0;
               q_en = 1'b0;
               cnt_en = 1'b0;
               a_ld = 1'b1;
               b_ld = 1'b0;
               q_ld = 1'b0;
               cnt_ld = 1'b0;
               a_rst = 1'b0;
               done = 1'b0;    
          end
          SHIFT: begin
               a_en = 1'b1;
               b_en = 1'b0;
               q_en = 1'b1;
               cnt_en = 1'b1;
               a_ld = 1'b0;
               b_ld = 1'b0;
               q_ld = 1'b0;
               cnt_ld = 1'b0;
               a_rst = 1'b0;
               done = 1'b0;
          end
          DONE: begin
               a_en = 1'b0;
               b_en = 1'b0;
               q_en = 1'b0;
               cnt_en = 1'b0;
               a_ld = 1'b0;
               b_ld = 1'b0;
               q_ld = 1'b0;
               cnt_ld = 1'b0;
               a_rst = 1'b0;
               done = 1'b1;
          end
     endcase
end

always @(posedge clk or posedge rst) begin
     if (rst)
          state <= WAIT;
     case (state)
          WAIT: begin
               if (start)
                    state <= EN_LOAD;
               end
          EN_LOAD: begin
               
                    state <= EVAL;
               end
          EVAL: begin
               if (qlsb)
                    state <= SUM;
               else
                    state <= SHIFT;   
          end
          SUM: begin
                    state <= SHIFT;
          end
          SHIFT: begin
               if(zero == 1)
                         state <= DONE;
                    else
                         state <= EVAL;
          end
          DONE: begin
                    if(~start)
                         state <= WAIT;
                    
          end
          default: begin
               
          end
endcase

end
  
endmodule
