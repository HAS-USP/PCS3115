#include <stdio.h>

// Algortimo de Euclides MDC(a,b)

// Versão recursiva
//  if (b == 0)
//       return a
//   else
// return MDC(b, a % b)
int GCD1( int A, int B) {
    if (B==0)
        return A;
    else
        return GCD1(B, A % B);
}

// Versão iterativa
//  while (b != 0)
//        r = a % b
//        a = b
//        b = r
// return a;
int GCD2( int inA, int inB) {
    int A = inA;
    int B = inB;
    int R;
    while (B!=0) {
        R = A % B;
        A = B;
        B = R;
    }
    return A;
}

// Versão iterativa sem resto
//  while (b != 0)
//        if ( a < b )
//              r = a
//              a = b
//              b = a
//        else
//              a = a - b
//  return a;
int GCD3( int inA, int inB) {
    int A = inA;
    int B = inB;
    int swap;
    while (B!=0) {
        if (A<B ) {// if A < B, swap values
            swap = A;
            A = B;
            B = swap;
        } else 
            A = A - B;
    }
    return A;
}

// Versão apropriada para HW
int GCDHW( int inA, int inB) {
    int done = 0;
    int A = inA;
    int B = inB;
    while ( !done ) {
        if ( A < B ) {// if A < B, swap values
            int swap = A;
            A = B;
            B = swap;
        }
        else 
            if ( B != 0 ) // subtract as long as B isn’t 0
                A = A - B;
            else
                done = 1;
    }
    return A;
}


int main(){
    int a = 4;
    int b = 12;
    int g;
    g = GCD1(a,b);
    printf("gcd(%d,%d)=%d\n",a,b,g);
    g = GCD2(a,b);
    printf("gcd(%d,%d)=%d\n",a,b,g);
    g = GCD3(a,b);
    printf("gcd(%d,%d)=%d\n",a,b,g);
    g = GCDHW(a,b);
    printf("gcd(%d,%d)=%d\n",a,b,g);
    return 0;
}