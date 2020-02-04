#include <iostream>
#include <cstdlib>
#include <string.h>
#include <stdio.h>
#include <cmath>
using namespace std;

int main (int argc, char** argv){
    
    char num[65];

    /* Parse the input */
    for(int i = 0; i < 64; i++){
        num[i] = argv[1][63 - i];
    }
    num[64] = '\0';


    /* Sign determination */
    int8_t sign = 1;

    if(num[63] == '1'){
        sign = -1;
    }


    /* Exponent = exponent - 1023*/
    int exponent;
    for(int i = 62; i > 51; i--){
        if(num[i] == '1'){
    /* Convert every 1 into 2 raised to its place in the exp*/
            exponent += pow(2, i - 52);
        }
    }
    exponent -= 1023;

    /* Mantissa starts with the implied 1 */
    double mantissa = 1;
    for(int i = 1; i < 52; i++){
        if(num[52-i] == '1'){
            /* Convert the mantissa */
            mantissa += pow(2, -i);
        }
    }
    
    double result = mantissa * pow(2, exponent) * sign;
    cout << result << endl;

    return 0;
}