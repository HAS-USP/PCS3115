// Bruno Albertini
// Testbench para o Karatsuba
`timescale 1 ns / 100 ps
module karatsuba8_tb;
    localparam MAX_CLK_CYLES = 30;
    localparam NUMBER_OF_TESTS = 100;

    reg [7:0] X, Y;
    wire [15:0] Re;

    reg  clk, rst, start;
    wire done;
    wire [15:0] R;

    karatsuba8 dut(clk, rst, start, done, X, Y, R);

    assign Re=X*Y;
    initial begin
        $dumpfile ("karatsuba8_tb.vcd");
        $dumpvars(0, karatsuba8_tb);

        start=1'b0; rst = 1'b1;
        #1 rst = 1'b0;


        for (integer  i = 0;  i <= 8'hff; i = i + 1) begin
            for (integer  j = 0;  j <= 8'hff; j = j + 1) begin
                X = i;
                Y = j;
                #1 start=1'b1;
                #(MAX_CLK_CYLES) if (done==1) begin
                    if (Re==R) begin
                        $display("Acerto %h * %h = %h, esperado %h.", X, Y, R, Re);
                    end else begin
                        $display("Erro %h * %h = %h, esperado %h.", X, Y, R, Re);
                    end;
                end else begin
                    $display("Done não está setado após %d ciclos.",MAX_CLK_CYLES);
                end
                start=1'b0; 
                #1;
            end
        end
        
        $finish; // Não esqueça de terminar a simulação!
    end
    
    // generate the clock
    initial begin
        clk = 1'b0;
	    forever #1 clk = ~clk;
    end


endmodule