module multiplicador_tb #(parameter N=4);

    reg [N-1:0] ai, bi;
    wire [N*2-1:0] se;
    reg clk, rst, start;
    wire done;
    wire [N-1:0] B_in, Q_in;
    wire [N*2-1:0] P_out;
    assign B_in = ai;
    assign Q_in = bi;

    multiplicador #(N) dut(clk, rst, start, done, B_in, Q_in, P_out);

    assign se = ai * bi;

    initial begin
        $dumpfile("multiplicador_tb.vcd");
        $dumpvars(0, multiplicador_tb);

        start = 1'b0;
        rst = 1'b1;
        #2 rst = 1'b0;

        ai = 4'b0111;
        bi = 4'b0101;

        #1 start = 1'b1;
        #30;

        start = 1'b0;
        rst = 1'b1;
        #2 rst = 1'b0;

        ai = 4'b1001;
        bi = 4'b0111;

        #1 start = 1'b1;
        #30;

        $finish; // Não esqueça de terminar a simulação!
    end

    // generate the clock
    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    // monitor for print statements
    always @(posedge clk) begin
        $display("Time=%0t ai=%h bi=%h se=%h P_out=%h done=%b", $time, ai, bi, se, P_out, done);
    end

endmodule