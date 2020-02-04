/******************************************
File: sin cos systemverilog

Descript: A program to generate a sin/cos lookup
table in systemverilog that inputs an integer
value and outputs a real sv datatype (64-bit floating
point double precision).

Author: Thomas Snyder
Date: 2/2/2020

******************************************/

#include <stdint.h>
#include <stdlib.h>
#include <cmath>
#include <string>
#include <iostream>
#include <fstream>
using namespace std;


#define PI 3.14159265

union double2int_p {
    double d_val;
    uint64_t b;
};

void generate_sin();
void generate_cos();


int main(){
    generate_cos();
    generate_sin();
    return 0;
}

void generate_cos(){
    cout << "Generating Cosine\n";
        ofstream sv_cos_file;
    sv_cos_file.open("CosDeg.sv");
    sv_cos_file << "module\tCosDeg(input\tsigned\t[7:0]\tdata_in,\n";
    sv_cos_file << "\t\t\toutput real data_out);\n";
    sv_cos_file << "\n\n";
    sv_cos_file << "\talways_comb\n";
    sv_cos_file << "\t\tcase(data_in)\n";
    union double2int_p converter;
    for(int i = -180; i <= 180; i++){
        double result = cos(i * PI / 180);
        converter.d_val = result;

        
        sv_cos_file << "\t\t\t " << i << ": ";
        sv_cos_file << "data_out = 64'b";


        cout << "Encoding: " << result << endl;


        uint64_t base = 1;
        int j;
        for(j = 63; j >= 0; j--){
            sv_cos_file << ((converter.b & (base << j)) >> j);
            cout << ((converter.b & (base << j)) >> j);

        }
        cout << endl;
        // For positive numbers https://gist.github.com/aspyct/3194882
        // Sign bit
        // cout << (converter.b & (base << 63)) << " ";
        // if(((converter.b & (base << 63)) >> 63) == 1){
        //     cout << "Negative\n";
        //     cout << 1 << " ";
        //     sv_cos_file << 1;
        // }else{
        //     cout << "Positive\n";
        //     cout << 0 << " ";
        //     sv_cos_file << 0;
        // }
        // // sv_cos_file << ((converter.b & (base << 63)) >> 63);
        
        // // Exponent
        // for(j = 62; j > 51; --j){
        //     sv_cos_file << ((converter.b & (base << j)) >> j);
        //     cout << ((converter.b & (base << j)) >> j);
        // }
        // cout << " ";
        // //Mantissa
        // for(; j >= 0; --j){
        //     sv_cos_file << ((converter.b & (base << j)) >> j);
        //     cout << ((converter.b & (base << j)) >> j);
        // }
        // cout << endl;
        sv_cos_file << ";\n" << endl;


   
    cout << endl;
    }
    sv_cos_file << "\t\tendcase\nendmodule";
}

void generate_sin(){
    cout << "Generating Sine\n";
    ofstream sv_sin_file;
    sv_sin_file.open("SinDeg.sv");
    sv_sin_file << "module\tSinDeg(input\tsigned\t[7:0]\tdata_in,\n";
    sv_sin_file << "\t\t\toutput real data_out);\n";
    sv_sin_file << "\n\n";
    sv_sin_file << "\talways_comb\n";
    sv_sin_file << "\t\tcase(data_in)\n";
    union double2int_p converter;
    for(int i = -180; i <= 180; i++){
        double result = sin(i * PI / 180);
        converter.d_val = result;

        
        sv_sin_file << "\t\t\t " << i << ": ";
        sv_sin_file << "data_out = 64'b";


        cout << "Encoding: " << converter.d_val << endl;


        uint64_t base = 1;
        int j;
        for(j = 63; j >= 0; j--){
            sv_sin_file << ((converter.b & (base << j)) >> j);
            cout << ((converter.b & (base << j)) >> j);

        }
        cout << endl;
        // For positive numbers https://gist.github.com/aspyct/3194882
        // Sign bit
        // cout << (converter.b & (base << 63)) << " ";
        // if(((converter.b & (base << 63)) >> 63) == 1){
        //     cout << "Negative\n";
        //     cout << 1 << " ";
        //     sv_sin_file << 1;
        // }else{
        //     cout << "Positive\n";
        //     cout << 0 << " ";
        //     sv_sin_file << 0;
        // }
        // // sv_sin_file << ((converter.b & (base << 63)) >> 63);
        
        // // Exponent
        // for(j = 62; j > 51; --j){
        //     sv_sin_file << ((converter.b & (base << j)) >> j);
        //     cout << ((converter.b & (base << j)) >> j);
        // }
        // cout << " ";
        // //Mantissa
        // for(; j >= 0; --j){
        //     sv_sin_file << ((converter.b & (base << j)) >> j);
        //     cout << ((converter.b & (base << j)) >> j);
        // }
        // cout << endl;
        sv_sin_file << ";\n" << endl;


   
    cout << endl;
    }
    sv_sin_file << "\t\tendcase\nendmodule";
}



