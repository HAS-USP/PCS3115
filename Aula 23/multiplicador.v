module BinaryMultiplier (
    input [3:0] operand_a,
    input [3:0] operand_b,
    output reg [7:0] result
);

// Internal signals
reg [3:0] multiplicand;
reg [7:0] partial_products [3:0];
reg [3:0] shift_amount;

// Control signals
reg start;
reg [2:0] state;

// State machine definition
parameter IDLE = 3'b000, SHIFT = 3'b001, ADD = 3'b010, DONE = 3'b011;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        start <= 0;
    end else begin
        case (state)
            IDLE: state <= start ? SHIFT : IDLE;
            SHIFT: state <= ADD;
            ADD: state <= shift_amount == 4 ? DONE : ADD;
            DONE: state <= IDLE;
            default: state <= IDLE;
        endcase
    end
end

// Multiplication control logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        shift_amount <= 0;
    end else begin
        if (state == SHIFT) begin
            shift_amount <= shift_amount + 1;
        end
    end
end

// Multiplication data flow
always @(posedge clk or posedge rst) begin
    if (rst) begin
        multiplicand <= 4'b0;
        for (int i = 0; i < 4; i = i + 1) begin
            partial_products[i] <= 8'b0;
        end
    end else begin
        case (state)
            IDLE: begin
                multiplicand <= operand_a;
                for (int i = 0; i < 4; i = i + 1) begin
                    partial_products[i] <= 8'b0;
                end
            end
            SHIFT: begin
                multiplicand <= multiplicand << 1;
                for (int i = 0; i < 4; i = i + 1) begin
                    partial_products[i] <= {partial_products[i][6:0], multiplicand[i]};
                end
            end
            ADD: begin
                result <= result + partial_products[shift_amount];
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

// Input control
always @(posedge clk or posedge rst) begin
    if (rst) begin
        start <= 0;
    end else begin
        if (state == IDLE) begin
            start <= 1;
        end
    end
end

endmodule
