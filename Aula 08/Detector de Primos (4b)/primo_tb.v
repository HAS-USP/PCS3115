`timescale 1ns/1ns  // Specify the timescale
`include "primo.v"

module testbench;

  // Define os sinais para conectar no módulo 'primo'
  reg [3:0] N;     // Entrada de 4 bits
  wire F;          // Saída que indica se entrada é primo

  // Inicializa o módulo 'primo'
  primo uut (N, F);

  // Geração do teste
  initial begin
    $display("Testando o módulo 'primo' de 0 a 15:");
    // Casos teste
    for (N = 0; N < 15; ++N) begin
      #10; // Delay 10 unidades de tempo
      $display("N = %d, F = %b", N, F);
    end
    #10
    N=15;
    $display("N = %d, F = %b", N, F);
    $finish; // Fim do teste 
  end
endmodule
