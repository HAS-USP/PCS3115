module primo(N, F);
    input [3:0] N;
    output reg F;

    reg is_prime;
    integer i;

    always @(N) begin
        is_prime = 1'b1;
        if (N <= 1)
            is_prime = 1'b0; // 0 e 1 não são primos
        else if (N == 2)
            is_prime = 1; // 2 é primo
        else if (N % 2 == 0)
            is_prime = 1'b0; // Números pares sem ser o 2 não são primos
        else begin
            for (i = 3; i * i <= N; i += 2) begin
                if (N % i == 0) begin
                    is_prime = 1'b0; // Se for divisível por i, então não é primo
                    i = N + 1;
                end
            end
        end
        F = is_prime; 
    end
endmodule