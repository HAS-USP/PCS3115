module karatusuba8_uc(
    input  clk, rst, start,
    output x_ld, y_ld, a_ld, b_ld, c_ld, d_ld, e_ld, sub, a_sel, c_sel, done,
    output [1:0] mul_sel, 
    output [2:0] ss_sel
);
// Sua solucao a partir daqui
    
    reg [15:0] signal;
    assign  {x_ld, y_ld, a_ld, b_ld, c_ld, d_ld, e_ld, sub, a_sel, c_sel, done, mul_sel, ss_sel} = signal;

    localparam WAIT = 4'b0000;
    localparam LOAD = 4'b0001;
    localparam S2 = 4'b0010;
    localparam S3 = 4'b0011;
    localparam S4 = 4'b0100;
    localparam S5 = 4'b0101;
    localparam S6 = 4'b0110;
    localparam S7 = 4'b0111;
    localparam DONE = 4'b1000;
    reg [3:0] state;

    always @(state) begin
        case(state)      
            WAIT: begin
                signal = 16'b0_0_0_0_0_0_0_0_0_0_0_00_000;
            end
            LOAD: begin
                signal = 16'b1_1_0_0_0_0_0_0_0_0_0_00_000;
            end
            S2: begin
                signal = 16'b0_0_1_0_1_0_0_0_0_1_0_00_000;
            end
            S3: begin
                signal = 16'b0_0_0_1_0_1_0_0_0_0_0_01_001;
            end
            S4: begin
                signal = 16'b0_0_0_0_1_0_1_0_0_0_0_11_010;
            end
            S5: begin
                signal = 16'b0_0_0_0_1_0_0_1_0_1_0_00_011;
            end
            S6: begin
                signal = 16'b0_0_1_0_0_0_0_0_1_0_0_00_101;
            end
            S7: begin
                signal = 16'b0_0_1_0_0_0_0_0_1_0_0_00_100;
            end
            DONE: begin
                signal = 16'b0_0_0_0_0_0_0_0_0_0_1_00_000;
            end
        endcase
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
           state = WAIT;
        end
        case(state)
        WAIT: begin
            if(start) state = LOAD;
        end
        LOAD: begin
            state = S2;
        end
        S2: begin
            state = S3;
        end
        S3: begin
            state = S4;
        end
        S4: begin
            state = S5;
        end
        S5: begin
            state = S6;
        end
        S6: begin
            state = S7;
        end
        S7: begin
            state = DONE;
        end
        DONE: begin
            if(~start)
                state = WAIT;
        end  
        default: begin
            state = WAIT;
        end
        endcase
    end
endmodule