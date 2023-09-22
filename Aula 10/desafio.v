module solucao (
    input m, 
    input [31:0] int,
    input [15:0] s, 
    output reg [1:0] y);
    // m é a chave geral (sempre da prioridade para o inta, que nesse desafio
    //     corresponde ao int[1:0]).
    // int são os comandos dos interruptores, o vetor está "packed", ou seja, 
    //     int[1:0]=inta, int[3:2]=intb e assim por diante. No total, são 16 
    //     interruptores de 2 bits.
    // s são os sensores, s[0] corresponde ao sensor sa.
    // y é a saída, note que o int é de 2 bits, então a saída também é.

    // Escreva sua solução a partir aqui

endmodule
