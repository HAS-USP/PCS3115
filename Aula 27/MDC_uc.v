module MDC_uc #(parameter WIDTH = 8) (
    
    input clk, rst, start, beq0, altb,
    output reg sel_B, enB, enA, done,
    output reg [1:0] sel_A

);

localparam WAIT = 2'b00;
localparam ALTB = 2'b01
localparam MDC = 2'b10;
localparam DONE = 2'b11;

reg[1:0] state;

initial begin
    state = WAIT
end

always @(state) begin
    case(state)
        WAIT: begin 
            sel_B = 1'b0;
            sel_A = 2'b00;
            enB = 1'b0;
            enA = 1'b0;
            done = 1'b0;
        end
        ALTB: begin
            sel_B = 1'b1;
            sel_A = 2'b01;
            enB = 1'b1;
            enA = 1'b1;
            done = 1'b0;
        end
        MDC: begin
            sel_B = 1'b0;
            sel_ A = 2'b10;
            enB = 1'b1;
            enA = 1'b1;
            done = 1'b0;
        end
        DONE: begin
            sel_B = 1'bx;
            sel_ A = 2'bxx;
            enB = 1'b0;
            enA = 1'b0;
            done = 1'b1;
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
        if (!beq0 && altb) begin
            state = ALTB;
        end
        else if (!beq0) begin
            state = MDC;
        end
        else begin
            state = DONE;
        end
    end
    end
    ALTB: begin
        state = MDC;
    end
    MDC: begin
        if (!beq0 && altb) begin
            state = ALTB;
        end
        else if (!beq0) begin
            state = MDC;
        end
        else begin
            state = DONE;
        end
    end
    DONE: begin
        if(!start) begin
            state = WAIT;
        end
    end
    default: begin
        state = WAIT;
    end
    endcase
end

endmodule