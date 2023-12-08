// Bruno Albertini
// Testbench para o GCD
`timescale 1 ns / 100 ps
module gcd_tb
    #(parameter W=8);

    localparam NUMBER_OF_TESTS = 10;
    localparam MAX_CLK_CYLES = 1000;

    reg  [W-1:0] A, B, Re;
    wire [W-1:0] R;

    reg  clk, rst, start;
    wire done;

    // gcd_comportamental #(W) dut (clk, rst, start, done, A, B, R);
    gcd_fduc #(W) dut (clk, rst, start, done, A, B, R);

    function automatic [W-1:0] gcd;
        input  [W-1:0] A, B; 
        reg [W-1:0] Ar, Br, Rr;
        begin
            if (B==0)
                gcd = A;
            else
                gcd = gcd (B, A % B);
        end
    endfunction

    integer ciclos = MAX_CLK_CYLES;
    initial begin
        $dumpfile ("gcd_tb.vcd");
        $dumpvars(0, gcd_tb);

        start=1'b0; rst = 1'b1;
        #1 rst = 1'b0;        

        for (integer i=0;i<NUMBER_OF_TESTS; i=i+1) begin
            A=$urandom%(2**(W-1)-1);
            B=$urandom%(2**(W-1)-1);
            Re = gcd(A,B);
            #1 start=1'b1;

            ciclos = MAX_CLK_CYLES;
            while ((!done) && ciclos) begin
                #1 ciclos=ciclos-1;    
            end

            if (done==1) begin
                if (Re==R) begin
                    $display("Acerto gcd(%d,%d)=%d, esperado %d.", A, B, R, Re);
                end else begin
                    $display("Erro gcd(%d,%d)=%d, esperado %d.", A, B, R, Re);
                end;
            end else begin
                $display("Done não está setado após %d ciclos.", MAX_CLK_CYLES);
            end
            start=1'b0; 
            #1;
        end

        $finish; // Não esqueça de terminar a simulação!
    end
    
    // generate the clock
    initial begin
        clk = 1'b0;
	    forever #1 clk = ~clk;
    end


endmodule