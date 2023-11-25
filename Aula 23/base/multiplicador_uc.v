module multiplicador_uc(
     input  clk, rst, start, qlsb, zero,
     output a_rst, a_en, b_en, q_en, cnt_en,
            a_ld, b_ld, q_ld, cnt_ld, done
);

parameter WAIT = 3'b000, EN_LOAD = 3'b001, EVAL = 3'b010, SUM = 3'b011, SHIFT = 3'b100, DONE = 3'b101;

wire clk, rst, start, qlsb, zero;
wire a_rst, a_en, b_en, q_en, cnt_en, a_ld, b_ld, q_ld, cnt_ld, done;
reg [2:0] state;
assign state = WAIT;

always @* begin
     case(state)
          WAIT: begin
               a_en = 0;
               b_en = 0;
               q_en = 0;
               cnt_en = 0;
               a_ld = 0;
               b_ld = 0;
               q_ld = 0;
               cnt_ld = 0;
               a_rst = 0;
               done = 0;
          end
          EN_LOAD: begin
               a_en=1;
               b_en=1;
               q_en=1;
               cnt_en=1;
               a_ld=1;
               b_ld=1;
               q_ld=1;
               cnt_ld=1;
               a_rst = 1;
               done = 0;
          end
          EVAL: begin
               a_en = 0;
               b_en = 0;
               q_en = 0;
               cnt_en = 0;
               a_ld = 0;
               b_ld = 0;
               q_ld = 0;
               cnt_ld = 0;
               a_rst = 0;
               done = 0; 
          end
          SUM: begin
               a_en = 1;
               b_en = 0;
               q_en = 0;
               cnt_en = 0;
               a_ld = 1;
               b_ld = 0;
               q_ld = 0;
               cnt_ld = 0;
               a_rst = 0;
               done = 0;    
          end
          SHIFT: begin
               a_en = 1;
               b_en = 0;
               q_en = 1;
               cnt_en = 1;
               a_ld = 0;
               b_ld = 0;
               q_ld = 0;
               cnt_ld = 0;
               a_rst = 0;
               done = 0;
          end
          DONE: begin
               a_en = 0;
               b_en = 0;
               q_en = 0;
               cnt_en = 0;
               a_ld = 0;
               b_ld = 0;
               q_ld = 0;
               cnt_ld = 0;
               a_rst = 0;
               done = 1;
          end
     endcase
end

     
always @(posedge clk or posedge rst) begin
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
